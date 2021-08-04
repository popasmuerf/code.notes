## Splunk Architecture: Data Flow, Components and Topologies
[Splunk Architecture: Data Flow, Components and Topologies](https://cloudian.com/guides/splunk-big-data/splunk-architecture-data-flow-components-and-topologies/)



Splunk is a distributed system that:
    -   aggregates
    -   parses
    -   analyses 

data...specifcially log data in most cases



## How Splunk Works: stages in teh Data Pipeline

Splunk is a distributed system that inges, processes and indexes log data.  Splunk processes 
data in three stages:


1. Data Input -- Splunk ingests the raw data stream from the source, breaks it into 64k blocks, and adds metadata keys which include:
    -   hostname
    -   source character encoding
    -   index data should be stored in
2. Data Storage -- Splunk parses log data, by breaking it into lines, identifying timestamps, creating individual events and annotating them with metadata keys.  It then transforms event data using transformation rules defined by the operator.  Finally, Splunk writes the parsed events to disk, pointing to them from an index file which enables fast search across hug data volumes.
    -   Parses data
    -   identifying timestamps
    -   creating individual events
    -   transforming event data using taransformation rules
    -   writes to disk
    -   index file points to parsed events on disk





## Splunk Components
The primary components in the Splunk architecture are:
    -   forwarder
    -   indexer
    -   search head


#### Forwarder
Splunk Forwarder is an agent you deploy on IT systems, which collect logs and sends them to the **indexer**.  Splunk has two types of forwarders:
    -   Universal Forwarder
        - Forwards the raw data without prior processing which is faster, and requires less resources ont eh host, but results in huge quantities of data being sent to the indexer
    -   Heavy Forwarder
        -   Performs parsing and indexingof  the source data, on the host machine, and sends only the parsed events to the indexer

#### Indexer
The indexer transforms data into events(unless it was recieved pre-processed from a heavy forwarder), and stores it to disk and adds it to an index enabling searchability.

The Indexer creates the folowing files, separating them into directories called **buckets**
    -   Compressed raw data
    -   Indexes pointing to raw data (.TSIDX files)
    -   Meatadata files

The indexer performs generic generic event processing 
on log data , such as :
    -   applying timestamps
    -   adding source
    -   user-defined transformations
    -   apply special rules such as filtering of unwanted events


Splunk enterprise, we can set up a cluster of indexers with replication between them to avoid data loss and provide more system resources and storage space to handle large data volumes


### Splunk Search Head
Search heads provide the UI users with an interface 
for interacting with Splunk.  It allows users to search and query Splunk data, and interfaces with indexers to
gain access to specific data they request.

Splunk provides for a distributed search architecture which allows you to scale up to handle large data volumes, and better handle access control and ge-dispersed data.  In a distributed search scenario, the search head sends search rquests to a group of indexers, also called **search peers**.  the indexers perform the search locally and return results to the search head, which merges the results and  returns them to the user.

### Common topologies for distributed search in Splunk
There are few common topologies for distributed search in Splunk:
    -   One of more independent search heads to search across indexers(each can be used for a different type of data)
    -   Multiple search heads in a search head cluster -   With all search heads sharing the same configuration and jobs.  This is a way to scale up search.
    -   Search heads as part of an indexer cluster -- promotes data avaliability and data recovery

### Putting it All Together: Splunk Architecture

**From top to bottom:**

-   Splunk gathers logs via the Universal/Heavy Forwarder by
    -   Monitoring files
    -   detecting file changes
    -   listening on ports
    -   running scripts to collect log data

-   The indexing mechanism, composed of one or more indexers, processes the data, or may recieve the data preprocessed by forwarders
    -   The deployment server manages
        -   indexers
        -   search heads
        -   configuration policies across entire Splunk deployment
    -   User access and controls are applied at the indexer level -- each indexer can be used for a different data store, which may have different user permissions.
- The suer can define Scheduling, Reporting and Knowledge objects to schedule searches and create alerts
- Data can be accessed from the UI, the Splunk CLI, or APIs integrating with numerous external systems.
