[source:What is an Elasticsearch Index?](https://www.elastic.co/es/blog/what-is-an-elasticsearch-index)

## What is an Elasticsearch Index ?

What exactly is an idenx in Elasticsearch ?  Despite being a very basic question,
the answer is suprisingly nuanced.


### Basic Definitiion

```
An index is like a 'database' in a relational database.  It has a
mapping which defines multiple types.

An index is a logical namespace which maps to one or more primary 
shards can have zero or more replica shards
```

Ok.  So there are two concepts in that definition.  First,
an index is some type of data organization mechanism, allowoing
the user to partition data a certain way.  The 
second concept relates to replicas and shards, the mechanism 
Elastcsearchy uses to distribute data around the 
the cluster.

...Let's explore the fist concept, using indices to organize data...


### Indices for Relations

The easiest and most familiar layout clones what you would expect
from  a relational database.  you can (very, very roughly) think of an 
index like a database.

        MySQL --> Databases --> Tables --> Columns/Rows

        ES --> Indices --> Types --> Documents with Properties
        
An Elasticsearch cluster can contain multiple Indices (databases), 
which in turn contain multiple Types(tables).  These types hold
multiple Documents (rows), and each document has Properties(columns)


So in your car manufacturing scenario, you may have a **SubaruFactory**
index.  Within this index, you have three different types:

*   People
*   Cars
*   Spare_Parts




Each type then contains documents that correspond tot hat type(e.g.
a Subaru Impressza doc lives inide of the **Cars** type.  This doc contains
all the details about th eparticular car).

Searching and querying takes the format of :

        http://localhost:9200/[index]/[type]/[operation]
        
so to retrieve the Subaru document, I may execute this http command:

    curl -XGET localhost:9200/SubaruFactory/Cars/SubaruImprezzza
    
    


###  Some Examples...

#### Kibana Dev tools console...

    > PUT school


    //Response

    {
      "acknowledged" : true,
      "shards_acknowledged" : true,
      "index" : "school"
    }

    200 - OK


    > POST school/_doc/10
    {
       "name":"Saint Paul School", "description":"ICSE Afiliation",
       "street":"Dawarka", "city":"Delhi", "state":"Delhi", "zip":"110075",
       "location":[28.5733056, 77.0122136], "fees":5000,
       "tags":["Good Faculty", "Great Sports"], "rating":"4.5"
    }


    #Response
    
    {
      "_index" : "school",
      "_type" : "_doc",
      "_id" : "10",
      "_version" : 1,
      "result" : "created",
      "_shards" : {
        "total" : 2,
        "successful" : 1,
        "failed" : 0
      },
      "_seq_no" : 0,
      "_primary_term" : 1
    }
    
    201 - Created

    
    > POST school/_doc/16
    {
       "name":"Crescent School", "description":"State Board Affiliation",
       "street":"Tonk Road",
       "city":"Jaipur", "state":"RJ", "zip":"176114","location":[26.8535922,75.7923988],
       "fees":2500, "tags":["Well equipped labs"], "rating":"4.5"
    }
    
    #Response
    {
      "_index" : "school",
      "_type" : "_doc",
      "_id" : "16",
      "_version" : 1,
      "result" : "created",
      "_shards" : {
        "total" : 2,
        "successful" : 1,
        "failed" : 0
      },
      "_seq_no" : 1,
      "_primary_term" : 1
    }


    201 - Created




    GET school/_doc/10
    
    #Response
    {
      "_index" : "school",
     "_type" : "_doc",
      "_id" : "10",
      "_version" : 1,
      "_seq_no" : 0,
      "_primary_term" : 1,
      "found" : true,
     "_source" : {
       "name" : "Saint Paul School",
       "description" : "ICSE Afiliation",
       "street" : "Dawarka",
        "city" : "Delhi",
        "state" : "Delhi",
        "zip" : "110075",
       "location" : [
          28.5733056,
         77.0122136
        ],
        "fees" : 5000,
        "tags" : [
          "Good Faculty",
          "Great Sports"
        ],
        "rating" : "4.5"
     }
   }



### Indices for Logging

The reality of Indices/Types are much more flexible than the 
Database/Table abstractions we are used to in RDBMs.  They can be
considered convenient data organizatin mechanisms, with added performance
benefits depending on how you set up your data.


To demonstrate a radically different approach, a lot of people use Elasticsearch
for logging


To demonstrate this different approach, a lot of people use Elasticsearch for
logging. A standard format is to assign a new index for each day.  For example:

    logs-2013-20-22
    logs-2013-20-21
    logs-2013-02-20
    
Elasticsearch allows you to query multiple indices at the same time, so it isn't 
a problem to do: 

        curl -XGET localhost:9200/logs-2013-02-22,logs-2013-02-21/Errors/_search?query="q:Error Message"




The above searches the logs from the last two days at the same time.  This format
has advantages due to the nature of logs -- most logs are never looked at and they
are organized in a linear flow of time.  Making an index per log is 
more logical and offers better performance for searching.

This is akin to partitioning a RDBM table by time ranges, except we are creating new
indices for each partiion.  This is a concept that RDBM's would scoff at...
a new database for each day? Crazy !!!


Indices are fairly lightweight data organization mechanizms, so Elasticsearch
will hapily let you create hundres of indices

This is pure speculation at the moment...but it appears that indices are little 
more than pointers that reference arrays of types...which are in turn
pointers that reference arrays of documents.....so yeah....of course
they take up little resources....


## Indices for Users
Another radically different approach is to create an index per user.  
Imagine you have some social networking site, and each user has a large 
amount of random data.  You can create a single index for each user.
Your structure may look like :



    Zach's Index
        Hobbies Type
        Friends Type
        Pictures Type
    Fred's Index
        Hobbies Type
        Friends Type
        Pictures Type

We could have done this in the RDBM way...just throwing it all into a 
one User Index...but insteead it sometimes makes sense to split data 
apart for data organization and performance reaons.  In this scenario,
we are assuming each user has a lot of data and we
want them separate.  Elasticsearch has no problem letting us
create an index per user...but again...we could get similar performance
with a RDBM with just one bit user table...and no normalization...but not
as fast as this...for what should be obvious reasons....unless of course
we index certain rows...or all of them....





### Indices for data distribution

The first three examples dealt entirely with how data should be logically separated, allowing it to be represented naturally and efficiently.

However, the definition of an Index also includes that bit about shards and replicas. Underneath all the indices and types and documents, Elasticsearch has to store the data somewhere. This functionality is stored into shards, which are either the Primary or Replica

Each index is configured for a certain number of primary and replica shards. So taking the "User" example above, if you created an index for every user, you are also creating a set of shards for each user.

This is neither good or bad, simply a consideration when planning your cluster. Different performance requirements benefit from different shard layouts. I'm purposefully leaving this section short, since properly covering shards will require an article of its own.

So just remember, Indices organize data logically, but they also organize data physically through the underlying shards. 






























 



