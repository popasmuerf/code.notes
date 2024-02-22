



# Test Your Streaming Data Solution with the New Amazon Kinesis Data Generator 


1. When building a streaming data solution, most customers want to test it with test data
2. Creating this data and streaming it to your solution can often be the most tedious task in testing the solution.
3. Amazon Kinesis Streams and Amazon Kinesis Firehose enable you to continuuously capture and store terabytes 
of data per hour fromhundreds of thousands of sources.
4. Amazon Kinesis Analytics gives you the ability to use standard SQL to analyze and aggregate this data in real-time.
5. To geenrate a continuous stream of test data, you must write a custom process or script that runs continuously, using the 
AWS SDK or CLI to send test records to Amazon Kinesis.
6. Although this task is necessary to adequately test your solution, it means more complexity and longer developent 
and testing times.  Would'nt it be great if there were a user-friendly tool to generate test data and send it to Amazon Kinesis"



## KDG overview 
The KDG simplifies the task of generating data and sending it to Amazon Kinesis.  The tool provides 
a user-friendly UI tha truns directly in your browser.  With the KDG, you can do the following:

* Create templates that represent records for your specific use cases
* Populate the templates with fixed data or random data
* Save the templates for future use 
* Continuously send thousands of records per second to your Amazon Kinesis stream or Firehose delivery stream 



* KDG is open source and is available on github
* KDG is composed of html and javascript...so "installation" and set up is simply a matter of opening the html landing 
page in any web browser
* Create a record template your data 
* My take : So basically KDG uses Cognito credentials in order to access Kinesis Streams, firehose, or any other AWS service externally
    - Amazon CloudFormation allows you to create 
        * AWS Cognito user associated with your AWS account
        * designate what services your Cognito account will be used to remotely access from KDG

* By default KDG will have peremission to publish data to each Kinesis Data Stream and Kinesis Data firehose.
* This broad access IS NOT appropiate for production settings.
* You have the ability to edit designated IAM roles for your Cognito user or any other user or service in your AWS account
* The IAM roles in question are available under the Resources tab in the resulting CloudFormation stack.
* KDG is a great example of a "mobile" app use case




# Configuring Kinesis Data Firehose for streaming delivery to Amazon S3 

Kinesis Data Firehose is designed to enable you to easily ingest data from streaming sources, and then 
write that data out to a supported target(such as Amazon S3, which we will do in this exercise).  Let's get
started:


2.  -> Kinesis landing page
    2.1 -> Kinesis Data Firehose
    2.2 -> Delivery Stream

3. KDG will be used to send data to firehose
    3.1 source -> Direct PUT
    3.2 destination -> S3

4. Delivery Stream name -> dataeng-firehose-streaming-s3

5. Transform records with AWS Lambda -> disabled
6. Convert record format -> disabled
7. S3 bucket -> dataeng-landing-zone-<initials>
8. prefix split -> streaming/!{timestamp:yyyy}
9. prefix error split -> !{firehose:error-output-type}/!{timestamp:yyyy/MM}
10. -> Buffer hints, compression and encryption
11. Buffer -> 1 MB, Buffer Interval -> 60s
12. -> Create Delivery stream
13. The Kinesis Firehose stream is now ready to recieve datas.


# Configuring Kinesis Data Generateo (KDG) 

- KDG is open source tool from AWS that can be used to generate customized data streams 
and can send that data to Kinesis Data Streams or Kinesis Data Firehose

Here we are using Sakila data models for our mock data.
Our mock streaming data
* Streaming timestamp
* customer data :
    - rented
    - purchased
    - watched trailer
* film_id
* distribution partner name 
* streaming platform
* state the movie was streamed in


1. -> KDG help page : https://awslabs.github.io/amazon-kinesis-data-generator/web/help.html.
2.  -> Create a Cognito user with CloudFormation
3. -> AWS Management console -> CloudFormation -> Create Stack
    3.1 region -> Virginia (us-east-1)
    3.2 -> Next

4. Specify stack details -> Cognito user -> Cognito password

5. -> Configure stack options
6. -> Create stack;  refresh page and monitor it until the stack's status  is : CREATE_COMPLETE
7. -> Outputs tab -> KinesisDataGeneratorUrl (copy this you will need it later)
8. Use the username and password you set as parameters for the CloudFormation template to log into the Amazon KDG portal
9. -> Region -> us-east-1
10. -> Stream/delivery stream -> Kinesis Data firehose instance you created earlier
11. -> Records per second -> 10 records per second
12. -> record template :

{ "timestamp":"{{date.now}}", "eventType":"{{random.weightedArrayElement( { "weights": [0.3,0.1,0.6], "data": ["rent","buy","trailer"] } )}}", "film_id":{{random.number( { "min":1, "max":1000 } )}}, "distributor":"{{random.arrayElement( ["amazon prime", "google play", "apple itunes", "vudo", "fandango now", "microsoft", "youtube"] )}}", "platform":"{{random.arrayElement(["ios", "android", "xbox", "playstation", "smart tv", "other"] )}}", "state":"{{address.state}}" }


 {"timestamp":"{{date.now}}", "eventType":"{{random.weightedArrayElement( { "weights": [0.3,0.1,0.6], "data": ["rent","buy","trailer"] } )}}", "film_id":{{random.number( { "min":1, "max":1000 } )}}, "distributor":"{{random.arrayElement( ["amazon prime", "google play", "apple itunes", "vudo", "fandango now", "microsoft", "youtube"] )}}", "platform":"{{random.arrayElement(["ios", "android", "xbox", "playstation", "smart tv", "other"] )}}", "state":"{{address.state}}" }




13. Send data 
    13.1 Default buffer for 60 seconds
    13.2 Batch data will be written to our Landing Zone S3 bucket 
    13.3 Will stream until KDG is deactivated.

14. Allow KDG to send data 5-10 minutes  -> Stop Sending Data to Kinesis 


During the time that the KDG was running, it will have created 
enough data for us to use in later chapter, 
where we will join this data with data we migrated from our MySQL database.

We can now use Glue crawler to create a table in our dta ctalot for the newly ingested streaming data.




# Adding newly ingested data to the Glue Dat Catalog

We need to run a Glue crawler to examine the newly ingested data, infer the schema, 
and automatically add the dat to the Glue catalog
