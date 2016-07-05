/*
 * Copyright © 2016 NETWORK DEFENSE CONSORTIUM
 * All rights reserved.
 *
 *    Recipients are granted the nonexclusive rights to reproduce, distribute, prepare derivative works and display this
 *    work of authorship (data) subject to the following conditions:
 *
 *    1. Distributed copies of this data, including derivative works, must conspicuously include the above copyright
 *    notice and the conditions and disclaimer below.
 *
 *    2. Distribution of this data requires prior consent of the copyright holders.
 *
 *    3. This software was developed exclusively with United States Government funding provided by the Defense Advanced
 *    Research Projects Agency.  Neither the names of the copyright holders nor the United States Government may be used
 *    to endorse or promote products derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
 * EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
 * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.  NEITHER THE COPYRIGHT HOLDERS NOR THEIR AGENTS OR CUSTOMERS, INCLUDING
 * THE UNITED STATES GOVERNMENT, AUTHORIZE OR CONSENT TO RECIPIENTS OF THIS SOFTWARE INFRINGING ANY U.S. PATENT OR
 * COPYRIGHT.
 */

package mil.darpa.netdefense.network.gAnomaly

import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf
import org.apache.spark.rdd._
import org.apache.spark.graphx._
import org.apache.spark.mllib._
import breeze.stats.distributions._
import org.apache.spark.sql._
import org.apache.spark.sql.hive.HiveContext
import org.apache.spark.rdd.RDD
import org.apache.spark.HashPartitioner


object gAnomalyMain {
	def reducer(line:((Int,Int),(Int,Int))):(Int,Int)={
		return (line._1._1+line._2._1,line._1._2+line._2._2)
	}
  
