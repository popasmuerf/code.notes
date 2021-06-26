## GCP databases......

###GCP SQL
----------
* Cloud SQL
* Fully Managed Relational Database
  * No need to manage, just configure to spec
  * Supports MySQL, PostGRESQL, SQL Server
  * Regional Service providing High Availability (99.95%)
  * Use SSDs or HDDs (For best performance: use SSDs)
  * Up to 416 GB of RAM and 30 TB of data storage
  * Use Cloud SQL for simple relational use cases...use CloudSpanner for bigger jobs(TBs in size)
  * CloudsQL costs less than CloudSpanner
  * Servless


##GCP NOSQL
----------
#### Cloud Datastore

* data is highly scalable NoSQL database for web and mobile applications

*   Automatic harding  and replications 

* ACID trans actions, SQL like quiries, indexes etc.
* Indexing is supported...
* High availability
* Joins and aggragates are not supported(can we simulate joins via "kind" references ?)
* Recommended for data loads less than to a few TB
* schema on write
* export via gcloud only
* slowly being phased out in favor of Firestore
* serverless


#### Cloud Firestore

* Flexible, scalable NoSQL cloud database to store and sync data for client and server-side developement

* Indexing is supported...
* High availability
* Joins and Aggragates are not supported(can we simulate joins via "kind" references ?)
* Recommended for data loads less than to a few TB
* schema on write
* Export via gcloud only.


*   Keeps data in sync across client apps via client apps through realtime listeners

* Offline support for mobile and web allowing for responsibe apps that work regardless of network latency or internet connectivity.
* Seamless integration with Firebase and Google Cloud projects including Cloud Function
* Is more or less a superset in a manner of speaking of Cloud Datastore
* Offline mode supported
* Syncrhonization supported across multiple devices(mobile, IOT etc)
* Serverless


#### Big query

* Exabyte scale modern Datawarehousing solution from GCP
  * Relational database(SQL, schema consistency etc)
  * makes use of SQL like commands(reminicent of Impala)

* Traditional(Storage + Compute) + Modern (Realtime + Serverless)
* Serverless, highly scalable, cost-effectively data warehouse solution
* Stores petabytes of data

*  Run Analytics at scale with 26% - 34% lower three-year TCO than cloud dta warehouse alternatives
* Supports ANSI SQL at blazing fast speeds with zero operational overhead
* Serverless 
* Importing/Exporting Data
  * Formats
    * CSV
    * JSON
    * Avro
    * Parquet
    * ORC
    * Datastsore backup
    * Gzip

*   Automatically expirte data(Configure table expiration)
*   Query external data sources without storing data in BigQuery
    *   Cloud Storage
    *   Cloud Sql
    *   BigTable
    *   Google Drive
    *   Use Permanent or Temporary external tables

*   Access databases via:
    *   Cloud Console
    *   bq cli
    *   BigQuery Rest API
    *   HBase API libraries(Java,.NET, Python)

*   BigQuery on large datasets will get expensive
    *   Use Dry Run option to estimate costs
    *   UI console
    *   bq --dry-run 
  


#### BigTable
* Petabyte scale
* wide column
* HBase API compatible
* Designed for huge volumes of analytical and operational data
  * IOT streams, analytics, Time Series Data
* IS NOT SERVERLESS....you need a VM
* Handles millions of read/write TPS as very low latency
* fully managed scalable NoSQL database service for large analytical and operational workloads
* Consistent sub-10ms latency--handles millions of requests per second
* Ideal for 
  * fintech
  * digital media
  * IoT
  * ad tech
  * personalization
* Seamlessly scale to match your storage needs; no downtime during reconfiguration
* Designed for machine learning applications
* Easily connects to GCP services such as BigQuery

*   Automatic harding  and replications 

* ACID trans actions, SQL like queries, indexes etc.
* Scales natively horizontally so no down time during cluster resizing
* does not spport export from either console or gcloud cli....ther are thirdparty apps that supposedly allow for this.....
* You export via a JAR 
* You export via HBase commands
*  does not use gcloud cli
*  Uses cbt cli
   *  cbt create <table name>
*  


### Memortystore
*   Reduce latency with scalable, secure,and highly available in-memory service for Redis and Memcached
*   Fully managed
*   Server less
*   HA SLA 99%
*   Support for Redis and Memcached
    *   Memcached for Caching
        *   Reference data
        *   database query caching
        *   session store etc
    *   Redis for low latency access with persistence and high availability
        *   Gaming leader boards
        *   Player profiles
        *   In memory streaming






## GCP database scenarios....
| Scenario                                                                                                    | Solution                  |
|-------------------------------------------------------------------------------------------------------------|---------------------------|
| A start up with quickly evolving schema(table structure)                                                    | Cloud Datastore/FireStore |
| Non Relational DB with less torage(10GB)                                                                    | Cloud Datastore           |
| Transactional global database with predefined schema needing to process million of transactions per second  | Cloud Spanner             |
| Cache data(from database) for web application                                                               | MemortyStore              |
| Transactional local database processing thousands of trandsactions per second                               | Cloud SQL                 |
| Database for analytics processing of petabytes of data                                                      | BigQuery                  |
| Database for storing huge volumens stream data from IOT devices                                             | BigTable                  |
| Database for stroing huge streams of tiem series data                                                       | BigTable                  |
|                                                                                                             |                           |






