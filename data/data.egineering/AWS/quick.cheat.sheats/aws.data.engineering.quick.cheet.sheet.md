## Data Ingestion
- AWS
    * DMS
    * Kinesis
    * AWS Data Exchange
    * AWS Snow Family
- Azure
- GCP
- On Prem
    * Native Database dump/mirroing/migration tools
    * 3rd Party API consumption
    * Apache Sqoop


## ETL 
- AWS
    * Lambda
    * Glue Spark 
    * Glue Python Shell
    * Glue Studio 
    * Hadoop/Spark Ecosystem EMR
    * AWS Data-Brew
    * Data-Bricks (Partner)
    * RStudio

- Azure
    * App Function
    
- GCP
    * Cloud Function
- On Prem
    * Hadoop/Spark Ecosystem 
    * Apache NiFi


## Data Lake and Data Lake Administration 
- AWS
    - S3
    - Athena
    - Glue
    - RDS
    - Redshift
    - Lake Formation
    - Snowflake (Partner)
- Azure
    - Dynamo DB
- GCP
    - BigQuery
- On Prem
    - Hadoop Ecosystem
        * Hadoop Ecosystem
        * HBase
        * Pig
        * Impala
        * Hive
    


## Automation
- AWS
    * Cloud-Function/Event-Bridge
    * Glue Automation
    * AWS AirFlow
- Azure
- GCP
- On Prem
    - AirFlow
    - Oozie

## AI/ML
- AWS
    * Rekognition
    * Transcribe
    * Comprehend
- Azure
- GCP
- On Prem
    - AirFlow
    - Oozie


## Encryption
- AWS
    * KMS
- Azure
- GCP
- On Prem


## File Optimizations
- Parquet
- Avro

## Business Intelligence Tools 
- AWS
    * Quick-Sight
- Azure
    * Power BI
- GCP
- On Prem

## Data Analysis Tools 
- AWS
    * Glue DataBrew
    * Athena
    * 
- Azure
    * Power BI
- GCP
- On Prem


## Data Gravity
- If data is useful and grows in volume
    * More people will be drawn to it 
    as their daily driver
    * More applications will be used to consume this data
    * More operations will be performed on this data
    * More storage will be required for this data
    * More network bandwidth will be required for this data
    * More administration will be required for this data



# General Data Pipeline flow 


1. consume data
2. deposite data into landing/raw zone
3. optimize file format
4. perform inital ETL(cleasning, verification, etc)
4. partition data
5. move data to clean zone
6. enrich/update data
6. Data Warehousing(including data marts )
7. furter ETL is preformed if required (denormalization/re-normalization)
    - denormalization
    - renormalization
    

# Denormalization 
    - SQL
    - Spark
    - Glue Studio



# Meta-data from unstructured data
1. SQL is insufficient here
2. ML/AI pipelines are required to pull meta daa from unstructured ata



### ML Tools
1. SageMaker
    - SageMaker Ground Truth 
        * Labels data sets
        * Automated labeling
        * Has it's own ML Model for labeling
        * You need lots of data for training....so this is a great tool
    
2. Mechanical Turk
    - Program that employes 500K independent contractors
    that will label items in a data set for you.
   

3. SageMaker Data Wrangler 
    - ETL tool for Data Scientists to further
    process data at the end of the data pipeline
    - Pulls data from any part of the data link
        * S3
        * Redshift
        * Athena
        * Snowflake
        * RDS ?

    - Allows for custom transforms
        * PySpark
        * Pandas

4. SageMaker Clarify 
    * Examines raw data to identify potential bias in 
    data tha is going to be used to train ML models
    * for existence....models for credit risks that are provided data sets that 
    are mostly made up of middle aged people will be biased against younger and older people
    * Is intergrated with Sage Data Wrangler 
    - Data Flow 
        *  



5. Chapter 9: Loading Data into a Data Mart
    * Data lakes are a single source of truth across an organization across 
    multiple lines of Business

    * Querying Data Lakes for domains specific data can be resource intensive and time
    consuming

    * Data Marts are better for queriying Domain Specific data
        - Optimized for Business Intelligence 
    
    * Data Cold Storage Options
        - S3
        - S3 Glacier
            * Intended for long term storage
            * Cannot be directly quiried via Athena or Glue Jobs or Redshift Spectrum(?)
            * Must be retrieved and placed in regular S3 storage in order for it 
            to be quieried
        - S3 Glacier Deep Archive (s3 Glacier Deep Archive)
            * Lowest cost option for long-term data retention

    * Warm Data storage option
        - Typical everyday data
        - Accessed often
        - Does not require particulary low latency
            * Can be batched out
            * Does not have to be streamed 

        - S3 standard
        - S3 Standard-Infrequent Access
        - S3 Intelligent - Tiering (S3 Intelligent Tiering)

    * Hot Data storage option
        - Critical for day-to-day analytics enablement
        - Accessed incessantly day to day
        - Low latency
        - Hi pefromance streaming 
        - Real time analytics 
            * BI
            * Quick Sight
            * Tableau
        - Requires low latency querying when at rest
        - Databases that are optimized for Hot data storage and querying
            * NoSQL (OLTP/OLAP)
                - Dynamo DB
                - ElasticSearch
            * SQL (OLAP)
                - Redshift
                - QuickShight SPICE
        - Does not require particulary low latency
            * Can be batched out
            * Does not have to be streamed 

        - S3 standard
        - S3 Standard-Infrequent Access
        - S3 Intelligent - Tiering (S3 Intelligent Tiering)


### Using a data warehouse as a transactional datastore 

    - Data warehouses are designed to be optimized for OLAP
    - Data warehouses should not be used for OLTP
    - Data warehouses are optimized for append-only queries.  
    - It should not be assumed that just because DW DBs are essentially 
    relational databases, that they would also by default have the following
    featuares
        * Data partioning
        * Data indexing
        * Views(?)



### Using a data warhous as a datalake
    - This is just stupid.
    - Even if DW's have been optimized for insane store 
    and read/appending queries...this is just stupid
    because you would need to structure all of your data
    and you will will have shit write performance.

### Using data warehouses for realtime, record-level use cases

    - DW are optimized to write data in batches
    - DW are not optimized to write data via streams
    - DW should not be used for direct writing of any streaming 
    data
        * IoT
        * Video/Audio streams
        * Realtime telementry like logs

    - It's best to use Kiniesis Firehouse to write to S3 and then 
    have Glue crawlers or Redshift configured for writing the data in batches to 
    the DW via configured buffer theresholds

### Storing unstructured data
    - DW generally are a poor choice for storing unstructured data however 
    some DW DBs have the storage of unstructured(semi-structured) data as a feature 
        * Redshift
    - As always...conscider the data storage engine involved even if storing semi-structured
    data is supported.
        * Highly nested JSON data may be an issue for storage engines even when these engines
        have been optimized for the storage of semi-structed data like JSON

    - Health Care FHIR data is heavily nested JSON.  It's possible to store it 
    in Redshift, you may want consider using a solution designed for that specific data type,
    such as Amazon HealthLake
