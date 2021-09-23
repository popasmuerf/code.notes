[Elasticsearch - API Conventions](https://www.tutorialspoint.com/elasticsearch/elasticsearch_api_conventions.htm)



# Elasticsearch - API Conventions


Elasticsearch provides a REST API, which is accessed by JSOn over HTTP.
Elasticsearch uses some conventions which we shall discuss now.


### Multiple Indices

Most of the operations, mainly searchingand other operations,
using the ES APIs are for querying one or more than one indices.


This helps the user to search in multiple places or all the available data by 
just executing a query once.


Many different notations are used to perform operations in multiple indices.
We will discuss a few of them here in this chapter.


#### Comma Seperated Notation

    POST /index1,index2,index3/_search
    
#### Request Body

    {
       "query":{
          "query_string":{
             "query":"any_string"
          }
       }
    }

