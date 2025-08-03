[Spring Cloud Stream](https://spring.io/projects/spring-cloud-stream)


# Spring Cloud Stream 


- Spring Cloud Stram is a frame work for building highly scalable event-driven micorsercvies connected
with shared messaging Systems 
- the framwework provides a flexible programming model built on already established and familar Spring idioms and 
best practices, including support for 
    * persistent pub/sub semantics
    * consumer groups
    * stateful partitions


#### Binder Implementations 

Spring Cloud tream supports a variety of binder implemenations and the following table includes the 
link to the GitHub projects 

- RabbitMQ

- Apache Kafka

- Kafka Streams

- Apache Pulsar

- Amazon Kinesis

- Google PubSub (partner maintained)

- Solace PubSub+ (partner maintained)

- Oracle TxEventQ_(partner maintained)

- Azure Event Hubs (partner maintained)

- Azure Service Bus (partner maintained)

- AWS SNS (partner maintained)

- Apache RocketMQ (partner maintained)




The core buiolding blocs of Spring Cloud Stream are:

- Destination Binders
    * Components responsible to provide integration wtih the external messaing systems
- Destination Bindings
    * Bridge between the external messaging systems and application code (producer/consumer)
    provided by the end user
- Message :
    The canaonical data structure used by producers and consumers to communicate with Destination 
    Binders 

