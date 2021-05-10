#Google Kubernetes Engine (GKE)



##Kubernetes
1. Most popular OSS container orchestration solution
2. Provides cluster management (including upgrades)
3. Each cluster can have different types of virtual machines

##Provides all the important container orchestration features:
1. Autoscaling
2. Service Discovery
3. Load Balancer



##Google Kubernetes Engine(GKE)
1. Managed Kubernetes Service
2. Minimize operations with auto-repair(repair failed nodes) and 
   auto-upgrade(use latest version of K8S always) features
   
3. Provides Pod and Cluster Autoscaling

4. Enables Cloud Logging and Cloud Monitoring with simple configuration

5. Uses Container-Optimized OS, hardened OS built by Google

6. Provides support for Persistent disks and Local SSD










#App-Engine - Scenarios

Scenario:
    I want to create two Google App Engine Apps in the same
    project

Solution:
    Not possible, you can only have one GAE app per project; however
    you can have multiple services and multiple versions for each service...
    
    
 
Scenario:
    I want to create more than one GAE services within the same GAE.....
    
    

Solution:
    Yes, this is possible.
    > gcloud app deploy |service| --version=<version no.>
    
    
   
 
Scenario:
    I want to move my GAE app to another region .....
    
   
Solution:
    No, this is not possible.  Once the GAE app  has been generated, it's 
    region value is immutable...you can however move your services around the 
    zones the region encapsulates....
    > gcloud app deploy --no-promote  # don't immediate route traffic to latest deployment
    > gcloud app services set-traffic s1 --splits v1=0.9,v2=0.1  #gradually route traffic to latest deployment
    
    

Scenario:
    I want to gradually migrate traffic gradually to a new version in GAE .....
    
   
Solution:
    Yes, this is  possible. 
    
    > gcloud app services set-traffic --migrate
        
    

    
Scenario:
    I want peform **canary deployments** .....
    
   
Solution:
    Yes, ther are several ways to go about this.......
    -   versioning
    -   manually splitting traffic between versions
    -   timed, gradual splitting traffic between versions
    -   
    

##App Engine Basics
-   is Regional
-   Services are deployed across zones
-   Region is permanent
-   Makes sense for simple microservers with simple requirements
-   Is not as powerful as kubernetes....
-   Use **standard v2** when you are dealing with supported languages/platforms
-   Use **flexible** when you are dealing with unsupported languages platforms
    as you will need to build your apps containerized
-   Flexible will not scale down to zero when there is no load
    ...will always be running at least one container...
-   Use a combination of resident and dynamic instnces
    *   resident instances: run continuously
    *   dynamic instances : added based on load
        Use Dynamic only if you are cheap and or broke...which 
        begs the question...is all dyanmic possible in practice
        with **Standard V2**
    

##App-enginer
    - Only one app-engine per project
    - may have as many services as you like within App Engine instance

##Traffic routing
    - traffic splitting  via IP
    - Cookie splitting(GOOGAPPUID) within header
    - random
    
##Version migraion
    - manual via traffic splitting
    - auto via app
    
    
  
  
  gcloud app create --region=us-central
  gcloud app deploy app.yaml
    -image-url
    -promote
    -stop-previous-version
    -version 
    
    
    
#App Engine yaml files
    -dispatch.yml (override routing rules)
    -queue.yml (manage task queues)
    -cron.yml (manage scheduled tasks)
