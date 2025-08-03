[Spring Cloud Data Flow](https://spring.io/projects/spring-cloud-dataflow)


# Spring Cloud Data Flow 


- Microservice based Streaming and Batch data processing for Cloud Foundry and Kubernetes.
- Spring Cloud Data Flow provides tools to create complex topologies for 
    * streaming 
    * batch data pipelnes.

- Spring Cloud Data Flow supports a range of data processing use cases
    - ETL
    - Import/Export
    - Event Streaming 
    - Predictive Analytics 



## Features


- The Spring Cloud Data Flow serer uses [Spring Cloud Deployer](https://github.com/spring-cloud/spring-cloud-deployer/)
to deploy data pipelines made of Spring Cloud Stream or Spring Cloud Task applications onto modern platforms such as Cloud Foundry and Kubernetes
    * An OSS, vendor neutral answer to AWS Cloud Function ?

- A selection of pre-built 
    * stream 
    * task/batch 
starter apps for various data integration and processing scenarios facilitate 
learning and experimentation. 

- Custom stream and task applications, targeting different middleware or data services, can 
be built using the familar Spring Boot style programming model

- A simple stream pipeline DSL makes it easy to specify which apps to deploy and how to connect outputs and inputs.
The composed task DSL is useful for when a series of task apps require to be run as a directed graph.

- The dashboard offers a graphical editor for buildin gdata pipelines interactively, as well as views of deployable apps 
and monitoring them with metrics using 
    * Wavefront
    * Prometheus
    * Influx DB
or other monitoring systems.