	def main(args: Array[String]){
		val conf: SparkConf = new SparkConf().setAppName("gAnomaly_app")
    val sc: SparkContext = new SparkContext(conf)
    val hiveContext: HiveContext = new HiveContext(sc)
		import hiveContext.implicits._
		import hiveContext.sql

		//Load in edge list as RDD
		//data:
		//0=Time
		//1=IP_src
		//2=IP_dst
		//3=Attr1_src
		//4=Attr1_dst
		//5=Attr2_src
		//6=Attr2_dst
		val lamda = 0.1 //--> Needs to be configured by user
		val gamma = 0.5 //--> Needs to be configured by user

		//	val data = sc.textFile("C:/Users/meslami/Desktop/Projects/CERTAIN/Python Scripts/test_graph.csv").map(line=>line.split(","))

	//	val dataDf = sql("SELECT sourceaddress, source_country, destinationaddress,destination_country  FROM " + args(0) + '.' + args(1)) 
    val dataDf = sql("SELECT " + args(4) +  " FROM " + args(0) + '.' + args(1)) 


		val data :RDD[(String, String, String, String)] = dataDf.map(line =>(line.getString((0)), line.getString(1), line.getString(2), line.getString(3)))

		//Get the attributed nodes
//		val attrValue = "United States"
    val attrValue = args(5)
		val data2 = data.flatMap(line=>Array((line._1,(line._2)),(line._3,(line._4))))//Flat Map so that you can combine src/dst IPs
		.reduceByKey((a,b)=>a)//Reduceby key to get the unique IPs and reduce the attributes so that you only store 1
		.map(line=>(line._1,(line._2)))//Map it (String,(String,String))=(IP,(Attr1,Attr2))
		.map(line=>(line._1,(if(line._2 == (attrValue)) 1 else 0,if(line._2 !=(attrValue)) 1 else 0)))

		//    data2.saveAsTextFile("data2")
		//Make a Node to ID mapping with a long  
		val tmpNodeToID = data2.map(line=>line._1).zipWithIndex()
		val numRows = tmpNodeToID.count()

		tmpNodeToID.saveAsTextFile("tmpNodeToID")

		val nodeToID = sc.textFile("tmpNodeToID")
		.map(line => line.trim().split(",")).map(line=>(line(0),line(1)))
		.map(line=>(line._1.replaceAll("""\(""",""),line._2.replaceAll("""\)""","").toLong))

		//    val nodeToID =  tmpNodeToID.map(line=>(line._1,line._2))
		//Initializations
		//Assuming everything that has attribute is in foreground and does not have attribute in background
		//Compute the probabilities theta_0 and p_0.  Note that initially theta_0=p_0, and theta_1=p_1 (1-theta_0)
		val initial_probs = data2.map(line=>(line._2._1,(line._2._1,line._2._2)))//make RDD of (Layer,Has_Attr_Value,No_Attr_Val)
		.reduceByKey((a,b)=>(a._1+b._1,a._2+b._2))//count all of the IPs with the attribute  
		.map(line=>(line._1,(if (line._1 == 1) line._2._1.toDouble/numRows.toDouble else line._2._2.toDouble/numRows.toDouble )))//prob of distribution over attribute GIVEN layer. (Layer,(p_have_attr,p_not_have_attr))   
		.collect()

		//    sc.parallelize(initial_probs).saveAsTextFile(args(2))
		//initial_probs.saveAsTextFile("initial_probs1")

		val theta_0 = initial_probs(0)._2
		val p_0 = initial_probs(0)._2


		//Flip the node to ID mapping for GraphX and put in all the attributes of the node
		//(ID=Int,(1-IP=String,2-Attr1a=Int,3-Attr1b=Int, 4-Layer = Int, 5-Layer_Prob= Double, 6-P_attr_Layer1 = Double, 7-P_attr_Layer2 = Double 
		var IDToNode = nodeToID.join(data2).map(line=>(line._2._1,(line._1,line._2._2._1,1-line._2._2._1,line._2._2._1,theta_0,p_0,1.0-p_0)))

		//RDD[Edge[Double]]
		//Define the edge RDD
		val edges = data.map(line => (line._1,line._3))
		.join(nodeToID) // FORMAT: (srcIP,(dstIP,srcIP_ID))
		.map(line => (line._2._1, (line._1, line._2._2))) //// FORMAT: (dstIP,(srcIP,srcIP_ID))
		.join(nodeToID) // FORMAT: (dstIP,((srcIP,srcIP_ID),dstIP_ID))
		.map(line => (line._2._1._2,line._2._2,line._2._1._1,line._1)) //FORMAT:srcIP_ID,dstIP_ID,srcIP,dstIP 
		.map(line=>Edge(line._1,line._2,1.0))


		//create graph
		var graph = Graph(IDToNode,edges).cache()

		val numNodes = graph.vertices.count()
		//Begin the code for gAnomaly

		//Begin Gibbs Sampling iterations
		//1-Compute layer probabilities given attribute using w(i) equation - DONE
		//2-Regularize with neighborhood - DONE
		//3-Resample to get new assignment
		//4-Recompute attribute probabilities
		//5-Repeat from (1)
		var x = 0
		val label_indices = Array(1,0)
		for( x <- 1 to 50 ){
			//Compute probability of being in a layer given the node's attributes.  
			//Note that I am only computing one probability as the second one is just 1-p
			//(ID=Int,(1-IP=String,2-Attr1a=Int,3-Attr1b=Int, 4-Layer = Int, 5-Layer_Prob= Double, 6-Pattr_Layer1 = Double, 7-Pattr_Layer2 = Double
			graph = graph.mapVertices((id,line)=>(line._1,line._2,line._3,line._4,
					line._5*(math.pow(line._6, line._2)*math.pow(1-line._6, line._3))/(line._5*(math.pow(line._6, line._2)*math.pow(1-line._6, line._3))+(1-line._5)*(math.pow(line._7, line._2)*math.pow(1-line._7, line._3)))
					,line._6,line._7))
          
 //     graph.vertices.filter(_._2._1 == "124.8.80.132").saveAsTextFile("tmpfl"+x) //(line=> line.contains("124.8.80.132"))     
      //(_._1 == "124.8.80.132").saveAsTextFile("tmpfl"+x) //.equals("124.8.80.132")).saveAsTextFile("tmpfl"+x)
 //         graph.vertices.saveAsTextFile("grapha" + x)

					//Run the average regularizer
					//Get the neighbors of each node and extract out the probability                   
					var reg_mean = graph.collectNeighbors(EdgeDirection.Either).map{case(id,array)=>(id,array.flatMap(line=>Array(line._2._5)))}
			//ID = Node ID, tuple._1 = layer probabilities of neighbors, tuple._2._5=layer probability of current node
			//Join the neighbor list with info of current IP, subtract array probs from current vertex prob, raise to power of two, divide by # of neighbors, sum it all up
			.join(IDToNode).map{case(id,tuple)=>(tuple._1.map(line=>math.pow(tuple._2._5-line,2.0)/tuple._1.length).reduce(_+_))}.reduce(_+_)               

			var reg_min = graph.collectNeighbors(EdgeDirection.Either).map{case(id,array)=>(id,array.flatMap(line=>Array(line._2._5)))}
			//ID = Node ID, tuple._1 = layer probabilities of neighbors, tuple._2._5=layer probability of current node
			//Join the neighbor list with info of current IP, subtract array probs from current vertex prob, raise to power of two, divide by # of neighbors, find the minimum
			.join(IDToNode).map{case(id,tuple)=>(tuple._1.map(line=>math.pow(tuple._2._5-line,2.0)).reduce((a,b)=>math.min(a, b)))}.reduce(_+_)
			//Compute entropy regularizer                  
			var reg_entropy_have = graph.vertices.map(line=>math.log(line._2._5)*line._2._5).reduce(_+_)
			var reg_entropy_not  = graph.vertices.map(line=>math.log(1-line._2._5)*(1-line._2._5)).reduce(_+_)

			//Sample a uniform distribution that will be used in the resampling of the label

			//Update the probabilities with the regularizer and sample using the bernoulli distribution
			val x_random = math.random
			 graph = graph.mapVertices((id,line)=>(line._1,line._2,line._3,line._4,
					(line._5-lamda*reg_mean+gamma*reg_entropy_have)/(1-2*lamda*reg_mean+gamma*reg_entropy_have+gamma*reg_entropy_not),line._6,line._7))
					.mapVertices((id,line)=>(line._1,line._2,line._3,if(Bernoulli.distribution(line._5).draw()) 1 else 0,line._5,line._6,line._7))
          
          
          
				var new_attr_probs =	graph.vertices.map{case(id,line)=>(line._4,(line._2,line._3))}
			.map{case(l,v)=>{label_indices.map(k=>if(l==k)v else (0,0))}}
			.reduce((a,b)=>a.zip(b).map(line=>reducer(line)))
			.map(line=>(line._1.toDouble/(line._1.toDouble+line._2.toDouble),line._2.toDouble/(line._1.toDouble+line._2.toDouble)))
			//Recalculate the probabilities of having the attribute and being in a certain layer
			graph = graph.mapVertices((id,line)=>(line._1,line._2,line._3,line._4,line._5,new_attr_probs(0)._1,new_attr_probs(1)._1))

		} 
		graph.vertices.map(line =>(line._2._1,line._2._2,line._2._4,line._2._5,line._2._6,line._2._7))
		.map(line => line._1 + ',' + line._2.toInt + ',' + line._3.toInt + ',' + line._4.toDouble + ',' + line._5.toDouble + ',' + line._6.toDouble)
		.saveAsTextFile(args(2))

		sql("DROP TABLE IF EXISTS " + args(0) + "." + args(3))
		sql("create external table if not exists " + args(0) + "." + args(3) + "(ip string,Have_attr int,Layer int,Layer_Prob double, Have_attr_Layer0 double, Have_attr_layer1 double) row format delimited fields terminated by ',' location '" + args(2)+"'")

	}
}