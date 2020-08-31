Spring Boot command line arguments example
============================================================
https://tomd.xyz/spring-boot-arguments/




When you run a Spring Boot application from the command line,
and you want to do any of the following:

*   configure HTTP/HTTPS proxy settings for the Java Virtual Machine
*   set JVM memory limits
*   change the profile of your Spring Boot app
*   set Spring Boot application properties
*   override any other properties on a Spring Boot app

Then start your application like this:

        java[java options.....] \
            -jar path/to/spring-boot-application.jar \
            --spring.property.name=value ...\
            --application.property.nam=value ....\



#Example
#This Example first compiles a Spring Boot application with Maven
#Then, it starts the application.  It sets the following
#   -HTTPS proxy configuration
#   -unlocks features for Mission Control
#   -makes Spring use the configured local profile 
#   -sets some custom application properties


        > mvn clean package
        > java -XX:+UnlockCommercialFeatures -XX:+FlightRecorder \
            -Dhttps.proxyHost=my.proxy.thirdplanet.io \
            -Dhttps.proxyPort=8080 \
            -Dhttps.proxyUser=$PROXY_USER \
            -Dhttps.proxyPassword=$PROXY_PASS \
            -jar target/application-1.0.0-SNAPSHOT.jar \
            --spring.profiles.active=local \
            --breakfast.eggs=poached \
            --dinner.eggs=boiled
    
    








There are a lot of aspects to the deployed application that we may 
want to describe on each deployment.  In our first run, we
used various cf incantations to configure the application but that
could get tedious quickly.  Instead, let us capture our application's
configuration in a Cloud Foundry manifest file, typically named

    **manifest.yml**
    
    
Here is a manifest.yml for our application that will work so long
as we have already  got a MySQL datatsource provisioned with the 
same name as specified earlier...


        applications:
            :bootcamp-customers
            
            buildpack: https://github.com/cloudfoundry/java-buildpack.git
            instances: 1
            random-route: true
            path: target/spring-configuration.jar
            
            services:
                bootcamp-customers-mysql
                
            env:
                DEBUG: "true"
                
            SPRING_PROFILES_ACTIVE: cloud
    


...and specify enviroment variables to override properties
to which Spring Boot will respond.  

        --Ddebug=true
        
 and the following specifies which profiles, or logical groupings with 
 arbitrary names, should b activated in a Spring application.
 
        --Dspring.profiles.active=cloud
        
This configuration says to start all Spring beans without any profile
as well as those with a cloud profile




