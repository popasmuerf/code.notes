#app-engine 

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
