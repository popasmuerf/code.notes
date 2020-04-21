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
