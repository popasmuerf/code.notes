# Redshift ardhitectue review and storage dep dive



- Every copute node is split into either
    * 2 slices
    * 4 slices
    * 16 slices
- Each slice is allocated a portion of the node's memory and sorage and wors as an 
independent worker, but aowrking in parallel with the other slices

- Slices store different columsn of data for large tables
- The data for each column is persisted as 1 MB immutable blocks, and each 
column can grow independently

- When a user runs a query against Redshift, the leader node 
    * Create a query plan
    * allocates wor for each slice
    * slices execute the work in parrallel
    * Queries of course then are only as good as their slowest partition


## Data distribution across slices 

                                                            --------[Block-1]
                                                            |
                                                            |
                                                            |
                                            |-----------[column-1]
                                            |               |
                                            |               |
                                |----------[disk-1]           |-------[Block-2]
                                |             |
                                |             |
            |---------------[slice-1]        |-----------[column-2]
            |                  |
            |                  |
        [compute node]         |----------[disk-2]
            |
            |
            |---------------[slice-2]



For maxium performance all data and processing of data should be evenly distributed 
throuought the cluster and on each node, throought it's slices and disks


### Suported Redshift Distribution regimes
* EVEN
    - for large tables 
    - data is evenly distributed across all slices in round-robin fasion 
* KEY
    - For large tables 
    - Uses hash tables 
* ALL 
    - Minium dimension tables
    - Optimizes JOIN operations



NOTE: Do some research on Redshift technical deep dives and how to configure for performance based
on your use case, along with schema engineering



### Using manifest files as pipelie triggers

- Manifest files are used for shipping cargo
    * Meta data for shipment inventory

- Manifest files are used also in Data Engineering 
    * Manifest files are sent with data
    * Data providers should send manifests but they may not
    or refuse to, so you might have to create the manifest yourself
        - If you have to create a manifest yourself then you 

    * Manifests can be used for data verification via 
        - Inlcuding hash SHA-256 values for coresponding files that are listed
        in the manifest file
        - A trigger can be configured for logic that handles bad data as well 
        as verified data

### How do yo uhandl the failures of a step in your pipeline ?


    - Data quality issues
    - Code errors
    - Endpoint errors
    - Dependency errors


### Pipeline failure retry startegies


## Examination the options for orchestrating pipelines in AWS 
    - AWS Step Function
    - AWS Managed Workflows for Apache Airflow (MWAA)
    - AWS Data Pipeline

## AWS Data Pipeline for managing ETL between data sources 
    - AWS Data Pipeline is an old services
    - AWS Data Pipeline having being originally released in 2012
    - AWS Data Pipeline, you can
        * extract
        * transform
        * load data 
    web etween certain AWS data sources  and 
    even on-premises data sources.

    - To use this service you define your 
    data sources, sechedule transfrom activities, 
    and select a data target for writing to.

    - Data Pipleine will then manage the scheduling
    of the pipeline, automaticallyprovisin the required 
    AWS resources (suc as an EMR cluster), and 
    enable you to monitor pipelines with configuratble retry
    logic and alerting.

    - The following AWS data services are supported as
    sources and targets by Data Pipeline: 

        * AWS DynamoDB
        * AWS Relational Database Systemd (RDS)
        * AWS RedShift
        * AWS S3

    - Data Pipeline is able to read adn write to other
    JDBC data stores, such as an on-premises database.

    - The following compute services can be used to 
    run jobs to transform your data: 

        * Amazon EC2
        * Amazon EMR
        * On-premises compute resources (by installing the 
        Java-based Data Pipeline task runner software)


    - If you review the AWS documentation regarding Data Pipeline service
    it hasn't been updated since 2018.
        - The taskrunninger is only supported by Java 6 and Java 8 
        - The Data Plipeline service is only suppored in five AWS regions 
        
    - AWS Pipeline is basically EOL, and maybe it's best not to use it.


