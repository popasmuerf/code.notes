mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Dspring.profiles.active=local -Djavax.net.debug=all"





## About Endpoints (Providers)

Spring Web Services support multiple transport protocols.  the most cmmon
is the HTTP transport, for which a custome **MessageDispatcherServlet** servlet
is supplied.  This is a standard **Servlet** which extends fromt he 
standard Spring Web **DispatcherServlet** [=central dispatcher for HTTP request handlers/controllers](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/servlet/DispatcherServlet.html)  and wraps a **MessageDispatcher**



The server-side of Spring-WS is designed around a central class called
**MessageDispatcher** that dipatches inconing XML messages to endpoints.
For more detailed in



The server-side of Spring-WS is designed around a central class called
a **MessageDispatcher** that dispatches incoming XML messages to 
endpoints .  For more detailed information check out the 
refercnec documenation regarding MessageDispatchers.....
[Spring MessageDispatcher Reference Guide](https://docs.spring.io/spring-ws/docs/3.0.6.RELEASE/reference/#_the_code_messagedispatcher_code)



Note:  
        In other words: the **MessageDispatcherServlet** combines the attributes of the
        **MessageDispatcher** and **DispatcherServlet** and as result allows the handling
        XML messages over HTTP.


        **WebServiceConfig** config class we use a **ServletRegistrationBean** to 
        register the ***MessageDispatcherServlet**



Note:
It is important to inject and set the ApplicationContext to the 
**MessageDispatcherServlet**, otherwise it is not automatically detect other Spring Web Sevices related beans (such as the lower **Wsdl11Definition**)






Note that it is important to inject and set 

