

com.fasterxml.jackson.databind.JsonNode
==============================================
	*	Is Jackson's tree model (object graph model)
	        for json

	*	Jackson an read JSON into a JsonNode instance,
		and write a JsonNode out to json

	*	We can actually build JsonNode object graphs 
		from scratch....so we can then serialize them to JSON later

	*	


JsonNode vs. ObjectNode
===============================================
	*	JsonNode class is immutable.
		This means that we cannot actually 
		build an object grah of JsonNode instances
		directly.

	*	We can creat an object graph of JsonNode 
		subclasses of type ObjectNode.

	*	Being a subclass of JsonNode you can use the 
		ObjectNode everywhere you can use JsonNode.





Write  JsonNode From JSON 
=============================================
To read JSON into a JsonNode with Jackson, you 
start by creating a Jackson ObjectMapper
intance.  On the ObjectMapper instance you call 
readTree() passing the JSON source as a parameter

//code
String json = "{ \"f1\" : \"v1\" } ";
JsonNode jsonNode = objectMapper.readTree(json) ;
System.out.println(jsonNode.get("f1").asText()) ;



Write JsonNode to JSON
==================================================
//code

ObjectMapper objectMapper = new ObjectMapper() ;
JsonNode jsonNode = readJsonIntoJsonNode() ; //readJsonIntoJsonNode() is a custom method
String json = objectMapper.writeValueAsString(jsonNode) ;


Get JsonNode Field
=================================================
A JsonNode can have fields just like a JSON object has.  Imagine
you have parsed the following JSON into a JsonNode:

	//json
	{
	    "f1":"v1",
	    "f2":"v2",	
	}


This json object has two fields name d field1 and field2.  If yuo had a Jacson
JsonNode represtenting the above JSON object, you could obtain the two fields like
this....
	//code
	String json =  String json = "{ \"f1\" : \"v1\" , \"f2\" : \"v2\" } ";
	JsonNode jsonNode = objectMapper.readTree(json) ; 
	jsonNode.get("f1") ;
	jsonNode.get("f2") ;


Notice, that even if the two fields are String fields, the get() method always 
returns a JsonNode to represent the field.


Get JsonNode Field At Path
==========================================
The Jackson JsonNode has a special method called 

	at()


The at() method cn access a JSON field from anywhere in the JSON graph whih the
given JsonNode is the root of.  Imagine that the JSON structure looks like this:


	{
	  "identification" :  {
		"name" : "James",
		"ssn: "ABC123552"
	    }
	}


If this JSOn was parsed into a JsonNode you could access the name
field using the at() method, like this:


JsonNode nameNode = jsonNode.at("/identified/name/")






What my plan might be.....
========================================
RestTemplate restTemplate = new RestTemplate() ;
String url = "https://foobar.io" ;
ResponseEntity<String> response = restTemplate.getForEntity(url,String.class) ;
assertThat(response.getStatusCode(), equalTo(HttpStatus.OK) ;

ObjectMapper mapper = new ObjectMapper() ;
JsonNode root = mapper.readTree(response.getBody()) ;
JsonNode galaxy = root.path("name") ;
assertThat(name.asText(),notNullValue()) ;

























