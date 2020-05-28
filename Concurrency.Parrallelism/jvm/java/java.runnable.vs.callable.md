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





Runnable vs. Callable in Java
======================================================================
Since the early days of Java, multithreading has been a major aspect of the language...

	Runnable 
is the core interface provided for representing multi-threaded tasks and 

	Callable

is an improved version of Runnable that was added in Java 1.5 

In this article, we will explorte the differences and the applications of both
interfaces.



2. Execution Mechanism
=======================================================
Both interfaces are designed to represent a task that can be executed
by multiple threads.  Runnable tasks can be run using the classes

	Thread
	-or-
	ExecutorService

whereas Callables can be run only via the class

	ExecutorService



3. Return Values
===============================================================
Let's have a deeper look at the way these interfaces handle
return values...


3.1 With Runnable
--------------------------------------------------------------
The Runnable interace is a functional interface and has a single 
run() method which doesn't accept any parameters and does not return any values...

This is suitable for situations where we are not looking for a result of the 
thread execution....this works out great for things
like sending off emails....running asynch write operations of any kind...
etch...

	//code
	public interface Runnable{
		public void run() ;
	}

	public class EventLoggerTask implements Runnable{
		private Logger logger ;
		logger = LoggerFactory.getLogger(EventLogger.task.class) ;

		@Override
		public void run(){
			logger.info("Message") ;
		}
	}


	public void executeTask(){
		executorService = Executors.newSingleThreadExecutor() ;
		Future future = executorService.submit(new EventLoggingTask()) ;
		executorService.shutdown() ;
	}


In the above code, the thread will just read a message from teh queue and log it in 
a log file.  There's no value returend from the taks; the task can be launched using
The ExecutorService Class....



3.2 With Callable
--------------------------------------------------------------
The Callable interface is a generica interface containing a single call() method
which returns a generic value "V"


	//code

	public interface Callable<V>{
		V call() throws Exception ;
	}

	public class FactorialTask implements Callable<Integer>{
		int number ;

		public FactoralTask(int number){
			this.number = number ;
		}

		public Integer call() throws InvalidParameterException{
			int fact = 1 ;
			for(int count = numbe ; count > 1 ; count --){
				fact = fact * count ;
			}
			return fact ;
		}	
	}


	@Test
	public factorialTaskTest(){
		FactorialTask task = new FactorialTask(5) ;
		Future<Integer> future =  executorService.submit(task) ;
		assertEquals(120, future.get().intValue()) ;
	}

The result of call() method is returned within a Future object




4. Exception Handling
===================================================================

4.1 With Runnable
-------------------------------------------------------------------
Sinc the method signature does not have the "throws" clause specified, there is 
no way to propagate further checked exceptions.



4.2 With Callable
--------------------------------------------------------------------------
Callable's call() method contains "throws Exception" clause so we can easily
propagate checked exceptions further:


	public class FactorialTask  implements Callable<Integer>{
		//...

		public Integer call() throws InvalidParameterException{
			if(number < 0){
				throw new InvalidParameterException("Number should be positive) ;
			}
		}

	}



In case of running a Callable using an ExecutorService, the execptions are collected
in the Future object, which can be checked by making a call to the Future.get() method.
this will throw an ExecutionException -- which wraps the original exception:


	@Test(expected = ExecutionException.class)
	public void whenException_ThenCallableThrowsIt(){
		FactorialCallableTask = new FActorialCAllableTask(-5) ;
		Future<Integer> future = executorService.submit(task) ;
		assertEquals(false,furture.isDone()) ;

The above test will pass despite the fact we have thrown an excepion for the negative
values of the parameter to FactorialCallableTask



}


	
