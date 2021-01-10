######url: https://docs.cloudfoundry.org/services/route-services.html

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









