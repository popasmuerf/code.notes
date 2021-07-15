##  Splunk Managing Indexes

[source](https://www.learnsplunk.com/splunk-indexer-configuration.html)

Indexing is a mechanism to speed up the search 
process by giving numeric addresses to the 
piece of data being searched.

Splunk indexing is similar to the conectp of indexing in
databases.   The installation of Splunk
creates three default indexes as follows:

    -   main
        -   Splunk's default index where all the data is stored
    -   internal
        -   Index where Splunk's internal logs and processing
            metrics are stored 
    -   audit
        -   This index contains events related to the file
            system change monitor, auditing and all user history

The splunk indexers create and maintain the indexes.  when you 
add data to Splunk, the indexer processes it and stores it in
a designated index (either by default in the main index or in the one that you identify)


### Understanding splunk indexer | HOw to configure splunk indexer ?

Splunk indexer is the most important splunk component.  
Fundamentally the Splunk indexer is the the database of
splunk where all logs are collected...but in a "smart way".

The indexer collects logs sent by the splunk forwarders that are resident on target clients; and proecesses those for creating indices and raw data.  Same as any book index...it creates an index for all collectedlogs from your enviroment.  Splunk indexer stores all data in an "index"(a directory splunk stores keywords from logs that are then linked to raw-data/full logs) so that it can search logs with superb speed.


Understanding indexer and indexing is IMPORTANT as the splunk
licensing model is based upon indexing volume processed by splunk.  The more logs your indexer processes the more you have to pay.  So configuring the indexer properly will help you save money.   The indexer listens on port 9997/tcp



###  What is indexing ?

Fundamentally, an index within this contex is nothing but a directory located in $SPLUNK_HOME/var/lib/splunk where splunk
stores its processed data.  Indices consist of two types 
of files: 
-   raw data(full logs)
-   index files(keywords gleaned from logs)
-   Splunk Enterprise comes with a number of preconfigured indices, including:
    -   main: This is the default Splunk Enterprise index.  All processed data is stored here unless otherwise specified.
    -   _internal: This the default Splunk index. All processed data is stored here unless otherwise specified
    -   _audit: Contains events related to the file system change monitor, auditing, and all user search history
    -   _internal: Stores Splunk Enterprise internal logs processing metrics.

How splunk processes logs/data ?

Splunk indexer working can be derived in two stages -parsing phase and indexing phase as below:

1. Parsing stage

- While parsing splunk performs following operations on logs 
    a) Extracting a set of default for each event like :
        -   host
            -   An event's host value is typically the 
                -   hostname
                    -   hostname of forwarder host
                -   ip address
                    -   ip address of forwarder host
                -   source
                    -   The source of an event is the name of the file, stream, or other input from the forwarder host
                -   sourcetype
                    -   The source type of an event is the format of the data input from which it originates like windows .evt files or 

    b) Configuring character set encoding –Its nothing but way of storing character/words in memory

    c) Identifying line termination using linebreaking rules-if your logs are very long or messy then it will break them in small parts easy to understand

    d) Identifying timestamps or creating them if they don't exist –sort logs as per time or as they occured

    Splunk can be set up to mask sensitive event data  (such as credit card or social security numbers) at this stage. It can also be configured to apply custom metadata to incoming events.


2. Indexing stage --

Splunk indexing process:

    a) Breaking all events segments called "buckets" that can be searched.  You can determin the level of segmentation, which affects indexing and searching speed, search capability, and efficiency of disk compression.
    b) Building the index data structures
    c) Writing the raw data and index files to disk, where post-indexing compression occurs


```


┌───────┐       ┌───────┐      ┌───────┐    ┌───────┐
│       │       │       │      │       │    │       │
│       │       │       │      │       │    │       │
│       │       │       │      │       │    │       │
└───────┘       └───────┘      └───────┘    └───────┘
 Monitor         FIFO           UDP          Scripted
 Input           Input          Input        Input
   │               │              │             │
   │               │              │             │
   │               │              │             │
┌──▼───────────────▼──────────────▼─────────────▼─────┐
│                                                     │
│             Parsing Queue                           │
│                                                     │
└────────────────────────┬────────────────────────────┘
                         │
                         │
                         │
                         │
┌────────────────────────▼─────────────────────────────┐
│             Parsing Pipeline                         │
│                                                      │
│                                                      │
│        * source, event typing                        │
│        * character set normalization                 │
│        * line termination identification             │
│        * timestamp identification / normalization    │
│        * regex transforms, parse-time field creation │
│                                                      │
│                                                      │
│                                                      │
│                                                      │
│                                                      │
│                                                      │
│                                                      │
│                                                      │
└─────────────────────────┬────────────────────────────┘
                          │
                          │
                          │
┌─────────────────────────▼────────────────────────────┐
│         Index Queue                                  │
│                                                      │
└─────────┬────────────────────────────────────────────┘
          │
          │
┌─────────▼──────────────┐          ┌──────────────────────────┐
│     Indexing Pipeline  │   index  │         Splunk DB        │
│                        │   Files  │                          │
│     *segmenation       ├─────────►│                          │
│     *index building    │   raw    │                          │
│                        │   data   │                          │
│                        ├─────────►│                          │
└────────────────────────┘          └──────────────────────────┘

```



