



## 6/30/2021
### Concerns


-   No requirements document of schedule from NLS
-   Complexity TTD = One week deliverable for a project of this 
    scope is not realistic
-   A Requirements document along with  an SOW(?) is required to ensure
    deliverable requirments are met
    
-   Data Ingestion = there are concerns base on the number provided
    *   Data includes more than security events
    *   Data analysis and determination will need to performed by the
        ISSO(??? Clinton ???) and the GCP Systems team (???IPT, and NLS ???)
-   Licensing = Licensing analysis will need to be conducted to evaluate
    impact of current Splunk licensing
    
-   CAB requirements need to be determined




???Questions???
-   What exactly is Data Governance ???
-   Why exactly is having a Requirements Engineering 
    Phase essential ?
-   Why is licensing restrictions a possible issue ?






## 6/28/2021
### Current plan as of 6/28/2021


-   Data Sources Identification and Confirmation 
    *   Identify and Confirm  what sources are logging security 
        relevent production data
    *   What does relevant data look like(raw?, structured?)
    *   Once relevant data sources have been identified we can
        break them down into elastic resources 
    *   Removing non-relevant data from license usage consciderations
        will help decrease the amount of data to be ingeste4d.  We have
        space in our on-prem instance to add a decent chunk of new data
    *   To reiterate...we should not be ingested irrelevant data for reasons
        of license cost and resource utilization
    *   Our principle SME on this was looking into the possibility of an app which would allow Splunk
        to search to search ELK without actually ingesting 
        anything from it(I don't think we are going this route)
    *   Before we move forward...we really know what is relevant..and "how big"
        is it, and what licensing do we currently have and or currently need.
-   Target Projects within GCP
    *   aaa-production-logs
    *   ..
    
-   Our SME will regex everything in the above Target Project Indices to be ignored
    and only ingest those events which match the specific
    character strings they send as security-relevant samples.
    
    
-   Exploritory searches should also be ran on the side to find what the daily size of
    "just the events which match their examples" is
    
   

???Questions???
-   How do we go about designing a scalable indexing
    architecutre  ???
-   How does Splunk go about indexing via discerning relevant data from 
    irrelvant data via REGEX ?   
    
    
    
    
## 6/30/2021
### Update Current plan as of 6/30/2021

"They got back with us with more-solid answers faster than I expected. 
 Based on the bullet points below, I think we can move foward with pulling
 in data from these 8 ELK indexes, filtered by a character string which will
 denote  security-relevant data, though I have no 
 intention of necessrily striving to meet thier deadline(It may be possible
 for a TDA of this Friday, but highly unlikey...but we could take longer if
 this is the direction you would like us to take"
 
 
 *  The What:
    -   Security relevant producton enviorment data resides in these
        ELK indices(as opposed to a much longer list they originally
        sent)
        *   aaa-production-logs
        *   bcs-client-prod
        *   cds-search-prod
        *   label-composer-prod
        *   nldb-prod-db-logs
        *   solr-prod
        *   transfer-portal-prod
        *   pics2-client-prod
        
    -   We can filter on the character string "logType": "SECURITY" to only 
        ingest security-relevant things, ignoring everything which does not
        have this character string:
        

    -  What does this mean in layman's terms:
        *   Paring the indices down to just production, NLS estimates about 
        


-   Current Project Managment  Consciderations
    *   NLS needs to provide the following:
        a.  Specific examples(character strings, identifiers, etc) that denote
            security-related production-enviroment-enviroment
            events (will be included in the integration ; all others will be
            excluded by default)
                a.1 ISSO's need to weigh in on this
             
        b.  Estimated daily average size of security-related 
            production-enviroment events
        
        c.  Specific number - and names - of:
            c.1 systems/applications to be onboarded into Splunk
                for auditing as part of this efrfort
        
    *   Recieve approval (based on NLS provided information) to add
        addtional  daily amount of data to Sto Splunk ( eta 1 day)
    *   Once relevant data sources have been identified we can
        break them down into elastic resources 
    *   Removing non-relevant data from license usage consciderations
        will help decrease the amount of data to be ingeste4d.  We have
        space in our on-prem instance to add a decent chunk of new data
    *   To reiterate...we should not be ingested irrelevant data for reasons
        of license cost and resource utilization
    *   Our principle SME on this was looking into the possibility of an app which would allow Splunk
        to search to search ELK without actually ingesting 
        anything from it(I don't think we are going this route)
    *   Before we move forward...we really know what is relevant..and "how big"
        is it, and what licensing do we currently have and or currently need.
-   Target Projects within GCP
    *   aaa-production-logs
    *   ..
    
-   Our SME will regex everything in the above Target Project Indices to be ignored
    and only ingest those events which match the specific
    character strings they send as security-relevant samples.
    
    
-   Exploritory searches should also be ran on the side to find what the daily size of
    "just the events which match their examples" is
    

???Questions???
-   How do we go about designing a scalable indexing
    architecutre  ???
-   How does Splunk go about indexing via discerning relevant data from 




1.  We have completed requirements engineering, and moving forward with implementation
    - Determining what will actually be ingested
    - Sizing out average data intake
    - Determining what data is security relevant and what isn't
2.  David Grant's crew has given the information and credentials(ELK) to move
forward with the implementation.
    - ELK stack access creds 



