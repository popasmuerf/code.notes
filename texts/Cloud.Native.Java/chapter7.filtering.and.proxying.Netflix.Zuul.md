######url: https://docs.cloudfoundry.org/services/route-services.html
######url: https://spring.io/guides/gs/routing-and-filtering/
##Chapter 8. Edge Services
==================================================
Microservices don't exist in a vacuum.  They ultimately serve clients.
these clients are myriad:

    -HTML5 clients
    -Android clients
    -iOS clients
    -Game consoles
    -Smart TVs 
    -anything with a MAC address and IP address
    


Clients have many different dimensions of capabilities that inform
the types of payloads and services they can work with , or talk to:

-Some have limited memory capacity or processing power which affects how much content a client
can manage

-Some require specific content types or encodings

-Some require different document models optimiazed for different clients(flat or hiearachical)

-Some client's don't have much screen realstate and thus requires data to be loaded
incrementally

-Data delivery may be more efficient in chunks or streamed.

-User interactions may chane the responses required.

-Meta-data fields, delivery methods, and interaction models will be influenced


##The Cost of Retrofitting every Microservice
==================================================
The cost of retrofitting every microservice in a system with a nontrivial number of
microservices to accommodate each new client is prohibitive and 
would introduce a complexity into the system that would quickly become overwhelming.

The whole point of "The Cloud" is the agility and control of destinity that comes
with it....

Don't rebuild your microservice...instead, handle these concerns in intermediary services...
also known as **edge services**.

Edge services are a sort of a doorway for requests coming into the application.
Edge services are responsible for handling client-specifc concerns as well as cross-service concerns
like security(authentication and authorization), rate limiting, and metering, routing(ro more on this,
see the discussion on routing, filtering, API translation, client-adapter APIs, service
proxying, and more)

          +----------------------------->--------------+
          |              |               |Streaming    +------------------------> +--------------+
          |              <---------------+Edge.SerVice |                          |  Mobile      |
          |    M.Service1|               +-------------+ <---------------------------------------+
          |              |
          |              |                                                        +--------------+
          +--------------+               +-------------+                          |   IoT device |
                         +-------------->+Sync         +------------------------> +--------------+
          +--------------+               |Edge.SerVice |                           |
          |              <------------------------------<--------------------------+
          |              |                                                        +--------------+
          |    M.Service2|               +--------------------------------------->+  Message Bus |
          |              +--------------->ASync        |                          |              |
          |              <---------------+Edge.SerVice +<----------------------------------------+
          |              |               +-------------+
          +--------------+



GraphQL, Kafka(or any other msg bus), et al could be thought of as
Edge services.   For Example...using GraphQL or Kafka...My clients don't 
have to know the peculiarities of each and every API for any particular service.....
All my clients have to know is how to interface with either GraphQL or Kafka.

                                                                     ^
                                                                     +

We want to simplify the work of calling 
downstream services.   One option might be 
to write an API client and then reuse that.

It can be shared with other teams who can use it to
reduce their "ramp-up" time. 

This is a sound strategy if you  don't mind writing
the client in the first place, and if you have a
strategy to keep it consistent with the service API

....we could simply build a frame-work of sorts for 
either general or specific client scaffolding. via 
Parent BOMs and interfaces enforced via polymorphism....

but there is always the risk that the client ends up  "too smart"...in that business logic baked into the client that should be in the service implementation itself....so we could build our own client..but this might be what one would call an "uphill fight"....and one that could risks intoroductin more bugs and inconsistencies.  Here, we might e tempted to use RPC technologies, and 
forego the benefits of using REST.  We would discourage that, unless you have a particular use case that simply can't be met with REST.....Instead, 
consider using something like "Netflix Feign"....



Netflix Feigh is a library from Netflix that makes deriving service clients as simple as an interface definition and some conventions.  It's well integreated with Spring Cloud.  We can activate it by adding 

**@EnableFeigclients**

to a configration class or classe annotated with 
@SpringBootApplication

and adding 

**org.springframework.cloud:spring-cloud-starter-feign** to the classpath.



        import org.springframework.cloud.openfeign.FeignClient;
        import java.util.Map ;
        import org.springframework.web.bind.annotation.PathVariable;
        import org.springframework.web.bind.annotation.RequestMapping ;
        import org.springframework.web.bind.annotation.RequestMethod ;

        //(1)
        @FeignClient("greetings-service")
        public interface GreetingClient {
            //(2)
            @RequestMapping(method = RequestMethod.GET, value="/greet/{name}")
            //(3)
            Map<String,String> greet(@PathVariable("name") String name);
            
        }


    (1)
    The service ID is used in tandem with the **DiscoveryClient**
    abstraction and Netflix Ribbon to do client-side load balancing.

    (2)
    We sepcify what endpoints should be called and how they should be
    called using Spring MVC request mapping annotations.  You are no
    doubt used to seeing this on teh service implementation, not the client!!!
    (3)
    The return value is used to determine how to marshal the results.
    We don't need to use the super type token pattern anymore !





import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Profile;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.thirdplanet.greeting_api_gateway.config.GreetingClient;
//(1.)
@Profile("feign")
@RestController
@RequestMapping("/api")
public class FeignGreetingsClientApiGateway {

    private final GreetingClient greetingClient ;

