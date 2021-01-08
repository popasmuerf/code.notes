######url: https://docs.cloudfoundry.org/services/route-services.html

##Terms
==================================================
Cloud Foundry(CF)

##Introduction
==================================================
CF app developers may wish to apply transformation processing
to rquests before they reach an app.

Common examples of use cases include
        *   authentication
        *   rate limiting
        *   caching services

CF app developers may wish to apply transformation or processing
to requests before they rech an app.  Common examples of use
cases include authentication, ate limiting, and caching services.  Route services are a kind of Marketplace service that developers can use to apply various transformations to app requests by binding an app's rout to a service instance.

Through integrations with service brokers and , optionally, with the
CF routing teir, providers can offer these services  to developers with a familiar, automated, self-service, and on-demand user experience.



The possibilities here are endless.  We could preprocess
requests and handle authentication, or perhaps adapt one type
of authentication for another.  We could insert logic to handle rate limiting, or we could forward requests in a certain way by relying on client-side load balancing.


A log ot the things we may wanty to do here -- metering, rate limiting,
authentication, etc. -- are generic conerns that you don't need necessarily to write code for.  A lot of this functionality is well-addressed by API-gateway products like Apigee, that also distribute a Cloud foundry route service that you can configure for 
your application

Using a route service is farily striaghtforward, but not exactly the same as using any other types of route services.  A route service is ultimately just a Cloud Foundry application that we have deployed.

Suppose we have already deployed two applications to Cloud Foundry:
    *   route-service(the logging route service built in this app)
    *   downstream-service

is an example of connecting an application (downstream-service) to a route service) for applications dedployed on Piviotal Web Services where
the domain is cfapps.io by default(if we are using a deployed Cloud Foundrry instance elsewhere, this won't be the case)

        #CF deployment of routing service and binding application to route service
        cf create-user-provided-service route-service -r https://my-route-service.cfapps.io

        cf bind-route-service cfapps.io route-service -hostname mydownstream-service


    ###Summary
    For servicves deployed over HTTP(or any other app level protocol for that matter), routing is a crtical concern which becomes even more important when the lifetime of a service is dynamic and when
    service topologies and when service topologies change.  We want, for the purposes of homogeneous clients accessing the services from outside our system, to project that services are available in 
    a fixed, well-known place but retain complete flexibility for intra-service communcation.  We can achieve these seeminly conflicting concerns with a little thoughtfulness and by leverarging somne of the practices described in tis chapter.
