## Data Engineering tools


To build data pipelines, data engineers need to choose the right tools for the
job.  Data engineering is part of the overall bvig
data ecosystem and has to account for the the 
**three Vs** of big data:


    -   Volume:
        *   volume of data has grown substantially.
        *   Moving thousands of records froma database
            requires different tools and techniques
            than movin gmillions of rows or hadling
            millionss of transactions a minute
            
   -   Variety: 
        *   Data enineers need tools that handle a vareity of data
            formats in different locations(databases, APIs, files)
            
   
   -   Velocity: 
        *   The velocity of data is always increasing.  Tracking the 
            activity of millions of users on a social network or the 
            purchases of users all over the world requires data engineers to
            operate often in near real time.
            
            
## Programming languages

    -   SQL
    -   Python
    -   Java
    
    
## Databases

    -   Relational
        *   PostGRE
        *   MySQL
        *   Oracle
        *   Microsoft SQL
    -   Data warehousing
        *   Amazon Redshift
        *   Google BigQuery
        *   Apache Cassandra
        *   Elastic Search
        *   Apache Lucene
        *   Apache Solr



## Data processing engines

    -   Apache Spark
        *   distributed
        *   Makes use of 
            -   RDD
            -   DataFrames
    -   Apache Storm
        *   distributed
        *   Makes use of 
            - Data spouts
            - Data bolts
        *   Apache Flink
            - streams
            - batches
        *   Samza
            - streams
            - batches
        *   Apache Cassandra
        *   Elastic Search
        *   Apache Lucene
        *   Apache Solr
     
     
#   Data Pipelines

-   Apache Airflow
    * Worflow management
      orginally created by AirBnb
    
-   Apache NiFi
