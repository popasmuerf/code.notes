Unit or Integration Test ?
url:https://dzone.com/articles/integration-testing-in-spring-boot-1
url: https://reflectoring.io/spring-boot-web-controller-test/

======================================================
Do we write unit tests ?  Or integration tests ?
What is the difference anyways?

Let us disucss both approaches and decide for one.



In a unit test,  we would test the controller in solation.
That means we would instantiate a controller object, mocking
away the business logic, and then call the controller's 
methods and verify the response.



Is Unit testing what we want for controllers ?
========================================================
Responsibility					Covered in a Unit Test ?
--------------					------------------------------------
1. Listen to HTTP				X: No, because the unit test wold not evaluate the
   Requests					@Post/Get/etc Mapping annotation and similar 
						annotations specifying the properties of a HTTP request




2. Deserialize Input				X: No, because annotations like @RequestParam and
						@PathVariable would not be evaluated. Instead we would
						provide the input as Java objects, effectiely skipping		
						deserailziation from an HTTP request




3. Validate Input				X: No, Not when depending on bean validation, because the
						@Valid annotation wold not be evaluated.




4. Call the Business Logic 			O: Yes because we can verify if the mocked business logic
                                                has been called with the expected arguments



5.Serialize Output				X: No.  We can only vefity the Java version of the output
                                                   , not the HTTP respnose that would be generated



6.Translate Exeptions				X: No.  We could check f a cer4tain exception was raised,
					        but not that it was translated to a certain JSON response
                                                or HTTP status code.


In summary, Unit tests only cover the logic  within the scope of the unit being tested.
Unit testing "ensures" that the immediate logic within scope does what it is supposed to do...
hence the reason we "mock" data or services whom's logic exist outside of the scope.




What about Integration testing ?  will it do the job adequately?
================================================================================
An integration test with Spring fires up Spring application contexts that
contains all th ebeans we need.  In other words...the test "INTEGRATES" all the 
moving parts...not just the logic within the context of the scope of the unit being
tested.

1. Includes framework beans that are responsible for listening certain URLs,
2. Includes serializing and deserializing to and from JSON
3. Includes translating exceptions to HTTP
4. Most shit that is ignored by simple unit test.




When we talk about integration testing for a spring boot
applicatio, it is all about running an application in 

	ApplicationContext

and run tests.  Spring Framework does have dedicated test module for
integration testing.  It is 
known as ***sprint-test** and other dependent libraries.


In this article, we are going to see how integreation tests
can be run for a Spring Boot application.




@SpringBootTest
========================================================
Spring-Boot provides an **@SpringBootTest** over and above of the
**spring-test** module.  This annotation works by creating the 
**ApplicationContext** used in our tests through
**SpringApplication** 

What **@SpringBootTest**  does
1. Starts the embedded server
2. Creates a web enviroment
3. Enables @Test methods to perform integration testing



@webEnviroment
==============================================================
By default tho..in reality **@SpringBootTest** does not in fact
start a server.  We need to add the attribute **@webEnviroment**
to further refine how your tests run   It has several options....

1. MOCK : Loads a web **ApplicationContext** and provides
   a mock web enviroment

2. RANDOM_PORT: Loads a **WebServerApplicationContext** and provides a real web enviroment.
   The embeded server is started and listen on a random port.  This is the one should
   be used for the integration test

3. DEFINED_PORT: Loads a **WebServerApplicationContext** and provides a real web
   enviroment

4. NONE: Loads  an **ApplicationContext** by using **SpringApplication** but does not
   provide any web enviroment




In the Spring Test Framework, we used to 
have **@ContextConfiguration** annotation in order 
to specify which spring **@Configuration** to load.
However , it is not requir4ed in spring-boot as it automatically searches
for the primary configuration when not defined.

If we want to customized the primary configuration, 
we can use a nested **@TestConfiguration** class in addition to the 
application's primary configuration.




TestRestTemplate
==========================================================================
As explained above, for integrating testing of a spring-boot appliation, we
need to use @SpringBootTest.  spring-boot also does provide other classes like
**TestRestTemplate** to test the REST APIs.  Like
**RestTemplate** class, it also does have methods 
**getForObject**, **postForObject()** , **exchange()**, etc..

Let's implement **@Test** methods to test create and retrieve both



In the above code, we have used WebEnvironment.RANDOM_PORT to spin up the application on random port temporarily. @LocalServerPort helps to read the current port and build the URI to hit by template class. We have used exchange() method as we want to get ResponseEntity as return type. 





@MockBean
======================================================================
With TestRestTemplate, we have tested all the layers from 
Controller to DB layer end to end.  HOwever, sometimes
DB setuup or third party services won't be rady and you still want to
test all the appliation layers in your scope.

That would require mocking all the external systems and services.

**@MockBean**  helps to enable the mocking of a
certain layer.  In this example, we will be mocking
the **StudentRepository**






