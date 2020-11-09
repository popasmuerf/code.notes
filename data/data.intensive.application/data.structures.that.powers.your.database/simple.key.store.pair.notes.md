*   You likely won't be writing your own storage engines from scratch

*   You do need to have a firm grasp of storage engines available and the 
    differences between them
    
*   You do need to know which storage eninges are appropiate/optimal for use with 
    your application.
    
    
*   In order to tune a storage eninge to peform well on your kind of workload,
    you need to have a rough idea of what the storage engine is doing under the
    hood.
    
    
*   In particular, there is a big difference between storage
    engines that are optimized for transactonal workloads and those
    that are optimized for analytics.
        -   Transaction Processing
        -   Analytics
        -   log-structured storage engines:
        -   page-oriented storage engines(such as B-trees)
        
        
   
 *  Issues real world databases have to deal with
        -   Reclaiming disk space (removing redundant data, old data)
        -   Error handling(partially written records, failed atomic ops)
        -   Concurrency
 
 *  Indexing is requiered for effienct lookup
        -   without indexing lookups are at bext O(n) complexity
        -   The idea behind indexing is :
            --  Make use of addtional metadata
            --  Metadata acts as a "signpost"
            --  Searching the saem data in several different
                ways  may require several different
                indexes on different parts of the data.

*   An index is an additional structure
        -   index's are derived from the primary data
        -   Many databases allow you to add and remove indexes
        -   index's do not mutate the data in the database.
        -   index's only affect the performance of queries
        -   Maintaining additional data structures incurs overhead, 
            espeically on writes.  For writes it is difficult to
            to beat the performance of simply appending to
            a file, because that's the simplest possible write operation.
            Indexing slows writes as the the index also needs to be updated
            every time data is written.
*   An important trade off oin starage systems:
        -   well chosen indexes speed up reads
        -   indexes slow down writes
        -   Most databases offer indexing as options that
            are not turned on by default
        -   Developers/DB Admins must turn on indexing and choose
            what to indexe manually.  This makes sense....as it offers
            flexibility and adds overhead only when necessary
            
            

