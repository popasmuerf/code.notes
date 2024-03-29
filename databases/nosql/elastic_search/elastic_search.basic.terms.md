[source](https://logz.io/blog/10-elasticsearch-concepts/)

## 10 Elasticsearch Concepts you need to learn...



### 1. Fields
- smallest individual unit of data in Elasticsearch.
- are customizable
- may includes:
    * title
    * author
    * date
    * summary
    * team
    * score
 
- each field has a defined datatype and contains a single piece of data
    * strings
    * numbers
    * dates
    * booleans
    * complex types(objects and nested objecs)
    * geo datatypes
        - get_point
        - get_shape
    * specialized datatypes
        - token count
        - join
        - rank feature
        - dense vector
        - flattened
        - etc
    
There are different inds of fields 
and ways to manage them.  Fields are 
one of several mechanisms for Elasticsearch mapping.
    
**Multi-fields**
These fields can (and should) be indexed in 
more than one way to produce more search results.
This option is available easily throught he
"Multi-fields" option, which as you might have guessed allowed for 
fields to be indexed in multiple ways.  For example, 
something might be indexed either as free text or as 
specific keyword.





**Meta-fields**
Meta-fields deal with a document’s metadata. This variety of fields will be further elaborated later on under the Mapping heading.



### 2. Documents

Documents are JSON objects that are stored within an Elasticsearch
index and are conscidered the base unit of storage.  In the world
of relational databases, documents can be compared to a row 
in table.


For example, let's assume that you are running an e-commerce application.
You could have one document per product or one document per order.
There is nolimit to how many documents you can store in a particular
index.

Data in documents is defined with fields comprised of keys and values. A key is the name of the field, and a value can be an item of many different types such as a string, a number, a boolean expression, another object, or an array of values.

Documents also contain reserved fields that constitute the document metadata such as:


    _index – the index where the document resides
    _type – the type that the document represents
    _id – the unique identifier for the document

An example of a document :

    {
       "_id": 3,
       “_type”: [“your index type”],
       “_index”: [“your index name”],
       "_source":{
       "age": 28,
       "name": ["daniel”],
       "year":1989,
    }
    }



### 3. Mapping

As far as mapping goes, bear in mind that since Elasticsearch 7.0, index type has been deprecated. The following is still relevant to legacy versions of Elasticsearch. Data type is still active.

Like a schema in the world of relational databases, mapping defines the different types that reside within an index (although for 6.0 until its deprecation in 7.0, only one type can exist within an index). It defines the fields for documents of a specific type — the data type (such as keyword and integer) and how the fields should be indexed and stored in Elasticsearch. This includes meta-fields, such as _index, _type, and _id.

    # Example
    curl -XPUT localhost:9200/example -d '{
      "mappings": {
        "mytype": {
          "properties": {
            "name": {
              "type": "string"
            },
            "age": {
              "type": "long"
            }
          }
        }
      }
    }'

### 4. Mapping Types
Not to be confused with datatypes, mapping types are now a legacy aspect of Elasticsearch, related to all previous versions released prior to Elasticsearch 7.0.0. However, they remain critical when dealing with those previous iterations. Each mapping type could have had its own field. This led to confusion because fields with the same name even in completely separate mapping types would have to be simultaneously defined as the same datatype (even though the datatypes would not necessarily match).

Elasticsearch types were used within documents to subdivide similar types of data wherein each type represents a unique class of documents. Types consist of a name and a mapping (see below) and are used by adding the type field. This field can then be used for filtering when querying a specific type.

An index could have had any number of types, and you can store documents belonging to these types in the same index.



### 5. Index
Indices, the largest unit of data in Elasticsearch, are logical partitions of documents and can be compared to a database in the world of relational databases.

Continuing our e-commerce app example, you could have one index containing all of the data related to the products and another with all of the data related to the customers.

You can have as many indices defined in Elasticsearch as you want. These in turn will hold documents that are unique to each index.

Indices are identified by lowercase names that refer to actions that are performed actions (such as searching and deleting) on the documents that are inside each index.

For a list of best practices in handling indices, check out the blog Managing an Elasticsearch Index. 

Another key element to getting how Elasticsearch’s indices work is to get a handle on shards.

### 6. Shards
Shards area a single Lucene index.  They are the building blocks
of Elasticsearch and what facilitate it's scalability.

Index size is a common cause of Elasticsearch crashes.  There is no
limit to how many documents you can store on each index, and index may take 
up an amount of disk space that exceeds the limits of the hosting 
server.  As soon as an index approaches this limit, indexing will begin 
to fail.

One way to counter this problem is to split up indices horizontally into
pieces called **shards**.  This allows you to distribute operations **across**
**shards** and **nodes** to improve peformance.


When you create an index, you can define how many shards you want.
Each shard is an independent Lucence index that can be hosted anywhere in your
cluster:

    # Example
    curl -XPUT localhost:9200/example -d '{
      "settings" : {
        "index" : {
          "number_of_shards" : 2, 
          "number_of_replicas" : 1 
        }
      }
    }'



### 7. Replicas

