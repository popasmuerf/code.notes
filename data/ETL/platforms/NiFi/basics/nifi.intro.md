url: [https://www.tutorialspoint.com/apache_nifi/apache_nifi_introduction.htm]


## What is Apache NiFi ?
-----------------------------------------------
Apache NiFi is a powerful, easy to use and reliable system to
    -   Process
    -   Distribute 
    
 between disparate systems.
 It is based on **Niagra Files** technology by NSA and then after 8 years was 
 donated to Apache Software foundation.  It is 
 distributed under Apache Lience Version 2.0 on January 2004.
 
 
###Apache NiFi is a real time data ingestion platform, which can transfer and manage
 data transer between different sources and destination systems.  It supports 
 a wide varity of data formats like 
    -   logs
    -   geo location data
    -   social feeds, etc.

###It also supports many protocols such as:
    -   SFTP
    -   HDFS
    -   KAFKA
    
    
    
###Apache NiFi General Features
    -   Web-based user UI
    -   Configurable
    -   Data provencance module to track and monitor data from start to end of the flow
    -   Developers can create their own custom processors and reporting tasks according to 
        their needs
    -   NiFi also provides support to secure protocols like SSL, HTTPS,SSh and other encryptions.
    -   It also supports user and role management and also can be configured with LDAP for
        authorization.
        
###Apache NiFi -Key Concepts
The key concepts of Apache NiFi are as follows---

    -   Process Group
        -   It is a group of NiFi group flows, which helps a user to
            manage and kep flows in hierarchical manner
    -   Flow
        -   Created when you connect diffren processors to transfer and modify data if required
            from one data source or sources to another destination data sources.
    -   Processor
        -   A processis a java module responsible for either fetching data from sourcing system or
            storign it in destination system.  Other processors are also used to add attributes or 
            or change content to flowfile
    -   Flowfile
        -   It is the basic usage of NiFi, which represnets the single object of the data picked from 
            source system in NiFi.  NiFiprocessormakes changes to dlowfile while it moves from
            the source processor to the destination. Different events like 
                -   CREATE
                -   CLONE
                -   RECIEVE
                -   etc
            are performed on flowfile by different processors in a flow.
    -   Event
        -   Events represent the change in flowfile while traversing through a NiFi Flow. These events
            are tracked in data provenance
    -   Data provenance
        -   It is a repository.  It also has a UI, which enables users to check the information
            about a flowfile and helps in troubleshooting if any issues that arise during the
            processing of a flowfile.
            
            
            
###Apache NiFi Advantages
    -   Apache NiFi enables data fetching from remore machines by using SFTP and guarantees data 
        lineage
    -   Apache NiFi supports clustering, so it can work on multiple nodes with the same flow
        processin different data, which increases the peformance of data processing
    -   It also provides security policies on user level, process group level and other modules
        also.
    -   Its UI can also run on HTTPs, which makes the interaction users with NiFi secure
    -   NiFi supports around 188 processors and a user can also create custome plugins to 
        support a wide variety of data systems

    
###Apache NiFi Disadvantages
    -   When node gets disconnected from NiFi cluster while a suers is making any changes in it, then 
        the flow.xml becomes invalid.
