## Splunk Deployment Basics



## Server Class:

A group of common configuration which is shared by multiple instances

Example:

*   ServerClass "Windows" which is common to all windows servers.
*   Serverclass called "Linux" which is common for all linux servers


Service Classes require the use of a **Deployment App**




## Deployment App

A set of content(eg configuration files) maintained by deployment server
and pushed to the deployment clients belonging to a specific server class


Example:
Deployment app has:

    -   Inputs.conf
        *   Monitors for /var/log/secure and /var/log/audit
    -   This deployment app is associated with "Linux" serverclass







### Server Class and Deployment Apps

Server Class is a group which can contain multiple apps 

----Linux_servers----
-secure-------      |
             |-----------------Only deploy on subnet 10.77.*
-audit--------      |          Exclude 10.77.4.50
---------------------

While installing univeral forwarder, we run certain commands like:

    > ./splunk add monitor /var/log
    > ./splunk add forward-sever 172.17.0.2:9997
    
    
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

https://www.xvideos.com/video57361621/naughty_mackerel_angel_lima_fucked_in_the_fur_and_released_the_ass_without_pity_actor_jack_kallahari
