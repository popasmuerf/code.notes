url:https://javarevisited.blogspot.com/2013/07/how-ssl-https-and-certificates-works-in-java-web-application.html
How SSL, HTTPs and Certs work in Java 
Apps(and pretty much any other app
=======================
    *   HTTPS/SSL
        -   Provides both encryption and verification of
            websites
        -   Used to encrypt data before it is sent over the wire
            and after it has been recieved.
        -   Facilitates verification of target sites/services via
            the use of certs issued by third party issuers like
                *   Verisign
                *   godaddy
                *   thwate
                *   Google trust services
                *   etc
        
    *   How SSL uses Certification for Identification
        -   client initiates connection to server
        -   server replies with certs issued by trusted third party issuer
        -   If it is a Java application(server), the certs maybe be stored in accessed
            from it's keystore and truststore
        -   The client will also posses both the cert in it's
            trusted cert store and validates any cert presented by
            the server.
        -   Summary:
            *   Upon initial connect both the client and server must
                possess trusted certs
                
                
    *   Ok what is a trustStore and a KeyStore in Java, and what's the difference ?
        -   Both are used in the context of setting up SSL connections in Java
            applications between clients and servers
        -   They are both similar in terms of construct and structure as both
            are managed by the **keytoolcommand** represnted by 
            the KeyStore programmatically...but they are both DIFFERENT and are not
            the same.
        -   TrustStore
            *   verifies credentials
            *   stores certs from third parties
                -   Third party certs are used to 
                    verify that you are who you say you are.
            *   Is used by the TrustManager object
            *   Specifying the path to the truststore file
                -   -Djavax.net.ssl.trustStore   
        -   KeyStore
            *   provides credentisls
            *   stores private keys
            *   stores certs
                -   certs correspond to public key
            *   required if the SSL target requires client authentication
            *   Is used by the KeyManager object
            *   Specifying the path to the keystore file
                -   -Djavax.net.ssl.keyStore
                
                
            
    *   An important thing to note about TrustStores and KeyStores
        -   Personal Certificates...if we choose to use them
            along side your thirdparty issued certs
            
            -   You can still use the trustStore and keyStore to avoid
                maintaining two separate files, but it is a good idea
                to segregate public keys and private keys int
                tow different files, it's more verbose and self-explanatory
                that which one holds CA certs to trust the server nd which
                contains the client's private keys
            
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









