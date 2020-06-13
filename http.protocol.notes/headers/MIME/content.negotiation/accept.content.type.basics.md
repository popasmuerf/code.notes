Examples of Content Negotiation
===============================================


REST stands for REpresentational State Transfer


The Key abstraction in REST is a Resource.  There is no restriction on what
can be a resource.  A todo is a resource.  A person on FaceBook is 
a resource.


A resource can have multiple representations:

1. XML
2. HTML
3  JSON 



When a resource is requested, we provide the representation of the 
resource.  When a consumer sends a request, it can specify tow
HTTP Headers related two HTTP Heders related to Content Negotiation

	*    Accept
		-    indicates what the requester is willing to accept...
		-    I wouldn't give this too much weight....Accept headers are 
		     somewhat unreliable at best...
		
	*    Content-Type
		-    "This is what I am sending to you as the requestee...this is
                      what you should expect in your response...."



Example:

GET Request :  https://api.chucknorris.io/jokes/random


	Headers:

		Request:
		Accept	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
		Accept-Encoding	gzip, deflate, br
		Accept-Language	en-US,en;q=0.5
		Cache-Control	max-age=0
		Connection	keep-alive
		Host	api.chucknorris.io
		Referer	https://api.chucknorris.io/
		TE	Trailers
		Upgrade-Insecure-Requests	1
		User-Agent	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:77.0) Gecko/20100101 		Firefox/77.0

	Response:
		X-Firefox-Spdy	h2
		cf-cache-status	DYNAMIC
		cf-ray	5a0e998d3ed2e0a2-IAD
		cf-request-id	033cfe4c460000e0a2fb1c9200000001
		content-encoding	br
		content-type	application/json;charset=UTF-8
		date	Tue, 09 Jun 2020 23:23:20 GMT
		expect-ct	max-age=604800, report-uri="https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct"
		server	cloudflare
		via	1.1 vegur






Body:

{"categories":[],"created_at":"2020-01-05 13:42:22.701402","icon_url":"https://assets.chucknorris.host/img/avatar/chuck-norris.png","id":"BaZeWufPQbKJFza7wj1Tow","updated_at":"2020-01-05 13:42:22.701402","url":"https://api.chucknorris.io/jokes/BaZeWufPQbKJFza7wj1Tow","value":"Chuck Norris made his first kill when he was 30 seconds old. The victim, the doctor that spanked his ass. He took his umbilical cord and choked him out."}







Example of Content Negotiation
=============================================

Client Request header --->   Accept         application/xml
	* I accept application/xml in the body of your response...
          If there is a response....
Client Request header ----> Content-Type   application/json
	* Depends....is this a GET/DELETE(?) or a POST/PUT ?  
              -If it is a
	       GET, then it really doesn't matter what it is; though
	       various sources stipulate that it should be set to 
          
              application/octet-stream

        * If it is a POST/PUT request...then the payload
          or the body's media type needs to be specified for 
          as you are POSTing/PUTing shit to the resource
          as part of our request...




The server is expecte to respond based on the Accept header.


For example, if a consumer sends a request to 

	http://localhost:8080/students/10001

with Accept header as 

	application/xml


the server then needs to provide the xml representation of the resource.

	<Student>
	    <id>10001</id>
	    <name>Ranga</name>
	    <passportNumber>E1234567</passportNumber>
	</Student>

If a consumer sends a rquest with Acept header as

	application/json 

we need to provide the JSOn representation of the resoruce...

	{
	    "id":10001,
            "name":"Ranga",
	    "passportNumber":"E1234567	
	}


Similar concept applies to the Response Body Content based on the Content-Type




Similarly this concept applies to the Response Body Content based on the 
Content-Type


A consumer can send a POST rquest to

    http://localhost:8080/students 

with Content-Type header as 

    'application/xml', 

and provide the XML representation of the 
the resource to be created.

	<Student>
	    <name>Ranga</name>
	    <passportNumber>E1234567</passportNumber>
	</Student>


	
A consumer can also send a POST rquest to 

	http://localhost:8080/students 

with Content-Type header as 

	application./json

and provide the JSON representation of the resource to be created

