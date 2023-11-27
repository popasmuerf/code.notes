
[source](https://docs.docker.com/compose/)


## Docker Comose overview 


1. Compose is a tool for defining and running multi-continaer Docker applications.
2. With compose, you use a YAML  file to configure your applications services.
3. With a single command, you create and start all the services from your configuration.



Compose works in all enviroments; production, staging, development, testing, as well as CI workfiows.
It also has commands for managing the whole lifecycle of your application:

- Start, stop and rebuild sevices
- Veiw the status of running services
- Stream the log output of running sevices
- Run a one-off command on a service 



The key features of Compose that maek it effective are:

- Have Have multiple isolated enviroments on a single host
- Preserve volume data when containes are created 
- Only recreate containers that have changed
- Support variables and moving a composition between enviroments 



# Key featruess and use cases of Docker Compose 

Using Compose is essentially a three-step process:

1. Define your app's enviroment with a Dockerfile so it can be reproduced anwhere
2. Define the services that make up your app in a compose.yaml file to file so they can be run together in an 
isolated enviroment.
3. Run doecker compose up and theDocker compose command starts and runs your entire appl. 


A  compose.yaml looks like this: 


services:
    web:
        build: .
        ports:
            - "8000:5000"
        volumes:
            -  .:/code
            - logvolume01:/var/log
        depends_on:
            - redis
    redis:
        image: redis
    volums:
        logvolume01: {}
        
        
## Key features of Docker Compose 
#### Have multiple isoleatded enviorments on a single host.

* Compose uses a proejct name to isolate enviroments from each other. such as when you want to run a stable copy 
for each feature branch of a project 


* On a CI server, to keep builds from interfering with each other, you can set the project name to a unique build number

* On a shared host or dev host, to prevent differnt projects, which may use the same service names from interfering with ech other


The default project name is the base name of the project directlyr.  You can set a custom project name by using the -p comandline option
or the COMPOSE_PROJECT_NAME envrioment variable.

The default project directory is the base directory of the Compose file.  A custome value for it can be defined with the --project-directory
command line option


## Preserves volume data when containers are created 

Compose preserves all volumes used by your services.  When `docker compose up` runs, if it finds any 
containers from previous runs, it copies the vlues from the old container to the new container. 

## Only create containers tha thave changed

Compose caches the configuration used to create a container.  When you resstart ta serves that has not changed, compose re-uses
the existing containers. Re-using containers means tha tyou can make changes to yoru enviroment very queicklty


## Supports variables and moving a composition between envviorments 

Sompose supports variables in teh Compose file.
You can extend a Compose file using the `extends` fields or by creating multiple Compose files.
(Working with multiple Compose files)[https://docs.docker.com/compose/multiple-compose-files/]



## Common use cases of Docker Compose 

Compose can be used in many different ways.  Some common use cases are outlined below 





## Automated testing enviroments 
An important of any Continuous Deployment or Continuous Integration process is the automated
test suite.  Automated end-to-end testing requirest an enviroment in which to run tests.  Compose 
provides a convenient way to creat and destory isolated testing enviroments for your test suite.
By defning the full enviroment in a Compose file, you can create and destroy these enviroments in just a few
commands:
 
 
 $ docker compose up -d 
 $ ./run_tests
 $ docker compose down
 
## Single host deployments 

Compose has traditionally ben focused on development and testing workflows, but with each release we're
making progress on more production-orientated feataures
(Compose in production)[https://docs.docker.com/compose/production/]









