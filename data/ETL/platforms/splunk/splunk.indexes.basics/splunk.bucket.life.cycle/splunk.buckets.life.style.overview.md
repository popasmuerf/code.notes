


## Overview of Indexes


The index is a repository of Splunk data....FULL STOP

### Splunk transforms incoming data into events, which it stores in the indexes...


1. Data goes into Splunk
2. Splunk transforms this data into events
3. Splunks stores events into indices


### What Splunk does with this data revisted...

-   When Splunk indexes your data, it creates a number of files.
-   These files falls into two main categories
    *   The raw data in compressed from (raw data)
    *   Indexes that points to raw data (tsdix files), plus some meta-data files
    
These files resides in set of directories organized by age


    
    
    
## Default Set of Indexes

Splunk Enterprise comes with a number of pre-configured indexes, including:

| main      | This is the default index.   All data gets stored here unless specified.                         |
|-----------|--------------------------------------------------------------------------------------------------|
| _internal | Stores Splunk's internal logs                                                                    |
| _audit    | Contains events related to user search history, file system change monitor and auditing specific |
|           |                                                                                                  |






Splunk stores all it's data in directories on the server called "buckets".
A bucket moves through sveral stages as it ages:
    -hot
    -warm
    -cold
    -frozen
    
    
    
| main      | This is the default index.   All data gets stored here unless specified.                         |
|-----------|--------------------------------------------------------------------------------------------------|
| _internal | Stores Splunk's internal logs                                                                    |
| _audit    | Contains events related to user search history, file system change monitor and auditing specific |
|           |                                                                                                  |
    


New/Recent data --> Hot Bucket #Read/Write
Hot Bucket --> Warm Bucket  #Read only
Warm Bucket --> Cold Bucket #Read only, reduced chance of being read, Data is usually archived
Cold Bucket --> Frozen, data is deleted by Splunk by default, setting can be changed for archival
Thawed --> If data in frozen bucket is archived, it can be indexed again by thawing it




## Hot Bucket to Warm Bucket

Buckets are rolled from hot to warm in the following condition:

*   Too man hot buckets [maxHotBuckets]
*   Hot bucket has not recieved data since a while
*   Timespan of buckets is too large
*   Index clustering repliction error
*   Splunk is restarted





## Warm to Cold Buckets

-  Ideally, historical data should go here
-  Allows us to keep older data on slower(cheaper storage)
-  Buckets are rolled from warm to cold when there are too many warm buckets.


[index_name]
coldPath = $SPLUNK_DB/$_index_name/colddb
maxWarmDBCount = 300



### What do we mean by too many warm buckets ?



## Cold to Fron Buckets

-  Data in fronzen is no longer searchable
-  Data rolls from cold to frozen bucket when:
    *   Total Size of index (hot + warm + cold) grows to large
    *   Oldest event in bucket exceeds specific age
    *   Default process tsidx file is removed and bucket is specified to
        esitination we specify.



## Thawing Process 

Overall Steps:
i) mv/tmp/frozendb/db*$SPLUNK_HOME/var/lib/splunk/defaultdb/thawddb/

ii) splunk rebuild $SPLUNK_HOME/var/lib/splunk/defaultdb/thaweddb/db*

iii) splunk restart





































