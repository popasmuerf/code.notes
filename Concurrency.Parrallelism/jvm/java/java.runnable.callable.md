Spring MVC 3.2 Preview:
Introducing Servlet 2, Async
Support



Overview
==============================
Spring MVC 3.2 introduces Servlet 3 based asynchronous request
processing.  This isthe first of several blog posts covering this
new capability and providing context in which to understand how
and why we would use them.



Real Quick Tho...
====================================
As a quick reminder, you can make any existing controller
method asynchronous by changing it to return a Callable.

For example a controller method that returns a view name, can return
Callable<String> instead.

An @ResponseBody that returns an object called Person can return
Callable<Person> instead....and this holds true for for
any othe controller return value type.

A central idea is that all of what you already know about how a controller
method works remains unchanged as much as possible except that the 
remaining processing will occur in anothe thread...

Question:  So does that mean the subsequent work down in the service module
I just called from my controller is also running in a seperate thread ?





The main puprpose of early releases is to seek feedback.



From a programming model perspective the new capabilities appear
deceptively simple.  A controller method can now return a

	java.util.concurrent.Callable


To complete processing asynchronously.  Spring MVC will then 
invoke the Callable in a seperate thread with the help of a 
TaskExecutor.




//Before
@RequestMapping(method=RequestMethod.POST)
public String processUpload(final MultipartFile file){

	//...
	return "someView" ;
}


//After
@RequestMapping(method=RequestMethod.POST)
public Callable<String> processUpload(final MultipartFile file){

	return new Callable<String>(){
		public Object call() throws Exception{
			return "someView" ;
		}
	}
}


What about returning a  DeferredResult ?
===================================
A controller method can also return a DeferredResult
to complete processin in a thread not known to SpringMVC
For example reacting to a JMS or an AMQP message, a Redis notification,
and so on.  Here is another code snippet 


	@RequestMapping("/qoutes")
	@ResponseBody
	public DefferedResult<String> qoutes(){
		DeferredResult<String> deferredResult = new DeferredResult<String>() ;

		//Add deferredResult to a Queue or a Map....
		return deferredResult ;
	}



The above samples lead to many questions....that we will eventually get to...


Motivation for Asynchronicity in Web Applications
=====================================================
The most basic motivation for asynchronicity in web applications is to 
handle requests that take longer to complete.  Maybe a slow database
query, a call to an external REST API, or some other I/O bound operation.


In some cases you can return to the client immediately while a background job
completes processing.  For example...sending an email, icking off a DB job, 
and others represent "fire-and-forget" scenarios that can handled with Spring's


	@Async

Support or by posting an event to a Spring Integration channel and then returning
confirmation id the client can use to query for the results.



In other cases, where the result is required, we need to decouple processing
from the Servlet container thread or else we will exhaustit's thread ppol.

In other words...under really heave request load...the amount of threads available to 
process each request response(there is one per request/response by default using spring web boot starter)...and the requests outpace the number of working threads all at some stage of waiting
on a response from some external resoruce....then we have effecively exaushted our thread pool 


Summary:  Shit we don't depend on respnoses/results from/of, are known as 
"fire and off and forget" ....
In cases where the response/result does matter....we need to couple 
processing from the Servlet container thread or else we will eventually 
exhaust its thread pool. 



To achieve this,  a Servlet 3 web appliation can call 
request.startAsync() and use the returned AsyncContext to 
continue to the response from some other seperate thred.


