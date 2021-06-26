# Assess Container Images in Tenable.io Container Security
(source)[https://www.youtube.com/watch?v=XotX4m3lCz4]


How do we get that observability ?
    - Look for docker daemons specifically
    - find out if they are actually running or not
    - How ?
        * Hamburger 
            -> Container Security
                -> Vulnerabilities
                    -> Advanced Search
                        -> <Plugin Name> <containes> <docker> 
                        -> <Severity> <is equal to> <None>
                        -> "Results" Look for "Docker Service Detection"
                        
        * Via Network Scan
            -> New Scan
                -> Basic Network Scan
                    -> <Name> <Folder> <Scanner> <Targets via ip address/range or hostname>
                    -> Credentials
               




# Docker Integration
(source)[https://www.youtube.com/watch?v=_ZwbAYbHKM8]
# first login to docker  using your api key
docker login -u -p  registry.cloud.tenable.com 


#pull the image
docker  pull mongo:latest #pull the image


#tag the image
docker tag mongo:latest registry.cloud.tenable.com/mongo:demo


#docker push image
docker push registry.cloud.tenable.com/mongo



# Discovring Running Containers with Tenable.io Container Security

With the rise of Docker orgs struggle with understanding if Docker is being
used in their enviroment and where it is being used in their enviroment....
Docker poses a unique security threat in some ways....imagine having an entire 
unauthorized "sub server" running on an authorized server ?


How do we get that observability ?
    - Look for docker daemons specifically
    - find out if they are actually running or not
    - How ?
        * Hamburger 
            -> Vulnerability management
                -> Vulnerabilities
                    -> Advanced Search
                        -> <Plugin Name> <containes> <docker> 
                        -> <Severity> <is equal to> <None>
                        -> "Results" Look for "Docker Service Detection"
                        
        * Via Network Scan
            -> New Scan
                -> Basic Network Scan
                    -> <Name> <Folder> <Scanner> <Targets via ip address/range or hostname>
                    -> Credentials
               
