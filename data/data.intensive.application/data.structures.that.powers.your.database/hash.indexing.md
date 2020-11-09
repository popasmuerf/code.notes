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
        
        
##Hash Indexes    
    We can start withindexe for key-value data.
    This isn't the only kind of data you can index, but it is very common
    and it's useful building block for more comoplex indexes.
    
    *   Key-Value stores are quiret similar to the **dictionary** type that
        you can find in most programming languages, and which is
        usually implemented as a **hashmap**(a hashtable)
        
    *   Hashmaps are a useful datastructured for  indexing in memory data, so why
        not use them to index data on disk ?
        
    *   The simplest possible indexing strategy is this :
        -   In-Memory hash map where every key is mapped to a byte
            offset in the data file
        -   Whenever you append a new key-value pair to the file
            we update the hash map to reflect the offset of
            the data you just wrote)
            
        -   Whenever you insert new data or update data, we update
            the hash map to reflect the offset of the data you 
            just wrote
            
        -   When you want to look up a value, use the hash mpa to find the offest in
            the data file, seek to tha location, and read the value
            
        -   This may sound simplistic, but it is a vaiable approach.  In fact this 
            is essentially what **Bitcask**(the default starage engine in Riak does)
            --  Bitcask offers high-performance reads and writes, subject
                to the rquirement that all the keys fit in the avaiable RAM,
                since the hash map is kept completely in memory.
                
            --  If all indexes are in memory, then the speed of search should be 
                pretty fast....
                
            --  Bitcask is wel suited to situations where the
                value for each key is updated freqnuently.  For example,
                --- The URL of a cat video
                --- The number of times it has been played(incremented
                    every time the video is played)
                --- In this scenario there are a large number of writes
                    but few distinct keys.
           
           
##Example of an in memory Key Value indexing architecuture using a HashMap for 
##for entries in a simple file acting as a data base

|Key-------|-------byte offset|
-------------------------------
 123456    |         0
-------------------------------
 42        |         64
 ------------------------------
        123456,{"name":"London","attactions":["Big Ben" "London Eye"]}
        42,{"name":"San Francisco","attactions":["Golden Gae Bridge"]}
        123456,{"name":"London","attactions":["Big Ben" "London Eye"]}
        42,{"name":"San Francisco","attactions":["Golden Gae Bridge"]}


    *  
    
