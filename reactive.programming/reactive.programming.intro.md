Reactive Programming
=============================================
reactive programming is a programming paradighm that
promotes these engineering concepts with associated with
data processing architecture:

	*Ansynchronous
	*Non-Blocking
	*Event-Driven



Reactive programing involves modeling data and events
as observable data streams and implementing data
processing routines to react to the 
changes in those streams


Typical workflow reactive style programming:

	*Client makes a req for the resource
	*Client goes on to peform other computations
	*When the resource is available:
		-Client recieves notification
		-Client recieves resource data
		 in the form of a call back function.
		-Client used the callback to handle
		 the response as per applicaiton/user needs


Reative Programming
=======================================================
Reactive programming is about building asynchronous, non-blocking,
and event-driven applications that can easily scale.


Each event is publishe to subscribers while ensuring that the subscribe3rs
are never overwhelmed.


**Mono** and **Flux** are implementations of the **Publisher** interface.
A  **Flux** will observe 0 to N items and eventually terminate successfully or not.

A **Mono**  will observe 0 to 1 items, with **Mono<Void>** hinting at most 0 items.



Spring WebFlux:
=================================================
Spring Webflux is a reactive-stack web framwork that is 
fully non-blocking, supports Reactive Streams back
pressure,and runs on such servers as Netty, Undertow,
andServlet 3.1+ continaers.  It was added in Spring 5.0


Spring Webflux uses Project Reactor as a reactive library.
The reactor is a Reactive Streams library and, therefore,
all of its operators support non-blocking back pressure.

Both Mono and Flux are implementations of the Publisher interface







What's a Mono ?
===============================
A **Mono** is a specialized **Publisher** that emits at most
one item and then optionally terminates with an **onComplete**
signal or an **onError** signal.  In short, it returns an element
of value either 0 or 1

	Mono noData = Mono.empty();
	Mono data = Mono.just("rishi") ;


What's Flux ?
================================
A **Flux** is a standard **Publisher** reprsenting an
**asynchronous** sequence of 0..N emitted items, optionally
terminated by either a completion signal or an error.
These three types of signal translate to calls to a 
downstream subscriber's 
	* onNext
	* onComplete
	* onError


	Flux flux1 = Flux.just("foo", "bar", "foobar") ;
	Flux flux2 = Flux.fromIterable(Arrays.asList("A","B","C")); 
	Flux flux3 = Flux.range(5,3) ;
	flux.subscribe() ;


To subscribe , we need to call the **subscribe** method on 
**Flux**. There are different variants of the subscribe method
available, which we need to use as per the need :

	Flux flux1 = Flux.just("foo", "bar", "foobar") ;
	Flux flux2 = Flux.fromIterable(Arrays.asList(“A”, “B”, “C”));
	Flux flux3 = Flux.range(5, 3);
	// subscribe
	flux.subscribe();



Another take on Flux
====================================
A **Flux<T>** is a Reactive Streams
**Publisher**, augmented with a lot of operators
that can be used to generate, transform,
orchestre Flux sequences.


It can emit 0 to n <T> elements (onNext event)
then either completes or errors) (onComplete and
on Error terminal events).  If no terminal event is 
triggered, the Flux is infinite.


This is why you are a fucking moron:
https://www.snopes.com/fact-check/do-police-kill-more-whites-than-black-people/

This is why you are a fucking moron:
https://www.rlslawyers.com/experts-spar-over-data-suggesting-blacks-commit-more-crimes/



