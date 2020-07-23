Using the Spring RestTemplate
Interceptor
========================================================

Interceptor Usage Scenarios
========================================================
Besides header modification, some of the other
user-cases where a **RestTemplate** interceptor is useful
are:

*   Request and response  logging
*   Retrying the rquests with a configurable back off strategy
*   Request denial based on certain request parameters
*   Altering the request URL address



Creating the Interceptor
==========================================================

In most programming paradigms, interceptors are an essential part 
tht enables programmers to control the execution by intercepting it.
Spring framework also supports a variety of interceptors for different purposes.



Spring RestTemplate allows us to add interceptors that implement
**ClientHttpRequestInterceptor**  the 
method signatures of this interface are :

    **intercept(HttpRequest,byte[],ClientHttpRequestExecution)**
    
    of this interface will intercept the given request and 
    return the response by givig us access to the reqest, body, and
    execution objects
    
    
 So what's are first step ?
 =============================================
 We have to create an interceptor class that implements the 
 ClientttpRequestInterceptor interface:


public class RestTemplateHeaderModifierInterceptor implements 
