##  Splunk Repports



## Sample Use-Case:


Security Manager should be informed with list of IP address and
Country location from which failed SSH attemps are bine made at every 24 hours over
email

    



source="secure.log" action=failure | iplocation=src | table src, Country


source="secure.log" action=failure | iplocation src | table src, Country, count | uniq



## Automation





        
        
    
