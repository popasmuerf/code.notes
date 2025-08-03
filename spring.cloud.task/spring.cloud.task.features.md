[Spring Cloud Task](https://docs.spring.io/spring-cloud-task/reference/features.html)


# Spring Cloud Task

### Lifecycle of a Spring Cloud Task

- In most cases, teh modern cloud enviroment is designed around teh execution of processes that are not expected to end
- If these tasks do end, they are typically restared.
- While most platforms do have some way to run a process that is not restarted when it ends 
    * Results of that run ar etypically not maintained in  a consumable way

- Spring Cloud Task offers the ability to execute short-lived processes in an enviroment and recored the results
    * Doing so allows for a microservice architecture around short-lived proceses as well as longer running services through the 
    integration of tasks by messages 
        - Useful in Cloud enviroments
        - Useful in traditional enviroments also
            * Scheduling sucha as cron being used to monitor the results of 
            the application after it's complection.


- Spring Cloud Task takes the apporach that a Spring Boot applicatin can have astart and an end and still 
be successful.
    * Batch operations.
    * Automated workflows
    * User Applications

- Spring Cloud Task records the lifecycle events of a given task
    * Most long-running proceses, typified by most web applications, do not 
    save their lifecycle events.
    * This is the heart of Spring Cloud Task can mitigate

- Life Cycles conssits of a single task execution
    * Physical execution of a Spirng Boot application configured to be a task(that is, it has the Sprint Cloud Task
    dependencies)
    * At the beginning of a task, before any `CommandLineRunner` or `ApplicationRunner` implementations have been run,
        - An entry in the `TaskRepository`
            * Records the start enver is created.
            * This event is triggered through `SmartLifecycle` being triggered by 
            the Spring Framewor.
                - Indicates to the system that all beans are ready for use and comes before running 
                any of the `CommandLineRunner` or `ApplicationRunner` implementations provided by Spring Boot 

#### NOTE
The recording of a task only occurs upon the successful upon the successful bootstrapping of an 
`ApplicationContext`. If the context fails to bootstrap at all,  the task's run is not recorded


- `Spring Bean`  
In Spring, the objefts that form the backbone of your application and that are managed by the Spring  IoC container are 
called `beans`  A bean is an object that is instantiated, assembled, and otherwise managed by 
a Spring IoC container. 

source:  [What Is a Spring Bean?](https://www.baeldung.com/spring-bean#:~:text=Here%27s%20a%20definition%20of%20beans,by%20a%20Spring%20IoC%20container.)

- `CommandLineRunner`
Interface used to indicate that a bean should run when it is contained within a `SpringApplication`.
Multiple CommandLineRunner beans can be defined within teh same application context and can be ordered using the 
`Ordered` interface or `@Order` annotation.
If you need access `ApplicationArguments` instead of the raw String array consider using `ApplicationRunner`

source : []()


- `ApplicationRunner` 
Interface used to indicate that a bean should run whn it is contained within a `SpringApplication`.
Mulitple `ApplicationRunner` beans can be defined within the same application context and can be ordered
using the `Ordered` interface or @Order annotion.

source : [ApplicationRunner](https://docs.spring.io/spring-boot/api/java/org/springframework/boot/ApplicationRunner.html)


- `Lifecycle`
A common interface defining methods for start/stop lifecycle control.  The typical use case for is to conrol 
asynchronous processing.

- `SmartLifecycle`
Interface an extension of the Lifecycle interface for those objects that requie to be started upon `ApplicationContext` refresh
and/or shutdown in a particular order.

- `TaskRepository`
TaskRepository interface offers methods that create and update task execution informatin.
- TaskRepository interface offers methods that create and update task execution information 


## The TaskExecution


                Field                                                               Description
                ---------------------------------------------------------------------------------------------
                                                        |
                executionid                             |               The unique ID for the task's run.
                ---------------------------------------------------------------------------------------------
                                                        |
                                                        |
                exitCode                                |               The exit code generated from ExitCodeExceptionMap
                                                        |               
                ---------------------------------------------------------------------------------------------
                                                        |
                taskName                                |               The name for the task determined by the configured
                                                        |               TaskNameResolver
                ---------------------------------------------------------------------------------------------
                                                        |
                startTime                               |               The time the task was started, as indicated
                                                        |               by the SmartLifecycle call
                ---------------------------------------------------------------------------------------------
                                                        |
                endTime                                 |               The time the task was completed, as indicated by
                                                        |               AplicationRedyEvent
                ---------------------------------------------------------------------------------------------
                                                        |
                exitMessage                             |               Any information available at the time of exit.
                                                        |               This can programmatically be set by a TaskExecutionListener.
                ---------------------------------------------------------------------------------------------
                                                        |
                errorMessage                            |               If an exception is the cause of the end of the task
                                                        |
                ---------------------------------------------------------------------------------------------
                                                        |
                arguments                               |               A List of the string command line arguments as they were passed into
                                                        |               the executable boot application.
                ---------------------------------------------------------------------------------------------



The following example shows the three annotations in use:

        public class MyBean {

            @BeforeTask
            public void methodA(TaskExecution taskExecution){
                //do things
            }

            @AfterTask
            public void methodB(TaskExecution taskExectuion){
                //do things
            }

            @FailedTask
            public void methodC(TaskExecution taskExecution, Throwable throwable){
                //do things
            }
        }


### Restricting Spring Cloud Task Instances

- Spring Cloud task lets you establish that only one task with a given task name can be run at a time.

    To do so, you need to establish the task name and set spring.cloud.task.single-instance-enabled=true for each task execution. While the first task execution is running, any other time you try to run a task with the same task name and spring.cloud.task.single-instance-enabled=true, the task fails with the following error message: Task with name "application" is already running. The default value for spring.cloud.task.single-instance-enabled is false. The following example shows how to set spring.cloud.task.single-instance-enabled to true:

    spring.cloud.task.single-instance-enabled=true or false


- To use this fetaure, you must add the following Spring Integration dependencies to your application:


        <dependency>
            <groupId>org.springframework.integration</groupId>
            <artifactId>spring-integration-core</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.integration</groupId>
            <artifactId>spring-integration-jdbc</artifactId>
        </dependency>