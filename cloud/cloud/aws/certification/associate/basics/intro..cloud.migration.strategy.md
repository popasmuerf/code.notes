# Cloud migration strategy

- The proportion of IT spending shifting to the cloud is accelerating, with predictions that over 45% of 
    * System infrastructure
    * infrastructure software
    * etc

will be migraged from on-prem to the cloud 

- Migration to the cloud makes your organization more innovative by enableing it to experent and be agile 
- By migrating your digital assets to the cloud,you can
    * Gain insights from your data
    * innovate faster
    * modernize aging infrastructure
    * scale globally
    * restructure organizational models
    * cost reduction (you don't have to manage your own data center)
  

## The three-phase migration process
    * AWS cloud migrations typically executes in three phases
        
#### 1. Assessment phase
    - Assessment is the first phase of cloud migraton 
    - involves feasibility study of your existing on-prem workload to build 
    cloud readienss 
        * cost projections
        * size of your workload to run it in the cloud
    - building the assessment phase that helps you to build a business case for cloud migration
    - AWS acquired TSO logic in 2019 and launched it as the AWS Migration Evaluator, which can gather data from your 
    - [AWS provides a migration evaluation tools] (https://aws.amazon.com/migration-evaluator)
        * produces a Migration Readiness Assessment (MRA) report
        * Use the AWS Adoption Framework (CAF) to build cloud readiness and play your migration strategy
#### 2. Mobileize phase
    * Gap Analysis based on MRA from Assessment phase
    * Best practice to build a baseline envroment
        - Account and user setup 
        - AWS Landing zone for moving your workload
        - AWS provides the Cloud Aoption Readiness (CART) which helps you plan for cloud adoption based onyour 
        migration readiness. [CART](https://cloudreadiness.amazonaws.com/#cart)
        - AWS provides Migration Hub, which facilitates a centralized place for application tracking and migration automation across multiple AWS tools [AWS Migration Hub](https://aws.amazon.com/migration-hub)
     

#### 3. Migrage and modernize phase
    * Follows the Mobilization phase
    * Design
    * Implement (start the migration deployment)
        - workstreams
            * foundation
            * governance
            * migration 
    * [AWS's prescriptive guidance to learn about the all 3 phases](https://docs.aws.amazon.com/prescriptive-guidance/latest/large-migration-guide/phases.html)



NOTE: 
The main difference between SaaS and PaaS is that SaaS describes services
that are 100% managed by the Vendor.  PaaS is a superset of SaaS but requires user management 
and maintenance....basically your custom software and Data.  What we had at LOC was definitely PaaS
PaaS differs from SaaS as in that AWS provides the platform(provisioning, etc), but you have to provide the software
and data.



### Cloud migration patterns - The 7 Rs
There is more than one way to handle migraton.
The following are the 7 Rs of cloud migration patterns defined by AWS 



1. Rehost
2. Re-platform
3. Refactor
4. Relocate
5. Repurchase
6. Retain
7. Retire 

[7 Strategies for Migrating Applications to the Cloud, introducing AWS Mainframe Modernization and AWS Migration Hub Refactor Spaces](https://aws.amazon.com/blogs/enterprise-strategy/new-possibilities-seven-strategies-to-accelerate-your-application-migration-to-aws/)


## IaaS
- virtualiztion
- servers
- storage
- networking
- advantages
    * Flexibility
    * Ease of Provisioning
    * Resources are as ephemeral as need be
    * Complete control of infrastructure
    * Fault tolerance and scalable at awill
    * granular controle (to a degree)
- disadvantages 
    - Security
    - Vendor lockin
    - encryption 
    - little support for legacy systems 
    - training costs 
- Use cases 
    * analytics
    * disaster recovery
    * web hosting 
    * software engineering enviroments
- Examples of AWS IaaS services
    * EC2
    * EBS
    * SAN
    * EFS



## PaaS
- virtualization
- servers
- storage
- networking
- runtime
- middleware
- operating system

- advantages
    * You have granualar and complete control over the software and data
    * Cheaper than going with SaaS
    * High Availability and scalability than on-prem
    * Reduction of LOE in maintaning infrastructure
    * Easier to maintain security policy

- disadvantages 
    * You are pretty much on your own with respect to application maintenance
    * You are pretty much on your own with respect to security
    * You are pretty much on your own with respect to data...this includes PII issues.
    * Your specific runtimes may not be supported by AWS.  for instance...AWS does not support Rust, or D.  
    Support for Go is limited.  Old EOL versions of industry standard runtimes like Java or C# may not be supported
    * Legacy system customization
    * Operational limitations....even though you pretty have full control of your applications and data....what you can achieve 
    with either may be limited by the platform

- Use cases 
    * Data Analytics
    * IoT
    * Business Analytics/Intelligence (BI)
    * Business Process Management (BPM)
    * Databases 
    * API management/development
    * Master Data Management(MDM)

- Examples of AWS PaaS services
    * Elastich BeanStalk
    * Amazon RDS
    * AWS Lambda (FaaS)
    * Amazon Elastic Kubernetes Service 


- Examples of 3rd-Paty PaaS solutions
    * RDS
    * Lambda
    * Glue
    * Kinesis
    * AWS' entire data engineering infrastructure


## SaaS
- virtualization
- servers
- storage
- networking 
- runtime
- middleware
- operating system
- data
- Application 

- advantages
    * Reduces time, money, and effort spent on repetative tasks
    * Managed by Vendor

- disadvantages 
    - Often complex interoperabiility w/r to integration with other services and on prem resources
    - Managed by vendor so customization is often an issue
    - Lack of control which often conflicts with regulartory policies
    - Limite features 
- Use cases 
    * Payroll services like ADP
    * CRM such as Salesforce
    * collaboration solutions like Zoom, Webex, Teams, 365, etc
    * Workspace solutions, like Amazon WorkSpaces, Google Worksspace, Microsfot Workspace 
- Examples of AWS SaaS services
    * Amazon Connect
    * Amazon Workspaces
    * Amazon QuickSight 
    * Amazon Chime

- Examples of 3rd-Paty SaaS solutions
    * Splunk
    * Sendbird 
    * Wilio



Right hand is : 2123 1234 123 1234
Left hand is : 321 4321 321 43212


3017419637


3016331016


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
    * Glue Python Single instance
    * Glue Studio 
    * Hadoop/Spark Ecosystem EMR
    * AWS Data-Brew
    * Data-Bricks (Partner)

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



### Meeting the needs of data scientists and ML models 

-  Identifying non-obvious patterns in data 
- Predicting future outcomes
- Extracting metadata from unstructured data

- Large data sets are requiered to train thes models



### AWS tools used by data sicentists to work with data 

- SageMaker
    * build models
    * train models 

- SageMaker Ground Truth
