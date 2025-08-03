Kinesis
-----------
1. agents
2. stream capture
3. stream caputure and analytics
4. video/audio streaming 


## Most Use Cases
Web Streaming API ----> Kinesis FH(maybe process ?) ----> S3, redshift, Splunk, ELK, whatever
Kinesis Agent  ----> Kinesis FH(maybe process ?) ----> S3, redshift, Splunk, ELK, whatever


## Low Latency Use Cases
Web Streaming API ----> Kinesis DataStreams(maybe process ?) ----> S3, redshift, Splunk, ELK, whatever
Kinesis Agent  ----> Kinesis DataStreams (maybe process ?) ----> S3, redshift, Splunk, ELK, whatever

Web Streaming API ----> Amazon Managed Streaming for Apache Kafka (MSK)(maybe process ?) ----> S3, redshift, Splunk, ELK, whatever
Kinesis Agent  ---->  Amazon Managed Streaming for Apache Kafka (MSK)(maybe process ?) ----> S3, redshift, Splunk, ELK, whatever


## You Can write your own Kinesis client using the SDK
