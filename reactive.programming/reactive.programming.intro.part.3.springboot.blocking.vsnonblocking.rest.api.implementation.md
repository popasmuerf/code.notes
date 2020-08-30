https://dzone.com/articles/understanding-spring-reactiveintroducing-spring-we



Explaining blocking code in the Spring MVC context, using the
container-manger error page is blocking.  Let's take a
look at the code below....


    @Controller
    public class MyErrorController implements ErrorController{

        @RequestMapping(path="/error")
        public String greetig(){
            return "myerror" ;
        }
        @Override
        public STring getErrorPath(){
            return "/error" ;
        }
    }
    
    
    
Whenever an error occurs in a Spring application, the container would invoke
the /error page, and the 'myerror'
page would be rendered in a blocking way.

Off course, we have ways to handle such things, but they are
always error-prone.  To summarize, this is error-prone, because the 
application has access to the Servlet object, which has both
blocking and non-blocking operations as shown below...

//Flow of events....
 ________________         ________        ________        ___________
/Containter thread\ ----->|filter|------> |Servlet| ----->|Controller|
|------------------       --------        --------        -----------


                              {SpringMVC}
                          
                          {----Servlet API-----}
                           ↑  Non-Blocking I/O ↓
                          { TomCat, Jetty...etc }
                          
                          
So, even though we ahve ways in Spring 5 MVC to write completely non-blocking
code, the needwas felt to have a stack in which ther are no chances that
an underling, bocking API could be used.

This means that the Sevelt API is not direclty exposed to the application
This forces us to incorporate the Spring Reactive stack, otherwise known 
as Spring WebFlux:

*   Event Loop at the core
*   Event-Driven achitecture, message passing
*   Means to compose Async logic through the Reactive Steams API
*   Backpressure 





AS we can see in the diagram below , Spring WebFlux does 
not directly use the Servlet...it uses the Servlet...but not
directly...Instead, it uses the Spring Web API, which includes Reactor
Streams....


        {Spring Webflux}
        {Spring Web API(Reactor, Reactive Streams)}
        {Reactor Netty}    {Servlet 3.1 (Non-Blocking I/O)}
        ↑         Non-Blocking I/O            ↓
        {Netty}                        {Tomcat, Jetty}   


The purpose of this series is to demonstrate the evolution of
the Servlet/spring from the blocking to non-blocking
paradigm.  


The model above, describes  Sprig Webflux as being Servlet Container aganostics.
Spring Webflux works on Servlet Container and aslo on Netty through 
the Reactory Netty Project.

We can run a WebFlux application as a Spring MVC application. But, 
vice-versa is not true as the Spring MVCapplication coudl be using the

    HttpServletRequest/Response, which is not
    available in Spring WebFlux runtime.
    
    
        @GetMapping(value = "/reactiveService")

        public Mono<String> reactiveService(){

            logger.debug("reactiveService Request processing started");

            return webClient.get().uri("/sleep/1000")

                    .retrieve().bodyToMono(Boolean.class)

                    .doOnNext(response->{ logger.debug("reactive service");})

                    .then(Mono.just("reactiveService"));

        }




Java/Springboot Blocking vs Non-Blocking REST API Implementation
===================================================================
https://medium.com/@vimalma1093/java-springboot-blocking-vs-non-blocking-rest-api-implementation-fe5643840287




                          
                          
