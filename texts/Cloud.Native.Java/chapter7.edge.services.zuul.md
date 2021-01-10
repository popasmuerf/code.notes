######url: https://docs.cloudfoundry.org/services/route-services.html

##Zuul
==================================================
Zull is the front door for all requests from devices and 
websites to the backend of the Netflix streaming application.

As an edge service application, Zuul is built to enable:
    -dynamic routing
    -monitoring
    -resilency
    -security
    
 
+--------------+         +-----------------+       +-----------------+
|   ELB        |         |     ELB         |       |    ELB          |
|              |         |                 |       |                 |
+-----+--+-----+         +---+------+------+       +---+-----+-------+
      |  ^                   |      ^                  |     ^
      |  |                   |      |                  |     |
      |  |                   v      |                  v     |
+-----v--+-------------------+------+------------------+-----+-------+
|                           Zuul                                     |
+---+-----+----------------+---+-----------------------+----+--------+
    |     ^                |   ^                       |    ^
    v     |                |   |                       v    |
+---+-----+----+       +---v---+---------+      +------+----+-------+
|              |       |                 |      |                   |
| Website      |       |    Edge         |      |    Playback       |
| Services     |       |    Services     |      |    Service        |
|              |       |                 |      |                   |
+--+----+------+       +---+-------+-----+      +----+-------+------+
   |    ^                  |       ^                 |       ^
   |    |                  |       |                 |       |
   v    |                  v       |                 v       |
+--+----+------------------+-------+-----------------+-------+-------+
|                                                                    |
|                                                                    |
|                          Netflix Services                          |
|                                                                    |
|                                                                    |
+--------------------------------------------------------------------+


##About Routing.....
---------------------------------------------------------------------------------
Routing is an intergral part of a microservice architecture.
For example, **/api/users** is mapped to the user service 
and **/api/shop** is mapped to the shop service.  Zuul is a 
JVM based router and server side load balancer by Netflix.

The volume and diversity of Netflix API traffic sometimes
results in production issues arising quickly and without warning.

We need a system that allows us to rapidly change 
behavior in order to react to these situations.

Zuul uses a range of different types of filters that enables us 
to quickly and nimbly apply functionality to our edge service.
These filters help us perform the following functions:


1   Authentication and Security:
    -   Identifying authentication requirements for each resource
2   Insights and Monitoring:
    -   Tracking meaningful data and statistics
3   Dynamic Routing: 
    -   Dynamically routing requests to different backends
4   Stress Testing:
    -   Gradully increasing the traffic
5   Load Shedding:
    -   Allocating capacity for each type of request and dropping 
        requests.
6   Static Response handling:
    -   Building some responses direclty
7   Multiregion Resiliency:
    -   routing requests across AWS regions....
    
    
    
##Zuul is composes of a few components...
1   zuul-core:
    -   Library that contains the core functionality of 
        compiling and executing Filters
2   zuul-simple-webapp:
    -  Webapp that shows a simple example of how to build
       an application with zuul-core
3   zuul-netflix: 
    -   Library that adds orther NetflixOSS components
        to Zuul -- using Ribbon for routing 
        requests, for example
4   zuul-netflix-webapp:
    -   Webapp which packages zuul-core and zuul-netflix togther
        into an easy to use package


##Zuul gives us a lot of insight, flexibility, and resiliency in 
part by making use of other Netflix OSS components...

1   Hystrix:
    -   Is used to wrap calls to our origins, which 
        allows us to shed and prioritize traffic when issures
        occur
2   Ribbon:
    -  Is our client for all outbound requests from Zuul,
       which provides detailed information into netowrk
       performance and errors, as well as handles software
       load balancing for even load distribution.
3   Turbine: 
    -   Aggregates finegrained metrics in realtime so
        that we can quickly observe and react to problems
4   Archaius:
    -   handles configuration and gies the ability to
        dynamically change properties


We can create a filter to route a specific cutomer or device to 
a separate API cluster for debugging.  Prior to using Zuul, 
people where doing silly shit like using Hadoop or Spark to process 
billions of logged requests to find the several thousand requests they were interested
in...

Spring Cloud has created an embedded Zuul proxy to ease the development of a very common use case where a UI application wants to proxy calls to one or more back end services. This feature is useful for a user interface to proxy to the backend services it requires, avoiding the need to manage CORS and authentication concerns independently for all the backends.


##Enabling the embedded Zuul proxy provided by Spring Cloud

To enable Zuul in our Spring apps, we annotate a Spring Boot class
with **@EnableZuulProxy**. amd tjos fpwards ;pca; ca;;s tp tje
appropiate service.  By convention, a sercie with the ID 
"users", will recieve requests from the proxy located at **/users**


The proxy uses Ribbon to locate an instance to forward to 
to foward to via discovery, and all requests are executed in a hysrix
command, so failures will show up in Hystrix metrics, and
once the circuit.

  

##Zuul Rquest Lifecycle
----------------------------------------------------------
                                   +-----------------------------+
                                   |                             |
       +---------------------------+       HTTP Request          +<------------------------------+
       |                           |                             |                               |
       |                           +-----------------------------+                               |
       |                                                                                         |
       |                                                                                         |
       |                                                                                         |
       v                                                                                         |
+------+------------+                 +-------------------------+        +-----------------------+
|"pre" filters      +---------------> |   "routing" filters     +------> |   "post" filters     ||
|                   |                 |                         |        |                      ++
+-------+-----------+                 +--+----------+-----------+        +-----------+----------+
        |                                |          ^                                ^
        |                                |          |                                |
        |                                |          |                                |
        |                                |          |                                |
        v                                |          |                                |
+-------+-----------+                    |          |                    +-----------+------------+
| "custom" filters  |                    |          |                    |                        |
|                   |                    |          |                    |     "error" filters    |
|                   |                    |          |                    |                        |
+-------------------+                    |          |                    +------------------------+
                                         |          |
                                         |          |
                                         |          |
                                         |          |
                                   XXX   v          +
                                XX X XXXXX XXX   XXX XXX XX XX
                               X XXX  XX     XX X     XXX    XX
                               XX  X                         XX
                            XX  XX                           XX     X  X
                           X                                             XX
                          X             Origin Server                     X
                          X                                               X
                     XXXXXXX                                         XXXXX
                    X                                                 X
                  XX            X                                      X
                  X X X   X X XXX                          X           X
                                X           X            XXX X     X XX
                                XX     X X XXXX    X X X       X X
                                 XXXX         X X X






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

**NOTE:** Edges services    
                                                                     
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









