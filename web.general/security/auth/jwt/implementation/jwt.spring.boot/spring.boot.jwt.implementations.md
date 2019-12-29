url: https://dzone.com/articles/spring-boot-security-json-web-tokenjwt-hello-world

JWT implimenation tutorial
=====================================


Design
==========================================

Client					Server
-----					------
1.POST username/passwd			2. Validate the username and password
					   generate jwt using secret key
					3. Return the generated JWT
4.GET /hello with 			5. Validate JWT using secret key
  JWT in the HEADER			6. Return GET resp





top level design
================================================
****************
* Generating JWT
****************

1. Expose a POST API with the mapping 
	-	/authenticate 
		*	accepts arguments for 
			-	username
			-	password
		*	resp is JSON web Token
			-	successful authentication
			-	returns in POST response JWT

2. Validating JWT: 
	-	GET
		*	
	-	POST
		* /hello
			- access granted with valid jwt
			- access denied with invalid jwt



3. Genererationg JWT

Client					Server
-----					------
1.POST username/passwd			2. Authentication Manager recieves
					   POST request with username/password
					   generate jwt using secret key
					3. User is authenticated
4.GET /hello with 			5. Validate JWT using secret key
  JWT in the HEADER			6. Return GET resp





	

