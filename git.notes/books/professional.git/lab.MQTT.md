# MQTT

	-> MQTT is a protocol specifically designed for passing messages of key/value pairs (is it the standard?  does Kafka, and RabbitMQ use MQTT ? )
	-> It's strength is in it's a broadcast capalitiy 
	-> Each client is responsbile for askin gfor modifications to values based on specific keys it cares about 
	-> Each client can be assured tht their updates are recieved by any and all other interested clients.
	-> MQTT also has the capbaility to retain specific key/value pairs so whenever a new client subscribes, it can be notified of 
	the current key/value pair(themost recently sent one).
	-> The con of this all is that the response to any client response is not guaranteed to be recieved immediately by the client(lolz...is a fucking message like anything else
	waiting in the queue)


# HTTP

	-> requires custom programming to provide the message-passing services that MQT provides.
	-> You could implement a message bus sort of system that mimics MATT's functionality but that is more work than it's worth
	-> HTTP's strength is that it is a request/response right away.
	-> Like MQTT the client would need to request(via polling) if there has been anything changed in the key/value pair
	-> This constant polling is CPU intensive....and costly.
	-> HTTP is a decent choice if you need more than what MQTT provides.  Cetainly, HTTP supports PHP or Node.js

	It's possible to to combine both HTTP and MQTT. Use HTTP for request/response-type transactions and MQTT for state updates.




	 										------------
			--------------------------------|MQTT Broker|------------------------------
			| 								------------                               |     
			|																		   |	
			V                                                                          V
		 ---|-----                                                                  |subscriber|
		|publisher|
		 ---------	

		                                                                      MongoDB           Redis