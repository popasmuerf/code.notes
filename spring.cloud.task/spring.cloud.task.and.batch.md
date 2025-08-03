[batch](https://docs.spring.io/spring-cloud-task/reference/batch.html)


# Batch

This section goes into more detail about Spring Cloud Task's integration with Spring Batch.
Tracking the association between a job execution and the task in 
which it was executed as well as remote partitioning through Spring Cloud Depolyer 

### Associating a Job Execution to the Task in which it was executed

- Spring Boot provides facilities for the execution of batch within a Spring Boot Uber-jar.
- Spring Boot's support of this functionality lets a developer execute multiple batch jobs within
that execution.
- Spring Cloud Task provides the ability to associate the execution of a job (a job execution)
with a task's execution so that one  can be traced backed to the other.


- Srping Cloud Task acheives this functionality by using the `TaskBatchExecutionListner`
- By default, this listener is auto configured in any context that has both a Spring Batch Job 
configured (by having a bean of type `Job` defined in the context) and the 
`spring-cloud-task-batch` jar on the classpath.  The listener is injected into all jobs
that meet those conditions.



### Overriding the TaskBatchExecutionListener

To prevent the listener from being injected into any batch jobs within the current
context, you can disable the autoconfiguration by using standard  SpringBoot
mechanisms.

To only have the listener injected into particulr jobs within the context, override the 
`batchTaskExecutionListenerBeanPostProcessor` and provide a list of job bean IDs, as 
shown in the following example: 


        public static TaskBatchExecutionListenerBeanPostProcessor batchTaskExecutionListenerBeanPostProcessor() {
            TaskBatchExecutionListenerBeanPostProcessor postProcessor =
                new TaskBatchExecutionListenerBeanPostProcessor();

            postProcessor.setJobNames(Arrays.asList(new String[] {"job1", "job2"}));

            return postProcessor;
        }



### Remote Partitioning 

Spring Cloud Deployer provides facilities for launching Spring Boot based  applications on 
most cloud infrastructures.  The 

    DeployerPartitionHandler
    DeployerStepExecutionHandler 


To configure the DeployerStepExecutionHandler, you must provide a Resource representing the Spring Boot Uber-jar to be executed, a TaskLauncherHandler, and a JobExplorer. You can configure any environment properties as well as the max number of workers to be executing at once, the interval to poll for the results (defaults to 10 seconds), and a timeout (defaults to -1 or no timeout). The following example shows how configuring this PartitionHandler might look:


NOTE:
When passing enviroment variables to partitions, each partition may be on a different machine
with different enviroment settings. Consequently, you should pass only those enviroment 
variables that are required 

        @Bean
        public PartitionHandler partitionHandler(TaskLauncher taskLauncher,
                JobExplorer jobExplorer) throws Exception {

            MavenProperties mavenProperties = new MavenProperties();
            mavenProperties.setRemoteRepositories(new HashMap<>(Collections.singletonMap("springRepo",
                new MavenProperties.RemoteRepository(repository))));

            Resource resource =
                MavenResource.parse(String.format("%s:%s:%s",
                        "io.spring.cloud",
                        "partitioned-batch-job",
                        "1.1.0.RELEASE"), mavenProperties);

            DeployerPartitionHandler partitionHandler =
                new DeployerPartitionHandler(taskLauncher, jobExplorer, resource, "workerStep");

            List<String> commandLineArgs = new ArrayList<>(3);
            commandLineArgs.add("--spring.profiles.active=worker");
            commandLineArgs.add("--spring.cloud.task.initialize.enable=false");
            commandLineArgs.add("--spring.batch.initializer.enabled=false");

            partitionHandler.setCommandLineArgsProvider(
                new PassThroughCommandLineArgsProvider(commandLineArgs));
            partitionHandler.setEnvironmentVariablesProvider(new NoOpEnvironmentVariablesProvider());
            partitionHandler.setMaxWorkers(2);
            partitionHandler.setApplicationName("PartitionedBatchJobTask");

            return partitionHandler;
        }


Notice in the example above that we have set the maximum number of workers to 2. Setting the maximum of workers establishes the maximum number of partitions that should be running at one time.






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



