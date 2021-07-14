##  Getting the basics straight






There are two important files that we need to look into:

-   inputs.conf
-   outputs.conf


-   Inputs file determines which are the log files to monitor.
-   Outputs file determines to which destination data should be forwarded
to which destination data should be forwarded to
    



source="secure.log" action=failure | iplocation=src | table src, Country


source="secure.log" action=failure | iplocation src | table src, Country, count | uniq



## Automation





        
        
    
