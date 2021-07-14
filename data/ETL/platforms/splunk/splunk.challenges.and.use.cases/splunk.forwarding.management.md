## Challenges with Forwarder Management





### Typical Challenges

Universal Forwarder collects data from a server and send it to your
Splunk deployment.


While installing univeral forwarder, we run certain commands like:

    > ./splunk add monitor /var/log
    > ./splunk add forward-server 172.17.0.2:9997
    
    
All of this can be manual and can be automated with configuration management tools like
Ansible(this will become a must in an enterpise enviroment...no way you are executing
these commands by hand...)



### Typical Use-Case

Some example use-cases:

Any server which belongs to subnet 192.168.10.0/24 network should have only
    
    /var/log/secure
    
monitored.


Any server which belongs to 10.77.0.0/20 shoud have the following 
monitored

    /var/log/secure
    /var/log/audit


If server hostname starts with **win-**, then integrate it to
send all the windows events and Active Directive logs.....




##  Splunk actually has a forwarder management feature

192* - /var/log/secure
10.77.* /var/log/secure, /var/log/audit
win* - windows events, AD logs

(in depth anaylysis of forwarder management )[https://docs.splunk.com/Documentation/Splunk/8.2.1/Updating/Aboutdeploymentserver?ref=hk]


Notes: 
-	Where does this management feature reside ?
-	


