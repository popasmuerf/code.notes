https://dzone.com/refcardz/an-overview-of-graphql?chapter=2


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



