

> cf create-service p-mysel 100mb bootcamp-customers-mysql

> push -p target/demo_app.jar   demo_app \
    --random-route --no-start
    
> cf bind-service bootcamp-customers bootcamp-customers-mysql

> cf start bootcamp-customers 





//example of a cloud foundry manifest file for a springboot app
//named demo_app
//with a manifest file we can forgo multiple cf commands and just run
// > cf push -f manifest.yml
---
applications:
    -name:  demo_app
     buildpack: https://github.com/cloudfoundry/java-buildpack.git
     instances: 1
     random-route: true
     path: target/spring-configuration.jar
     services:
     -  demo_app-customers-mysql
     
     env:
        DEBUG: "true"
        SPRING_PROFILES:cloud
