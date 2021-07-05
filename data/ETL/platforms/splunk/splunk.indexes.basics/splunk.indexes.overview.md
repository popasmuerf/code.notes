


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





