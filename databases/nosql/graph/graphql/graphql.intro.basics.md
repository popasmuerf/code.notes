What is GraphQL ?


GraphQL is an open-source data query and manipulation language for
APIs and a runtime for fulfilling quieries with exsiting data.

GraphQL is an alternative to REST, GraphQL is quickly gaining popularity as
a toll for building APIs.


What is GraphQL ?
===================================================
url: https://dzone.com/refcardz/an-overview-of-graphql?chapter=1
url: https://www.tutorialspoint.com/graphql/graphql_environment_setup.htm
Despite what the name seems to imply, GraphQL is not per
se a query language for graph databases --- it is instead a query language
and runtime for buidling APIs.

The "graph" component of the name comes from the data model that GraphQL
uses to work with application domain data, making the observation that your 
application data is a graph.   Connected entities is the natural way that we 
intuitively think of our data, and GraphQL allows us to expres our data
in the same way we think about it, as a graph..

GraphQL itself is simply a specification, and there are many great tools
and libraries availbable for building GraphQL APIs  in amlst ever language,
as well as clients to simplify the process of efficiently querying GraphQL
services.  The graphql-js reference implementation is the 
standard GraphQL service implementation...



Why GrapQL
========================================
RESTful APIs follow clear and well-structured resource-oriented approach.
However , when the data gets more complex, the routes get longer.
Sometiems it is not possible to fetch dta with a single request.  This is where GraphQL comes handy.  

GraphQL structures data int eh form of a graph with its powerful query syntax for 
traversing, retrieveing and modifying data.



Ask for what youwant -- and get it
=======================================
Send a GraphQL query to our AI and get exactly what you need.  GraphQL queries always return predictable results.  Applications using GraphQL are fast and stable.  Unlike
Restful services, these applications can restrict data tha should be fetched from teh server.


Let us consider a business object "Student" with the following attributes...

	struct Student{
		id
		firstName
	}

What if some mobile application needs to fetch only the firstName and id ?
If we design a REST endpoint like

	/api/v1/students

it will end up fetching data for all the fields for the student object.
This means, data is over fetched by the RESTful service.

This problem cna be sovled by using GraphQL.
Consider the GraphQL query given below...

//query
{
	students{
		id
		firsName
	}
}


This will return values only for the id and firstname fields.  The query will not etch values
for other attributes of the student object.
The response of the query illustrated above is shown below...


{
	"data":{
		"students":[{
			"id":"S1001",
			"firstName":"Mohtashim"
		},
		{
			"id":"S1002",
			"firstName":"Kannan"
		}
		]
	}
}



Get many resources in a sigle request...
=========================================================
GraphQL queries help to smooothly retrive associated businessobjects, while 
typical REST APIs require loading from multiple URLs
GraphQL can APIs fetch allthe data your applicationneed in a single request.  Applications
using GRaphQL can be quick envenon a slow mobile network connections.

What if we have a business object named "College" which has the attributes:
	name
	location

The Student bsiness object has an association relationship with
the College object.

If we were to sue REST API in order to fetch the details of students
and their colleg, we will end up making two requests to the serfer:

	/api/v1/students
	/api/v1/colleges

This will lead to under fetching of data with each request.
So here mobile applicas can fetch details for both Student and College objects in a single rquest by using GraphQL.


The following is a GraphQquery to fetch data...

	{
		students{
			id
			firstName
			lastName
			college{
				name
				location
			}
		}


	}


The output of the above query contains exactly those fields we
have requested for as shown below....


{
   "data": {
      "students": [
         {
            "id": "S1001",
            "firstName": "Mohtashim",
            "lastName": "Mohammad",
            "college": {
               "name": "CUSAT",
               "location": "Kerala"
            }
         },
         
         {
            "id": "S1002",
            "firstName": "Kannan",
            "lastName": "Sudhakaran",
            "college": {
               "name": "AMU",
               "location": "Uttar Pradesh"
            }
         },
         
         {
            "id": "S1003",
            "firstName": "Kiran",
            "lastName": "Panigrahi",
            "college": {
               "name": "AMU",
               "location": "Uttar Pradesh"
            }
         }
      ]
   }
}



Describe what's possible with a type system
====================================================
GraphQL is strongly typed and the queries are based on fields and ther associated data types.
If there is a type mismatch in a graphQL query, server applications return clear and helpful error messages.  This helps in smooth debugging  and easy detecton bugs by client applications.  GraphQL also procides a client side liberaries



An example of the Student and ollege data types is given below...

type Query{
    students:[Student]
}

type Student{
    id:ID!
    firstName:String
    lastName:String
    fullName:String
    college:College
}

type College {
   id:ID!
   name:String
   location:String
   rating:Float
   students:[Student]
}







