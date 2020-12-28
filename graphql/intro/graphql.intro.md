url: https://www.baeldung.com/spring-graphql
url: https://dzone.com/articles/graphql-with-springboot

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




GraphQL is a Query Language for web APIs...how meta is that ?
======================================================================
The basic need of most applications is to fetch data from the backend;
which could be:
    *   Third-party Application
    *   A database
    *   A network file system
    
REST was novel back in the day....but as always...the pace of development
accelerates.....


REST vs GraphQL
=========================================
1. Network performance
    1.1 UI's don't have control over the response data for REST APIs
    1.2.UI's however are provided for amechanism to specify fields
        of iknterest in response.  This reduces snetwork overload by fetching
        the smallest data possible 
    1.3 GraphQL will only hit the APIs/Databases/File Systems that it needsw
        to according to submitted query...
        
2. Endpoints
    2.1  In REST, each resource is identified by a
         URL.  This makes the client obliged to know each endpoint.
    2.2  GraphQL, all resources are identified by a single endpoint.
         Thre is no hassle of maitaning multiple URI's
         
3. Data Fetching Strategy

    3.1.  In GraphQL, we have only one endpoint.
    3.2.  The client sends a single query with the required fields.
    3.3.  This helps with improved network peformance and avoids the
          over-retching/underfetching data problem


The main terms we need to become familar with ...
==============================================================
1.  Schema
    1.1.    The contract between the GraphQL client
            and the GrapQL server

2.  Query
    2.1.    Similar to GET call in REST and used by 
            the client to query the fieds

3.  Mutataions 
    3.1.    Simlar to a POST/PUT call in REST and is used by the client for any
            insert/update operation




                                                   +------->+-------------+
                                                   |        |  REST API   |
                                                   |        +-------------|
                                                   |        |-------------+
 +-----------------+           +-------------------+        |
 |  Graphql Client |           |   Grapql Server   <--------+
 |-----------------|           |-------------------|
 |                 |           |                   |        +--------------+
 |                 +----------->                   +------->|  Database    |
 |                 <-----------+                   |        |--------------|
 |                 |           |                   <--------+              |
 |                 |           |                   <--------+--------------+
 +-----------------+           +-------------------+        |
                                                   |        |
                                                   |        |
                                                   |        |
                                                   |        |--------------+
                                                   |        +  NFS         |
                                                   +------->|--------------|
                                                            |              |
                                                            +--------------+



Schema and Type System
===================================================================
GraphQL uses Schema Definition Language (SDL) to write the schema, which is a contract between client and server. In the schema, we define all the fields and functionalities exposed by APIs.

Once we have this schema in place, both the client and the server can continue their development independently. The client can mock the data until the server is ready.

Here is an example schema for Student and his Address. This schema contains a type definition for Student and Address. Each type may have one or more fields. In our example, Student and Address has 5 and 3 fields respectively. The non-nullable fields are represented with ! at the end of the field definition.

The relationship between types can also be seen in the below example. The Address type is
referred to in the Student type definition.


        type student{
            Id: ID!,
            name:String,
            age: Int!,
            phone:String 
            address:Address!
        }

        type Address{
            street:String!
        }
        
        type Query{
            students(name:String);
        }

        type Mutation {
            createStudent(name:String!,age:String, phone:String!);
        }
        
        
GraphQL Query
==================================================================
In the above example, the GraphQL query contains the root 
field, in other words, **Students* and query's payload **name** and 
**age**.

This query below also takes an arugment student name.  this query
returns the student's name and their age whose name
matches to Smith


        query{
            students(name:"Smith"){
                name
                age
            }
        }


Mutations
=================================================================
This is similar to a REST POST method.  If we need an API to
create/modify data, then we can go for mutations.  Possible mutations 
are :


    1. Creating new data
    2. Modifyoing exsiting data.
    
    
Example
------------------------------------------------------------------
        mutation createStudent($req:    StudentInput){
            createStudent(input: $req)
                name
                address{
                    city 
                    zipcode
                }

        }
        
        Query Variable:
        {
            "req":{
                "name":"Smith"
                "age":30,
                "phone":97123 56731",
                "address":{
                    "street":"1st Main",
                    "city"  :"Bengaluru",
                    "zipcode": "560066"
                }
            
            }
        }



Resolvers
=======================================================
Resolvers are functions written in the GraphQL server
corresponding to each field in GraphQL query/mutations
When a request comes to the server, it will invoke resolvers'
corresponding to fields mentioned in the query.



Scheam and Resolvers
========================================================
Schemas must be written in classpath with the extension
**graphqls** .  We can have as many schema files as we requrie.

Each type defined in teh schema must have field resolvers.  

**FieldResolverError results if the GraphQL server
cannot find the resolver for any given field.

Along with field resolvers, it is required to have 
**Query resolvers**
**Mutationresolvers**


Summary...of resolvers we need to make this work..
-------------------------------------------------------
        **Field Resolvers**
        **Query Resolvers**
        **Mutation Resolvers**
        
        
        
        
        
        
        
        //Query resolvers for Students example:

        import com.coxautodev.graphql.tools.GraphQLQueryResolver;
        import com.sample.graphql.modal.Student;
        import com.sample.graphql.service.StudentService;
        import org.springframework.beans.factory.annotation.Autowired;
        import org.springframework.stereotype.Component;

        @Component
        public class StudentQueryResolver implements GraphQLQueryResolver
        {
            @Autowired
            private StudentService studentService ;
            public Student student(String name) 
            {
                return studentService.getStudentDetailsByName(name);
            }
        
        }


        //Mutation resolver for Student example:

        import com.coxautodev.graphql.tools.GraphQLMutationResolver ;
        import com.sample.graphql.model.Student;
        import com.sample.graphql.service.StudentService ;
        import org.springframework.beans.factory.annotation.Autowired ;
        import org.springframework.stereotype.Component ;

        @Component
        public class StudentMutationResolver implements
        {
            @Autowired
            private StudentService studentService ;
            public Student student(Student student) 
            {
                return studentService.createStudentRecord(student);
            }
        }   
        
        


        //Sample Mutation Query
        mutation createStudent($req:StudentInput){
            createStudent(input: $req){
                name
                address{
                    city
                    zipcode
                }
            }
        }
        
        
        //Sample POST Body
        {
            "req": {
            "name":"FooBar",
            "age":30,
            "phone":"000-777-93-11",
            "address":{
                "street":"1st Main",
                "city":"Bengaluru",
                "zipcode":"20874"
            }
            }
        }




Limitations
===========================================================================
GrapQL is indeed a great way to build and query APIs, but it does have certain limitations:

    *   Nested quieries having multiple fields could lead to peformance issues.
        GraphQL queries must be designed with care as the control is with the client and it
        could basically ask anything.
        
    *   Web caching is easier with REST compared to GraphQL, as the latter has a single 
        endpoint.
        
        
    *   Recursive object retrieval at infinitum is not supported.  The depth 
        must be specified during recurisve quieries.







