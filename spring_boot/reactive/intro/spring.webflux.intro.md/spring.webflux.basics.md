# Basic Introduction to Spring WebFlux



### Spring WebFlux 
	- reactive
	- non-blocking
	- uses Project Reactor's reactive streams API that enables 
		* highly concurrent processing
		* highly concurrenty processing 
	of web requests in a non-blocking in an event-driven way

	- It uses Project reactor as the underlying reactive library for composiable asynchronous and event-based programming 

	- The core abstraction is around reactive streams -- publishers that provide push-based asynchronous streams of data

	- Controllers return Publisher or Mono Tyeps instead of a ModelAndView. Reponses are streamed back incrementally

	- It is optimized for non-blocking and event-driven applications on modern servers like Netty and Undertow.



	## Flow of Spring WebFlux

	- A client sends an HTTP rquest to the server which is handled by the Netty/Undertow server
	- The server dispatches the request to the Spring WebFlux dispatcher handler
	- The dispatcher handler routes the request to the appropiate controller based on teh request path.
	- The controler returns a Mono or Flux type which will emit a stream of resonses asynchronously
	- The dispatcher hander wraps the Momon/Flux in a ServerResponse and returns it.
	- The ServerResponse is streamed back to the client incrementally as the Mono/Flux emits
		* vlaues
	without blocking threads

	- Any exceptions are caught an dhandled gracefully instead of blocking threads.
	- The client recievesthe response ansynchronously without the server blocking on I/O



	## Core principles of Spring WebFlux

	- Asynchronous operations :
		All I/O operations like
			* database access
			* network calls
		are asycnchronous and non-blocking

		* Async operations prevent threads from blockign on I/O.
		* Reactive streams:
			- Data is procesed an consumed asynchronously s streams of mltiple values over
			time rather than a single blocking responses.
			- Reactove treams compliance 
				* WebFluxe is build on Project Reactor which implements Reactive Streams
			- Non-blocking requests: The underlying server (Netty by default) is fully asynchrnous
			and non-blocking.  It anc handle many more requests concurrently without blocking threads



	## Key Features of Spring WebFlux 

	- Non-blocking I/O: Uses asynchronous and non-blocking I/O to avoid blocking threads, enable high concurency
	- Reactive streams support : Fully implements Reactive Streams specification using Project Reactor for reactive programming.
	- Functional programming model: Controllers return Mono/Flux publishers instead of blockign responses, favoring functional style
	- Server-sent events: Supports server-sent events out of the box for real-time full-duplex communictiona
	- WebSockets: Built in support for WebSockets to enable real-time bidirectional communiction 
	- Reactive database access: Seamless integration with reactive databases like 
		*	MongoDB
		*	Cassandra
		*	Redis

	- Caching support:
		- Supports caching responses using Cach API in non-blocking manner 


	## Advantages of WebFlux
	- Scalability:
		* Handles more requests concurrently using less resources due to non-blocking I/O.  this improves scalabiilty
	- Responsiveness
		* Applications remain highly reponsive even under heavy load since requiests are not blocked waiting for I/O.
	- Resource efficiency: Fewer threads asre required to handle the same number of requests 
	- Resiliency
		* Failure of one request impacts only some 
		* Backpressure prevents overloading



	## Disadvantages of WebFlux
	- Debugging asynch code is a nightbare
	- Complexity:
		Reactive logic involving
			* streams
			* callbacks 
		is more complex than simple blocking logic

	- Latency sensitivity
		* Reactive applications require consistently low latency to perform well 
		compared to blocking
		* Not ideal in low bandwidth enviroments

		* Migrating an app that runs off blocking logic to reactive, async logic can be difficult and time consuming


	## Use Cases of WebFlux 
		* Financial trading systems
		* Real-time collaboration tools
		* Video/audio stream Platforms
		* Live tracking systems 



# Difference between Spring WebFlux and Spring MVC


				POINT							Spring Web-Flux								Spring MVC
				============================================================================================================

				Architecture					Rx Programming 								Sync/Blocking
												Model (Reactive Streams)					Model

				-----------------------------------------------------------------------------------------------------------

				Request Handling				Asynch and  non-blocking					Sync request response
																							model
				-----------------------------------------------------------------------------------------------------------

				Supported Server 				Netty, Undertow, etc 						Servlet containers like Tomcat

				----------------------------------------------------------------------------------------------------------

				Performance						Better for IO-bound apps 					Degreades with concurrency 
												do to non-blocking 							due to blocking (?)

				----------------------------------------------------------------------------------------------------------


				Use Cases 						Best for data-heavy real time               Works well for request
												applications (heavy CPU                     response applications
												processing is not real-time)
				-----------------------------------------------------------------------------------------------------------







































































