[source](https://docs.aws.amazon.com/redshift/latest/dg/tutorial-loading-data.html)
[source](https://www.chaossearch.io/blog/when-to-deploy-aws-redshift-or-athena-use-cases)

AWS Redshift is based on teh popular open-srouce Postgre SQL database application, but was
designed to deliver more scalabilityand cost-efficiency than a self-hosted PostgreSQL instance 
by leveraging cloud data stargage and computer resources.

So basically Redshift is just AWS managed PostgreSQL. 

So if it is just PostGRES.....then why use it ?   I guess for the same reason 
you would use any RDS...but you need an RDS that is optimized for leveraging cloud and data
storage and computer rescources Z?


### Typical processing flow in Amazon Redshift




        {Operational Systems} --------->
        {Marketing data sources} ------>   {amazon s3} -----> {ETL engine} ------>  {Amazon Redshift} 
        {Other source systems} -------->



        {Datashares} <----------Redshift data sharing-------------------------------->
        {S3 data lake} <--------Redshift Spectrum------------------------------------>
        {Relational databases} <---Redshift federated query-------------------------->    {Amazon Redshift} 
        {Amazon SageMaker} <----Redshift ML------------------------------------------>




### Key features of Amazon RDS:

1. Multi-AZ Deployments :
- RDS provides high availability with Multi-AZ deployments
- Automatically replicating your database across different availability zones 

2. Read Replicas: 
- You can improve read scalability by creating read replicas in different regions
- distributing read traffic and reducing the load on the primary database


3. Automated Backups and Snapshots




### Amazon Redshift

- Fully managed data warhousing service designed for high-performance analysis using 
standard SQL queries
- Optimized for complex queries and large-scal data  analytics
- Ideal choice for data warehousing and business intelligence applications.

1. Columnar Storage 
    - Stores data in a columnar format, enabling faster query performance for analytical 
    workloads by reading only the necessary columns.
    - Massively Parallel Processing (MPP) : Redshift uses MPP architecture to 
    parallelize and distribute queries across multiple nodes, enchancing query 
    performance for large datasets 

    -  Integration with BI tools :  Redshift sealessly integrates with popluar 
    BI tools such as 
        * Tableau
        * Looker
        * Power BI 



## Differences and Use Cases 

1. Performance and Use Cases
    - RDS is suitable for transcation workloads and applications where traditional relational databases are required.
    - Redshift excels in analytical workloads, data warehousing, and scenarious where high-performance querying of large
    data sets are crucial.



2. Data Mdoel:
    - RDS supports various relational database engines, adhering to tradtional relational data models
    - Redshift is optimized for analytical processing  and works well with denormalized data models.


3. Scaling 
    - 

Redshift is delivered by AWS as a fully managed data warehous service.  AWS customers can start
using Redshift by provisioning one or more Amazon Redshift clusters.  There's also a serverless
deployment option that can helpo AWS customers get insights from data without having to provision and manage data warehouse infrastructure.


Each Redshift cluster consists of one or more compute nodes hosting a query engine and one or 
more databases.  Redshift query engiens can be orchestrated to run queries on specific databases or across multiple clusters at once.  An EGL engine like AWS Glue might be used for loading the data from a variety of data sources 
    * Streaming data
    * databases 
    * data lakes
    * etc.

into Redshift clusters 



## What is AWS Athena 


AWS Athena is a cloud=-based data analytics service that lets you run interactive queries against data stored in
    - S3
    - 
* Athena is based on OSS Presto analytics engine
* Can query any type of data that exists in S3 buckets, even if the data is unstructured
* Athean is serverless because it requires no infrastructure set up or management on the part of users.



            {Operational databases}-------------
                                                |
                                                |
            {Data warehouses}-------------------
                                                |
                                                |                                      ------->{ML tools}
            {Big data}--------------------------                                      |
                                                |                                     |
                                                |                                     |
            {ERP}----------------------------------------->{Amazon Athena}<------------
                                                |                                     |
                                                |                                     |
            {Other cloud infrastructure         |                                     |
            and platform servers}---------------|                                      -------->{BI and analytic app tools}
                                                |
                                                |
            {S3}--------------------------------





## Main Differences between Redshift and Athena

- Data structure 
    * Best for  structured data persistence  and anlysis
        - Winnde : Redshift 
    * Best for the querying and analysis of unstructured data that might exist in a datalake
        - Winner : Atehna

- Data location

    * All data that you want to analyze via Redshift must  be stored within Redshift clusters.
    So if you want to analyze data, you need to move it into Redshift first. Athena is different
    as in it allows you to analyze data that exists in S3, without any data movement required.
        - Winner : Redshift




- Setup Time
    * With Redshift you need to wait for your clusters to initialize before you can 
    begin running queries.  This can take a significant amount of time.  There is no 
    waiting, because you don't have to move or initialze any data.   
        - Winner : Athena  


- Partitioning 
    * Redshift and Athena both provide partititioning functionaligy (shich speed up queries by limiting the 
    amount of dat that each query scans) You can just start running
    queries (that speeds up queries by limiting the amount of data that wach query scans), but in different 
    ways.  Athena partitioning is more flexible and open-ended  because you can define partitions based on any key.  This means that
    it iseasier to acheive high performance in Athena by optimazing partitioning :
        - Winner: Athena

- Pricing and cost
    * Although it's not necessarily the case that Athena costs less Redshift, Athena pricing
    is simpler because you pay a flat fee (currently $5 per terabyte) based ont he amount of data you
    scan.  Reshift pricing veries depending on cluster configuration, hourly run time and other factors,
    making it more difficult to know ahead of time what your ultimate cost will be 
        - Winner :  It depends



## Example Use Cases for Redshift vs Athena 

- Event log analytics :
    Cloud application and event logs are an example of structured, consistent data 
    that is easy to analyze within Redshift clusters 

- Real-time Analytics 
    AWS Redshift can be integrated with data stream processing services like Amazon Kinesis to 
    enable near real time analysis of large-scale data streams

- Business Intelligence 
    WS Redshift is a good solution if you need to store and analyze specific types of business data,
    including financial reports, marketing/sales data, and customer information. Since this data is 
    relatively structured, you can fit it into Redshift clusters without difficulty.

- Querying cloud service logs
    Amazon CloudWatch is a service that enables cloud observability by collecting and visualizing log
    data from other cloud services, resources, and applications deployed on AWS. Amazon CloudWatch logs
    can be stored in Amazon S3 buckets, making it possible for you to run queries on the log data with
    Amazon Athena and achieve better CloudWatch log insights.

- Performance troubleshooting
    Since Athena lets you execute ad-hoc queries quickly and without having to prepare any data, it's handy 
    in situations where you need to query a log file or stored inside S3 on a one-off basis – as opposed to 
    performing systematic log analytics, in which case Redshift may be a better fit.


- Querying S3 security data lake
    You can build a security data lake in the cloud by ingesting security logs into Amazon S3 and indexing them
    for searchability and long-term storage. Amazon Athena lets you run ad-hoc queries on your security data 
    lake to support security operations and threat hunting use cases.

- Exploring S3 data 
    Athena can come in handy if you have large amounts of data inside S3 buckets and aren't sure exactly what that data
    is or how it's organized. By running Athena queries, you can gain visibility into your S3 data.