[An Intro to Spring Cloud Task](https://www.baeldung.com/spring-cloud-task)


# An Intro to Spring Cloud Task



## 1. Overview

The goal of Spring Cloud Task is to provide the functionality of creating short-lived microservices for Spring Boot
application.


In Spring cloud Task, we have go the flexibility of running any task dynamically, allocating resources on 
demand and retrieving hethe results after the Task completion.


Tasks is a new primitive within Spring Cloud Data Flow allowing users to execute virtually any Spring Boot 
application as a short-lived task


## 2. Developing a Simple Task Application

### 2.1 Adding Relevant Dependencies 

        <dependencyManagement>
            <dependencies>
                <dependency>
                    <groupId>org.springframework.cloud</groupId>
                    <artifactId>spring-cloud-task-dependencies</artifactId>
                    <version>2.2.3.RELEASE</version>
                    <type>pom</type>
                    <scope>import</scope>
                </dependency>
            </dependencies>
        </dependencyManagement>
