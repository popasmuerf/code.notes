#GCP - Persistent Disks vs Local SSDs



#   Presistent Disks 
    * Attachment to VM instance : 
        -  As a network drive
    * Lifecycle 
        -  Seperate from VM instance
    
    * I/O Speed
        -  Lower (network Latency)
        
    * Snapshots
        -  Suported
   
    * Use case:  
        -   Permanent storage 
        
        
#   Local SSDs
    * Attachment to VM instance : 
        -  Physically attached
    * Lifecycle 
        -  Tied with VM instance
    
    * I/O Speed
        -  10-100x of PDs
        
    * Snapshots
        -  Not Suported
   
    * Use case:  
        -   Ephemeral storage 



