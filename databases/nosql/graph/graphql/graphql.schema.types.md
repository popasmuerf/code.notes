https://dzone.com/refcardz/an-overview-of-graphql?chapter=2
https://dzone.com/refcardz/an-overview-of-graphql?chapter=3

A simple GraphQL example
============================
//Simple GraphQL schema:
type Movie{
    id: ID!
    title:String
    year:Int
    plot:String
    genres:[String]

}

type Query{
   moviesByTitle(title:String!, limit: Int!):[Movie]
}

What's going on here ?
---------------------------------
Here we define a movie type, the fields that exist for 
Movie, and a query, moviesByTitle, that takes two arguments:

	title
	limit

both of whicha re required(indicated by the exclamation point).
The moviesByTitle query returns an array of 
Movie objects...


What about a simple query to search for movies that contain the string "Matrix" ?

{
    moviesByTitle(title: "Matrix", limit: 3){
        title
        year
    }
}



Result of our query...

{

  "data": {

    "moviesByTitle": [

      {

        "title": "Matrix, The",

        "year": 1999

      },

      {

        "title": "Matrix Reloaded, The",

        "year": 2003

      },

      {

        "title": "Matrix Revolutions, The",

        "year": 2003

      }

    ]

  }

}


Note that we haven't covered how to actually ftch this data 
from our data layer...

that logic is implemented in our GraphQL service'sresolver function that
handle the individual fields of our query...

We will see how to build resolvers in the next section, but 
first let's look at GraphQL schemas and the type system in morue detail...




GraphQL Schema and Types
============================================================
Building a GraphQL service requires a schema to be defined that 
describes the:

    types
    fields
    queries


that we will be able to use in our API.  You can think of the
schema as the underlying API blueprint or specification.  GraphQL
services can be implemented in any language ,so we need a language-agnostic 
way to define our GraphQL schema.  We us
the GraphQL schema language (also called the GraphQL interface Description Language or IDL) to define our schema and types...




Object types
----------------------------------------------
Description: 
	An object type that can be fetched including
	whatfields it provides.  For example "Movie" is
	an object type, with fields:
	
		title
		year
		generes
		plot
		[Movie]

	"!" indicates a required field

Example:

		type Movie { 
		  id: ID! 
		  title: String 
		  year: Int 
		  plot: String 
		  poster: String 
		  genres: [String]
		  similar: [Movie]
		  rating: RATING 
		  actors: [Actor]
		  avgStars: Float 
		}


	
Scalar types
---------------------------------------------------------

Description: 
	Common primitive types. By default:

		Int,
		Float,
		String,
		Boolean,
		ID
		(serialized as a string
		but not necessarily to be
		human readable


	

Example:

		title: String



Query Types
---------------------------------------------------------

Description: 
	An entry point into a GraphQL service.
	The Query type defines the queries available for
	the GraphQL service:

		type Query{
			moviesByTitle(title:String!, limit: Int = 3: [Movie]
		}


	

Example:

	type Query{
			moviesByTitle(title:String!, limit: Int = 3: [Movie]
		}


Interface types
----------------------------------------------------------
Description:
	Abstract type that includes a set of fields that must
	be implementd by another type.  Interface types
	are used when returning an object that can be
	one of several types


Example:
		interface Person{
			id:ID!
			name:String
		}




Union types
----------------------------------------------------------
Description:
	Similar to interface types, however Union tpes 
	don't specfiy common fields


Example:
		union PersonResult = User | Actor



Input types 
----------------------------------------------------------
Description:
	Used to pass complex objects to a mutation 
	or a query


Example:
		input ReviewInput{
			rating: Int!
			movieId: ID!
			userId: ID!
		}







