url: https://www.baeldung.com/spring-graphql

Why GraphQL
=======================
    *   RESTful APIs follow clear and well-structured resource-oriented
        approach.
    *   However when the data gets more complest
        -   routes get longer
        -   at times it is not possible to fetch data with
            a single request.
            
    *   GraphQL structures data in the form of a graph with 
        it's powerful query-syntax for
            -   traversing data
            -   retrieving data
            -   modifyin data
            
            
     
     *  Predictable results from each and every query
     
     *  Fast, stable
     
     
     
Example of why REST is just ok...
==============================
Busines object **Student**
    
    {
        id:String,
        firstName:String,
        lastName:String,
        collegeName:String
    }
    
    
if there is a corresponding REST endpoint:

    /api/v1/students
    
This endpt will return all fields for each
Student object returned



Consider the GraphQL query given below...

{
    students{
        id
        firstName
    }

}


This will return values only for the id and firstName fields.
The query will not fetch values for other attributes
of the student object. The result of the query follows as such:

    {
       "data": {
          "students": [
             {
                "id": "S1001",
                "firstName": "Mohtashim"
             },
             {
                "id": "S1002",
                "firstName": "Kannan"
             }
          ]
       }
    }





GraphQL Schemas
==========================
The GrapQL serer expses a schema describing the API.  This 
scheme is made p of type definitions.  Each type has one or more
fields, which each take zero or more arguments and return 
a specific type. 

The graph is made up frm teh way these fields are nested with
each other.  Note tht there is no need for the graph to be
acyclic-cycles are perfectly acceptable --- but it is directed.  That is,
the client can get fromone field to its children, but it can't automatically
get back to the parent unless the schema defines this explicitly...


An example GraphQL Schema for a blog may contain the following
definitions, describing a Post, an Author of the post and a root.


    type Post {
	        id: ID!
	        title: String!
	        text: String!
	        category: String
	        author: Author!
	    }
	     
	    type Author {
	        id: ID!
	        name: String!
	        thumbnail: String
	        posts: [Post]!
	    }
	     
	    # The Root Query for the application
	    type Query {
	        recentPosts(count: Int, offset: Int): [Post]!
	    }  

    # The Root Mutation for the application
	    type Mutation {
	        writePost(title: String!, text: String!, category: String) : Post!
	    }
	    
	    
What's going on here ?
-------------------------
The "!" at the end of some names indicates that this is a non-nullable
type.  Any type that does not have this can be null in
the response from the server.  The GraphQL service handles these
correctly, allowing us to request child fields of nullable types safely.


The GraphQL Service also exposes th schema itself using a standard
set of fields, allowing any client to query for the schema
definition ahead of time.


This can allow for the client to automatically detect when the 
schema changes, and to allow for clients that dynamically adapt to
the way that schema works.

One inccredibly useful examnple of this is the  tool

GraphiQL tool -- discussed later -- that allows for us to
interact with any GraphQL API



Summary.....
=====================
GraphQL is an alterantive to REST.
Both require a server that allows for these
services to be offered.

*   SpringBoot
*   Node.js
*   .NET
*   etc