    @Autowired
    FeignGreetingsClientApiGateway(GreetingClient greetingsClient){
        this.greetingClient = greetingsClient ;
    }
//(2.)
    @GetMapping("feign/{name}")
    Map<String,String> feign(@PathVariable String name){
        return this.greetingClient.greet(name);
    }

    
}

1. The edge service is running under the feign Spring profile.
2. The call to the service becomes a method call, but one
    that instead still relies on REST.  Our client is as simple and 
    approachable as they come!(Maybe ?)
    Anyone who knows ho to use Feign will figure out what's going on quickly with this technology...(Basically we abstract away the "low" level shit like writing RestTemplate code....we just call the method that is described in the interface )

API adapters can get failyr complex and fairlly specific; these adapters are a natural place to put any client-specific handling
that can't e described generically and applied to all requests.

Eventually the problems of apdating APIs to clients start to look eerily like integration problems. For more on this, see our discussion of integration concerns later in Chapter 10.




#Filtering and Proxying with Netflix Zuul
-------------------------------------------
Thus far we have focuse on client-specific integration with specific endp;oints on
downstream REST services.  A lot of concerns are more generic and apply to all requests
from clients from a given host to a service or group of services downstream.  We can use
a micro-proxy, **Netflix Zuul*, to make short work of standing up filters that address 
concenrs like rate rate lmiting, proxying, and more.



**NOTE**
At the time of this writing(2016-2017) there is a Spring Cloud incubator project called 
**Spring Cloud Gateway** that aims to provide a more seamless alternative to Zuul based on
the Spring Framework 5 reactive runtime.

Apparently now in 2021, **Spring Cloud Gateway** Spring Cloud is being used in production and 
Zuul is now in maintenance mode and is no longer being actively worked on in any way worth mentioning
past this.


#So here's the thing about Zuul....
---------------------------------------------------------
Gave a talk at SpringOne Platform 206 that introduces
some of Zuul's applcations:

-   Used to serve most of the frontends for Netflix.com
    along with 1,000 device types.
-   Is the adapter layer that handles hundreds of permutations of
    protocols and device versions.
-   In Netflix's enviroment-particular deployment, it is fronted by more than
    50 AWS Elastic Load Balancers and handles tens ofbillions of
    requests per day across 3 AWS regions.

Zuul in short...is(or was) a primary workhouse component for Netflix.

##Zuul filters are deeply rooted in production
--------------------------------------------------------------
Zuul filters offer the following
    -   dynamic routing logic
    -   load balancing
    -   service protection
    -   debug analysis.
    
Zuul gateways can double as a quality assurance tool.  Zuul filters
can be used to create a top-level context for requests into
a system, handling concerns like:
    -geolocation,
    -cookie propagation
    -token decryption
    
**Zuul however IS NOT an appropiate context in which to execute business logic**

**Zull filters are not the same as a tradtional servlet Filter!!!!**
It is assumed that you are filtering the results of proxied requests and not, particularly,
the requests to th edge service itself.


Zuul filters are an ideal place to address routing from the client to 
downstream services.  If your services are registered in a service registry for
which there is a Spring Cloud Discovery Client implementation configured,
then it is a simple matter of adding an **@EnableZuulProxy** to yoru application code.
...then Spring Cloud, working with the DiscoveryClient, will set up routes that proxy downstream
services for you.

You can interrogate routes using the **RouteLocator**, as we do in 





##A simple example....


        //Code for the Zuul proxy/router..

        import org.springframework.boot.SpringApplication;
        import org.springframework.boot.autoconfigure.SpringBootApplication;

        @EnableZuulProxy
        @SpringBootApplication
        public class EdgeApiGatewayProxyApplication {
	        public static void main(String[] args) {
		        SpringApplication.run(EdgeApiGatewayProxyApplication.class, args);
	        }
	        @Bean 
	        public SimpleFilter simpleFilter(){
		        return new SimpleFilter() ;
	        }
        }
        
        
        
####What's going on here ?

To forward requests from the Gateway application, we nee to tell Zull th e
routes that it shoudl wtch and the services to wich to forward reques that 
are made to those routes.  We speicy routes by setting properties under 
**zuul.routes** .  Each of our microservices can have an entry under

**zuul.routers.NAME** where **NAME** is the application name (as stored in the
**spring.application.name** property).

This of course is down in "src/main/resources/application.properties" file.


        zuul.routes.books.url=http://localhost:8090

        ribbon.eureka.enabled=false

        server.port=8080
        
Spring Cloud Zuul automatically sets the path to the application name.  In this sample
, set to **zuul.routres.books.url** so that Zuul will proxy requests to  **/books**
to this URL.




Notice the second property.... **ribbon.eureka.enabled=false** in our properties file..
Spring Cloud Netflix Zuul uses Netflix's Ribbon to perform client-side load balancing.
By default, Ribbon would use Netlfix Eureka for service discovery.  For this simple exapmple,
yo ucan skip service discovery, so set **ribbon.eureka.enabled** to **false**.  Since Ribbon
now cannot use Eureka to lookup services we must specify a url for the book service....




##Adding Filters....
----------------------------------------------------------
Now you can see how to filter requests through your proxy service.
Zuul has four standard filter types:

-pre
    -Filters run before the request is routed

-route
    -Filters can handle the actual routing of the request

-post
    -Filters run if an an error occurs in the course of handling the request.
    
    
    
    

-error

