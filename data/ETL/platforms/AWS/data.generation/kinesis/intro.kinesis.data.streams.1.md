# Hands on ingesting strteaming data

### Previous summary notes
- We have two options for ingesting streamin data into AWS
    * MSK
    * Kinesis

- Here we are going to go with Kinesis


### What we are going to do in this lab 
- Configure Kinesis Data Firehose to ingest streaming data, and wiret the data out to S3
- Configure Amazon KDG to create a fake source of streaming data



## configuring  Kinessis Data Firehose for streaming delivery to Amazon S3

Kinesis Data Firehose is designed to enalbe you to easily ingest data fromstreaming sources, and 
then write that data out to a supported target (such as Amazon S3, which  we will do in this exercise). 


### Kinesis setup

1. head to the Kinesis landing page 
2. Kinesis landing page 
    - Locate "create new streams"
    - Locate the Kinesis Data Firehose service option
    - Click on Create  delivery stream
3. Delivery Stream config 
    - Source : Direct PUT (we are using KDG)
    - Destination : Amazon S3 
    - Delivery Stream Name : dataeng-firehose-streaming-s3
    - Transform records with AWS Lambda: disabled (We can use this for data validation, or any other ETL task, but we are fine without it for now)
    - Convert record format : Disabled  (we can use this option for transformatino of data fomat to Parquet, ORC, Avro(?), we aren't using it here tho )
    - S3 Bucket : dataeng-landing-zone-mdb
    -  Incoming S3 prefix : streaming/!{timestamp:yyyy/MM/}
    -  S3 bucket error output prefix : !{firehose:error-output-type}/!{timestamp:yyyy/MM/}
    - Buffer size: 1MB 
    - Buffer interval : 60 seconds
    - Create delivery stream 



8. By default, Kinesis Data Firehose writes the data into S3 with a prefix to split incoming data by YYYY/MM/dd/HH.
    -  for our purposes, we want to load streaming data into a streaming prefix
    - We only want to split data by the year and month that it was ingested 
    - S3 bucket prefix: streaming/!{timestamp:yyyy/MM/}
    - for more info on the matter of s3 prefixes : see https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html

9. PUT-S3-3LgtU


10. Expand the Buffer hints, compression and encryption section 
    - S3 buffer conditions allow us to control the parameters for how long kinesis buffers incoming data, before writing it out to our target.
    - We specify both a buffer size in (MB)
    - We specify buffer interval (in seconds)
    - Which every is reached firs (interval or buffer thresholds) whatever that is in the buffer will be written out to S3
    - Example:
        Buffer : 129 MB
        Buffer Interval : 900 seconds (15 minutes)

        if(buffer_size >= 129 || buffer_interval >= 900 )
            writeToS3()

     


## configuraing Amazon Kinesis Data Generator (KDG)