## AWS Glue Workflows to orchestrate Glue resources 
    - AWS Glue Workflows is part of the overall Glue service
    - Glue Workflows can be used to build a data pipeline consisting
    of Glue components
        * Glue Crawlers
        * Glue Spark jobs
        * Glue Python jobs

    - If you are only using Glue components...then Glue Workflows make sense.
        * Example of an All Glue pipeline use case 
            - Glue Crawler to add CSV files tha have been 
            ingested to a new partition to the Glue Data Catalog
            - Glue Spark Job to read te new data using the catalog, and then
            transform the CSV files into Parquet files.
            - Glue Crawler to add the newly transformed parquet files to the Glue 
            Data Catalog
            - Run two Glue jobs in parallel.  
                * One Glue job aggregates data and wries the results into 
                DynamoDB table
                * One Glue job creates a newly enriched dataset that joins the new
                data to an existing rference set of data 
                * Run another Glue Crawler to add the newly enriched
                dataset to the Glue Catalog.    
                * Run another Glue Cralwer to add the newly enricched
                dataset to the Glue Catalog
                * Run a Glue Python Shell job to send a notification 
                about he success or failure of the job

        * While a fairly complex data pipeline can be created using Glue workflows (as shown here),
        many use cases require the use of other AWS services, such as
            - EMR
                * Hive jobs
                * Impala jobs 
                * Writing files to an SQS queue
            - Glue Workflows does not support integration with non-Glue 
            services directly, it is possible to run a Glue Python
            Shell job tht uses the Bot3 Library to interact with other AWS services.
            - Glue does not generate any events from Glue Workflows
                * Events are generated from individual Glue jobs
                    - Glue Job State Change 
                        * SUCCEEDED
                        * FAILED
                        * TIMEOUT
                        * STOPPED 

            - Using Amazon EventBridge you can automate actions to take place
            when a new event and status you are interesed in is generated.
                * EventBridgte can consume Glue Job Event signals like FAILED
                that then triggers a lambda function to run and send email notification
                and or generate log files to be consumed by some SIEM tool tool like 
                Splunk or Elastic Search

        
## Triggering Glue Workflowws
    - General Mechanisms for triggering Glue WorkFlows
        * Event
            * Number of events till execution is supported
            * Time delays
            * Time span 
        * Ad Hoc (on-demand)
        * Schedulied 
            



## Apache Airflow as an open Source orchestration solution 
    - Features (not exhaustive)
        *  user interface
        * logging
        * alerting
        * stateful scheduling
    - DAG based
        * No circular task automation allowed

### Airflow Connections and Hooks
    - Define how to connect to remote source and target systems
        * databases
        * other random shit

    - Canned Hooks are available for most common use cases

    - Custome hooks are an avaiable feature 
        * For instance I need a hook to a workflow 
        component that doesnt' currently

    - Airflow community provides many open source hooks

    - Airflow Connections may or may not use hooks
    - Airflow Connections provide for a way to connect
    to workflow components. 
        * URL
        * credentials
    - Airflow Connects are also canned and custom 

    - Airflow tasks 
        * compnents of the DAG
        * Actually do all teh work
        * tasks have states of being
            - None
            - Scheduled
            - Queued
            - running
            - Success
            - Failed

    - Airflow operators
        * predefined task templates
            - Bash Operator
            - Python Operator
            - JdbcOperator
            - S3FileTransformOperator
            - S3toRedshiftTransfer
            - DockerOperator
            - Airflow Sensors
                * Special kind of operator that only executes based on 
                some event

    - Aifrlow can actually integrate services between cloud services and on-prem 



### AWS Step Function for a serverless orchestration solution

    - AWS Step Function
        * is a comprehensive serverless
        orchestration service that uses low-code 
        to develop data pipelines and servless applications.
        * Visual design tool that allows you to create pipelines with a 
        simple dra and drop approach.
        * Implementation of Step Function Workflows is avaiable via ASL (Amazon States
        Language)
        * Makes it easy to specify how to handle the failure of astate with
        custome retry policies via catch blocks

    - Example of a Step Function WorkFlow Diagram 






        [start]----> [lambda:validate Manifest]---->[Convert CSV to Parquet]---->[Parallel]
            ----> [lambda:summarize to DynamoB] ---
                                                    |----> 
            ----> [glue:Enrich dataset]         --- 

                            /-----> [success]
            ----> [Choice]
                            \----> [lambda: send failure notification] ----> [fail]



### Pros and cons of using StepFunction

    - Pros
        * Fully managed
        * Low code

    - Cons
        * No Native functionality for resuming pipelines 
        from points of failure
        * No support for third party (outside of AWS) workflow component
        workflow integration