Replicas, as the name implies, are Elasticsearch
fail-safe mechanisms and are basically
copies of your index's shards.  This is useful
backup system for a rainy day --- or, in other words,
when a node crashes.


Replicas also serve read requests, so adding replicas can 
help to increase search performance.

To ensure high availability, replicas are not placed on the 
same node as the original shards (called the "primary" shard)
from which they are replicated.  For example:

Shard-1 might share a Node-A with Replica Shard-2, while 
Node-B hosts Shard 2 and Replica Shard 1.  Ina  true use case,
there will be several more shards.


Like with shards, the number of replicas can be defined per index when the index is created. Unlike shards, however, you may change the number of replicas anytime after the index is created. In other words, you can have more than one replica for each shard, but there is a balance to be struck between having too few and too many shards. More shards result in more overhead and resource usage, as well as can affect performance and speed.

See the example in the “Shards” section above.

### 8. Analyzers
Analyzers are used during indexing to break down – or parse – phrases and expressions into their constituent terms. Defined within an index, an analyzer consists of a single tokenizer and any number of token filters. For example, a tokenizer could split a string into specifically defined terms when encountering a specific expression.

The most common analyzers include the Standard Analyzer and the Simple Analyzer, as well as several language-specific analyzers. 

By default, Elasticsearch will apply the Standard Analyzer, which contains a grammar-based tokenizer that removes common English words and applies additional filters. Elasticsearch comes bundled with a series of built-in tokenizers as well, and you can also use a custom tokenizer.

A token filter is used to filter or modify some tokens. For example, a ASCII folding filter will convert characters like ê, é, è to e.

    # Example

    curl -XPUT localhost:9200/example -d '{
      "mappings": {
        "mytype": {
          "properties": {
            "name": {
              "type": "string",
              "analyzer": "whitespace"
            }
          }
        }
      }
    }'


### 9. Instances and Nodes
The heart of any ELK setup is the Elasticsearch instance, which has the crucial task of storing and indexing data.

In a cluster, different responsibilities are assigned to the various node types:

    Data nodes — stores data and executes data-related operations such as search and aggregation
    Master nodes — in charge of cluster-wide management and configuration actions such as adding and removing nodes
    Client nodes — forwards cluster requests to the master node and data-related requests to data nodes
    Tribe nodes — act as a client node, performing read and write operations against all of the nodes in the cluster
    Ingestion nodes (this is new in Elasticsearch 5.0) — for pre-processing documents before indexing
    Machine Learning nodes (Basic License) – These are nodes available under Elastic’s Basic License that enable machine learning tasks. Machine learning nodes have xpack.ml.enabled and node.ml set to true.

By default, each node is automatically assigned a unique identifier – or name – that is used for management purposes and becomes even more important in a multi-node, or clustered, environment. All nodes are also capable by default of being master nodes, data nodes ingest nodes or machine learning nodes. It is recommended to distinguish each node by a single type, especially as clusters grow larger.

When installed, a single node will form a new single-node cluster entitled “elasticsearch,” but it can also be configured to join an existing cluster (see below) using the cluster name. Needless to say, these nodes need to be able to identify each other to be able to connect.

In a development or testing environment, you can set up multiple nodes on a single server. In production, however, due to the number of resources that an Elasticsearch node consumes, it is recommended to have each Elasticsearch instance run on a separate server.


### 10. Cluster


An Elasticsearch cluster is comprised of one or more Elasticsearch nodes. As with nodes, each cluster has a unique identifier that must be used by any node attempting to join the cluster. By default, the cluster name is “elasticsearch,” but this name can (and should) be changed, of course. Be sure not to use the same name for one cluster in different environments, otherwise nodes might be grouped with the wrong cluster.

One node in the cluster is the “master” node, which is in charge of cluster-wide management and configurations actions (such as adding and removing nodes). This node is chosen automatically by the cluster, but it can be changed if it fails. (See above on the other types of nodes in a cluster.)

Any node in the cluster can be queried, including the “master” node. But nodes also forward queries to the node that contains the data being queried.

As a cluster grows, it will reorganize itself to spread the data. Even though clusters are designed to host multiple nodes, you can assign only node to a cluster if it is so desired.

There are a number of useful cluster APIs that can query the general status of the cluster.

For example, the Cluster Health API returns health status reports of either “green” (all shards are allocated), “yellow” (the primary shard is allocated but replicas are not), or “red” (the shard is not allocated in the cluster). Read more about cluster APIs here.

    # Output Example
    {
      "cluster_name" : "elasticsearch",
      "status" : "yellow",
      "timed_out" : false,
      "number_of_nodes" : 1,
      "number_of_data_nodes" : 1,
      "active_primary_shards" : 5,
      "active_shards" : 5,
      "relocating_shards" : 0,
      "initializing_shards" : 0,
      "unassigned_shards" : 5,
      "delayed_unassigned_shards" : 0,
      "number_of_pending_tasks" : 0,
      "number_of_in_flight_fetch" : 0,
      "task_max_waiting_in_queue_millis" : 0,
      "active_shards_percent_as_number" : 50.0
    }









































