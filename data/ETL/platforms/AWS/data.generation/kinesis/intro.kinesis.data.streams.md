# Creating an Amazon Kinesis Data Firehose Delivery Stream 


- You can use the AWS Management Console or an AWS SDK to create a Kinesis Data Firehose delivery stream
to your chosen destination.

- You can update the configuration of your delivery stream at any time after it's creation.
- To update your delivery stream via the firehose console or ``UpdateDestination`` tool.
- Your delivery stream remains in the ``ACTIVE`` state while your configuration is updated, and you can continue to send data.
- The updated configuration normally takes effect within a few minutes
-  The version number of a Kinesis Data Firehose deleviery stream is increased by a value of 1 after you update the configuration.
- It is relected in the delivered Amazon S3 object 



### Source, Destination and Name (components of Kinesis Data Delivery Stream )

1. Sign in to the AWS Management Console and open Kinesis console at :  https://console.aws.amazon.com/kinesis
2. Choose Data Firehose in the navigation pane.
3. Choose Create delivery stream.
4. Enter values for the following fields: 
### SOURCE 
``Direct PUT``
    * Direct PUT : Choose this option to create a Kinesis Data Firehose delivery stream that producer 
    applications write to directly.  Think of this as subscription channel that is written to by the producer.
    * Currently, the following are AWS services and agents and open source servicfes that are integrated with Direct PUT in 
    Kinesis Data firehose :
        - AWS SDK
        - AWS Lambda
        - AWS CloudWatch Logs
        - AWS CloudWatch Events 
        - AWS Cloud Metric Streams
        - AWS Cloud Metric Streams
        - AWS IOT
        - AWS Eventbridge 
        - Amazon SNS
        - AWS WAF web ACL logs
        - Amazon API Gateway - Access logs
        - Amazon Pinpoint
        - Amazon MSK Broker Logs
        - Amazon Route 53 Resolver query logs
        - AWS Network Firewall Alerts Logs
        - AWS Network Firewall Flow Logs
        - Amazon Elasticache Redis SLOWLOG
        - Kinesis Agent (linux)
        - Kinesis Tap (windows)
        - Fluentbit
        - Fluentd
        - Apache Nifi
        - AWS KDG
    
``Kinesis stream`` :
    * Choose this option to configure a Kinesis Data Firehose delivery stream that uses Kinesis data 
    stream as a data source.
    * You can then use Kinesis Data Firehose to read data easily from an existing Kinesis data stream and load it into 
    destinations.
    
    
``Amazaon MSK`` :
    * Choose this option to configure a Kinesis Data Firehose delivery stream that uses MSK as a data source.
    * You can then use Kinesis Data Firehose to read data easily from an existing MSK clusters and load it into specified S3 buckts.

### DELIVERY STREAM DESTINATION 
``.......``
    * The destination of your Kinesis Data firehose delivery stream. 
    * Kinesis Data firehose can send data records to various destinations, including:

    - Amazon OpenSearch Service
    - Amazon OpenSearch Serverless
    - Amazon Redshift
    - Amazon S3
    - Coralogix
    - Datadog
    - Dynatrace
    - Elastic
    - HTTP Endpoint
    - Honeycomb
    - Logic Monitor
    - Logz.io
    - MongoDB Cloud
    - New Relic
    - Splunk
    - Splunk Observability Cloud
    - Sumo Logic



# Testing Your Delivery Stream Using Sample Data

    * You can use the AWS Management Console to ingest simulated stock ticker data
    * The console runs a script in your browser to put sample reocrds  in your Kinesis Data Firehose delivery stream
    * This enables you to test the configuration of your delivery stream without having to generate your own test data
    * The following is an example from the simulated data: 

        {"TICKER_SYMBOL":"QXZ","SECTOR":"HEALTHCARE","CHANGE":-0.05,"PRICE":84.51}

    NOTE : 
    The Standard Amazon Kinesis Data Firehose charges apply when your deivery stream transmits
    the data, but there is no charge when the data is generated.  To stop incurring these charges, you 
    can stop the sample stream from the console at any time. 






