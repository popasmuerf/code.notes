https://dzone.com/refcardz/an-overview-of-graphql?chapter=2
https://dzone.com/refcardz/an-overview-of-graphql?chapter=3
https://dzone.com/refcardz/an-overview-of-graphql?chapter=4

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




GraphQL Queries and Mutations
================================================
Queries and mutations are the entry point to the GrapQL
service



Fields 
------------------------------------------------------
Each type is composed of one or more fields, which can 
be scalar values or complex objects that refer to other types,
resultig in nesting.  All GraphQL quieries must at least
specify fields to be returned.  This is referred to as the "selection set"

//Conscider the following schema

type Query{
	topRatedMovies: [Movie]
}


type Movie{
	id: ID!
	title: String
	year: Int
	plot: String
	poster: String
	imdbRating: Float
	genres: [String]
	similar(limit: Int = 3):[Movie]
	rating: RATINg
	actors: [Actor]
	avgStars: Float
}


//The Query

{
	topRatedMovies{
		title
		year
		avgStars
	}
}


//result

{

  "data": {

    "topRatedMovies": [

      {

        "title": "Godfather, The",

        "year": 1972,

        "avgStars": 4.4875

      },

      {

        "title": "Shawshank Redemption, The",

        "year": 1994,

        "avgStars": 4.487138263665597

      },

      {

        "title": "On the Waterfront",

        "year": 1954,

        "avgStars": 4.448275862068966

      }

    ]

  }

}


Optionally we can include the operationtype and operation
name in our query, n additon to 
our selection set

//alternative query for topRatedMovies

	query TopRatedMovies{
		topRatedMovies{
			title
			year
			avgStars
		}

	}


Agruments 
--------------------------------------------------------
We can also pass arguments to our queries. Arguments can
be required or optional.  When using an optional argument,
we declare a default value.  We've seen an example of passing
an argument already, but here we also pass an argument to a
field on the Moie type as well as to our root level query:

	type Query{
		moviesByTitle(title:String!, limit: Int = 3): [Movie}
	}

//Query

	{
		moviesByTitle(title:"Matrix Reloaded"){
			title
			similar(limit: 2){
				title
				year
			}
		}
	}

//Result

{

  "data": {

    "moviesByTitle": [

      {

        "title": "Matrix Reloaded, The",

        "similar": [

          {

            "title": "Matrix, The",

            "year": 1999

          },

          {

            "title": "Lord of the Rings: The Fellowship of the Ring, The",

            "year": 2001

          }

        ]

      }

    ]

  }

}



Variables
-----------------------------------------------------
To avoid injection attacks by string interpolation
to build  quiries from dynamic or user-supplied content, we can use
avariables in our GraphQL query.  To use variables, we first 
delcare 

	$varName 

as a valid variable for our query, then
replace the value in the query with $varName.
Finally, we pass the key-value pair
 
	varName:value 
in a dictonary alongside the query

	query MoviesByTitle($movieTitle: String!, $similarLimit: Int) {

		  moviesByTitle(title: $movieTitle) {
		    title
		    similar(limit: $similarLimit) {
		      title
		      year
    		    }

                  }
      }

//result

{

  "data": {

    "moviesByTitle": [

      {

        "title": "Matrix Reloaded, The",

        "similar": [

          {

            "title": "Matrix, The",

            "year": 1999

          },

          {

            "title": "Lord of the Rings: The Fellowship of the Ring, The",

            "year": 2001

          }

        ]

      }

    ]

  }

}

