

/**
  *
Created by mbrown on 7/5/16.
Copyright (c) 2016, NETWORK DEFENSE PROGRAM
All rights reserved.
 
Redistribution and use, with or without modification, are permitted provided that the following conditions are met:
 
1. Redistributions of this data must retain the above copyright notice, this list of conditions and the following disclaimer.
 
2. Redistributions requires prior consent NETWORK DEFENSE PROGRAM.
 
3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */

package mil.darpa.netdefense.network.gAnomaly

import org.apache.spark.rdd.RDD
import org.apache.spark.sql.DataFrame
import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.sql.hive.HiveContext
//import hiveContext.implicits._
object gAnomalyDriver {
  def main(args:Array[String]): Unit ={
    val conf: SparkConf = new SparkConf().setAppName("gAnomaly_app")
    val sc: SparkContext = new SparkContext(conf)
    val hiveContext: HiveContext = new HiveContext(sc)
    import hiveContext.implicits._
    import hiveContext.sql
    val lamda: Double = 0.1 //--> Needs to be configured by user
    val gamma: Double = 0.5 //--> Needs to be configured by user
    val dataDf: DataFrame = sql("SELECT " + args(4) +  " FROM " + args(0) + '.' + args(1))
    val data :RDD[(String, String, String, String)] = dataDf.map(line =>(line.getString((0)), line.getString(1), line.getString(2), line.getString(3)))

  }
}
