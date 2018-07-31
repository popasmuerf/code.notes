


https://dzone.com/articles/buiding-microservice-using-springboot-and-docker




1. Config Servers
	*	Manages all microservices properties files
		and those files are versioned controlled.

	*	All changes to configs will be autmatically
		publicshed to all microservices without
		restartign any of the services.

	*	All microservices communicates with the config server
		to get
			-	property values

	*	must be highly availabled


2. Eureka Discovery server
	*	Main coal of Microservices is decentralizing
		different components based on the business features,
		so that each component -aka- microservices,
		there are multiple instances and we can add and 
		remove intances as per the need.

	*	Containers are spawned on the fly and as such
		will have dynamic ip addresses

	*	To keep track of and register instances of a service,
		a management service dedicated to this is required.

	*	If a service is removed...then the manager removes
		it from the manager's servie regisry.  If other services need 
		to communicate with each other, it contacts a discovery
		service to get the instance of another service.

	*	This component moust be high scalable



3.	Components, aka services: 

	*	Utility or business service that 
		can be updated independently.

	*	Pre-defined boundary

	*	Utility/service exposed as an API

	*	

4. Gateway Service:

	*	Services as gateway of all services

	*	Reduces the number of endpoints required for
		the user/user-service to remember

	*	Every service publishes an API,
		generally a REST API, so as a client, 
		it is cumbersome to manage so many
		endpoint URLs to communicate with.

	*	Is usually internet/intranet facing




Services 
==================================
1. Config Server
2. Eureka server
3. Employee service
4. Employee Dashboard service
5. Zuul Proxy


/Users/mdb/src10/jvm/lab/code_lab/jcode_lab/src/main/kotlin

Config Server
===============================================


dependencies
--------------------------------
spring-boot-starter-actuator
spring-cloud-config-server
spring-boot-starter-test
spring-cloud-depenendencies


bootstrap.properties
--------------------------------
server.port=9090
spring.cloud.config.server.native.searchLocations=file://${user.home}/MicroService/centralProperties/
SPRING_PROFILES_ACTIVE=native

Note:
	*	instruct embedded server to listen to 9090
	*	instruct spring to search this location on host
		for files
	*	Docker container,must create a central properties folder and place
		all files in the specified path



