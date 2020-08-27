https://www.marcobehler.com/guides/spring-security
======================================================

What is Spring Security and how does it work ?
======================================================
The short answer:

*   Spring Security is really just a bunch of 
    servlet filters
    
*   Spring Security servlet filters help you add
        -   authorization
        -   authentication
        -   etc
        
*   It also integrates well with frame works like
    Spring Web MVC (or Spring Boot), as well as 
    with standards like
        -   OAuth2
        -   SAML
        
*   Auto-generates  login/logout pages

*   Protects against common exploits like CSRF





Web Application Security
========================================================
Before you become a Spring Security Guru, you need to understand
three important concepts:

1. Authentication
2. Authorization
3. Servlet Filters


We know what Auth and Authorization is....but what about 
Servlet Filters?

    *   All spring apps are at their core are just one Servlet
    *   That Servlet is Spring's DispatcherServlet, that redirets incoming
        HTTP requets to your @Controllters or @RestControllers
 
 There is no security hardcoded into the DispatcherServlet and you also very
 likely don't want to fumble around with a raw
 HTTP Basic Auth header in your @Controllers.
 
 Optimally, the authentication and authorization should be done before a request
 hits your @Controllers.
 
 Spring allows us to to easily place filters infront of our controller.
 
 A naive SecurityFilter
 =========================================================
 A SecurityFilter has roughly 4 tasks and a naive
 and overly-simplified implementation...
 
 //A naive SecurityFilter 
 
 import javax.servlet.*;
 import javax.servlet.http.HttpFilter ;
 import javax.servlet.http.HttpServletRequest ;
 import javax.servlet.http.HttpServletResponse ;
 import java.io.IOException ;
 
 public class SecurityServletFilter extends HttpFilter{
 
    @Override
    protected void doFilter(HttpServletReq request, HttpServletResponse){
        UsernamePasswordToken token = extractUserNameAndPasswordFrom(request) ;
        if(notAuthentiated(token){
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED) ;
            return ;
        }    
        
        if(notAuthorized(token,request){
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED) ;
            return ;
        }
        
        // allowthe HttpReqest to go to 
        //the Dispatch Servlet's Controller
        chain.doFilter(request, response) ;
        
        /*
           Either try and read in a Basic Auth HTTP Header, which comes in the form of user:password
           Or try and find form login request parameters or POST bodies, i.e. "username=me" & "password="myPass"
        */
        private UsernamePasswordToken extractUsernameAndPasswordFrom(HttpServletRequest request) {
            return checkVariousLoginOptions(request);
        }
        
        private boolean notAuthenticated(UsernamePasswordToken token) {
        // compare the token with what you have in your database...or in-memory...or in LDAP...
        return false;
        }

        private boolean notAuthorized(UsernamePasswordToken token, HttpServletRequest request) {
       // check if currently authenticated user has the permission/role to access this request's /URI
       // e.g. /admin needs a ROLE_ADMIN , /callcenter needs ROLE_CALLCENTER, etc.
       return false;
        }
    
    }
 
 }



1. Filter is called by the httpserver
2. Filter checks the req header for user name and password
3. If UserName and Password is not verfied then set response header code to
   UNAUTHORIZED and return from Filter
4. If Auth token in conjunction with UserName and Password is not reconciled...
   then set response code to UNAUTHORIZED and return from filter..
   
5. Extract request parameters and or body and send to DispatchServlet's Controller.
   


FilterChains
=========================================================
Reality Check:  While the above code compiles, it would sooner or
later lead to one omonster filter with a ton of
code f various authentication and authorization mechanisms.


In the real-world, however, you would split this one filter up into multiple
filters, that you then chain together...

for example, an incoming HTTP request would:

    1. First, og thru a LoginMethodFilter...
    2. Second, go through an AuthenticationFilter...
    3. Finally, hit your servlet....

This conscept is called "FilterChain" and the last method
call in you filter above is actually delegating to that very chain:

    chain.doFilter(reqeust, response) ;
    
    
 With such filter (chain) you can basically handle every
 authentication or authorization problem there is in your
 application, without needing to change your actual application
 implementation(think: you @RestControllers / @Controllers)
 
 
 Armed with that knowledge, let's find out how 
 Spring Security makes use of this filter magic.
 
 
 
 
**** SPRING SECURITY AND OAUTH2 ****
**** SPRING SECURITY AND OAUTH2 ****
https://www.marcobehler.com/guides/spring-security-oauth2




FilterChain and Security Configuration DSL
================================================================
We will start covering Spring Security a bit unconventionally,
by going in the reverse direction from the previous chapter,
starting with Spring Security's FilterChain


Spring's DefaultSecurityFilterChain
==================================================================
Assuming we setup Spring Security correctly then boot up
your aweb application, we will see the following log message:

             [org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter@46320c9a, org.springframework.security.web.context.SecurityContextPersistenceFilter@4d98e41b, org.springframework.security.web.header.HeaderWriterFilter@52bd9a27, org.springframework.security.web.csrf.CsrfFilter@51c65a43, org.springframework.security.web.authentication.logout.LogoutFilter@124d26ba, org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter@61e86192, org.springframework.security.web.authentication.ui.DefaultLoginPageGeneratingFilter@10980560, org.springframework.security.web.authentication.ui.DefaultLogoutPageGeneratingFilter@32256e68, org.springframework.security.web.authentication.www.BasicAuthenticationFilter@52d0f583, org.springframework.security.web.savedrequest.RequestCacheAwareFilter@5696c927, org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter@5f025000, org.springframework.security.web.authentication.AnonymousAuthenticationFilter@5e7abaf7, org.springframework.security.web.session.SessionManagementFilter@681c0ae6, org.springframework.security.web.access.ExceptionTranslationFilter@15639d09, org.springframework.security.web.access.intercept.FilterSecurityInterceptor@4f7be6c8]|



If we expand the above to a list, we will come to the realization that Spring Security Starter does not install just one filter...but fucking 15 filters!!!!       


        Browser HTTP Request --->  SecurityContextPresistenceFilter ---> HeaderWriterFilter ---> CsrFilter --->  LogoutFilter ---> UsernamePasswordAuthenticationFilter --->  DefaultLogingPageGeneratingFilter ---> DefaultLogoutPageGeneratingFilter ---> BasicAuthenticationFilter ---> RequestCacheAwareFilter ---> SecurityContectHolderAwareRequestFilter ---> AnonymousAuthenticationFilter --->
        SessionManagementFilter ---> ExeptionTranslationFilter --->  FilterSecurityInterceptor ---> @RestController/@Controller      
     
Spring Security's source code 
==================================================================
https://github.com/spring-projects/spring-security


Analyzing Spring's FilterChain
================================================================
        BasicAuthenticationFilter:
            -Tries to find Basic Auth HTTP Header on the request 
            -If found, tries to authenticat the user with the 
             header's username:password
             
        UsernamePasswordAuthenticationFilter:
            -Tries to find username/password request parameter:
                https://foobar.com?username=foo&password=bar
            -If found attemtps to authenticate the user with those values
            
        DefaultLoginPageGeneratingFilter:
            -Generates a login page for you
            -Needs to be explicitly disabled
          
        DefaultLogoutPageGeneratingFilter:
            -Generates a logout page for you
            -Must be explicitly disabled
            
        There are more filters....these are just a few...
        
        
Summary...
==============================
    -This is Spring security
    -These filters do all the work
    -What is left to you is the actual configuration of these filters
        *URLs to protect
        *URLs to ignore
        *DB tables/documents to use for authentiation
        *etc
        
        
How to configure Spring Security:
WebSecurityConfigurerAdapter
===============================
With the latest Spring Security  and/or Spring
Bott versions, the way to configure Spring Security
is by having a class that is:

    1. Is annotated with EnableWebSecurity
    2. Extends WebSecurityConfigurer, which basically
       offers you a configuration DSL/methods:
        -filtering requests to URLs
        -Configuring exploit protections like cross site scripting
        
//Example of typicaly WebSecurityCongigurerAdapter

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter{

    @Override
    protected void configure(HttpSecurity http) throws Execption{
        http.authorizRequests()
        .antMatchers("/","/home",).premitAll()
        .anyRequest().authenticated()
        .and()
        .formLogin().loginPage("/login").premitAll()
        .and()
        .logout().premitAll()
        .and()
        .httpBasic() ;
    
    }
    
} 


//The Default generated WebSecurityClass 
//Generated by Spring when including 
//Spring Security Starter in the classpath
//if you opt not to define one yourself...




        public  abstract class WebSecurityConfigurer<WebSescurity>{
            @Override
            protected void configure(HttpSecurity http)throws Exception{
                http
                    .authorizeRequests()
                        .anyRequest().authenticated()
                        .and()
                    .formLogin()
                        .and()
                    httpBasic;
            }
        }

        1. To access any URI(anyRequest) 
           you need to authenticate
           
        2. Form Login with default settings enabled


        3. As is HTTP Basic Basic authentication
          

This default configuration is why your app is in lockdown.



Summary:
WebSecurityConfigurerAdapter DSL configuration
==============================================================
We learned that Spring Security consists of a 
couple of filters that you configure with a
WebSecurityConfigurer @Configuration class

But there is one crucial piece missing.
Let's take Spring's BasicAuthFilter for example.
It can extract a username/password from an
HTTP basic Auth header, but what does it
authenticate these credentials against ?


This naturally leads us to the question of how 
authenticatin works with Spring Security...


Authentication with Spring Security
==============================================
When it comes to authentication and Spring
Security you have roughly three scenarios...

1. Default: 
    -Access to the hased password of the user, because you have
     his details(username,password) saved in the 
     database table
     
2. Less common: 
    -You cannot access the hased password of the user.  This is
     the case ifyour users and passwords are stored somewhere
     else, likein a 3rd party identiy management product offering
     REST services for authentication.  Think "Atlassian Crowd"
     
     
3. Also popular:
    -You want use OAuth2 or OpenID
    -Likely in compbination with JWT.
    
    
4. All of these scenarious will require you to to define
   some different beans to get Srping Security working,
   else you will get really weird NullPointerExceptions
   (like when you forget to specify the PasswordEncoder).









@Configuraton
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter{
    @Override
    protected void configure(HttpSecurity http){
        http
            .authorizeRequests()
                .anyRequest().authenticated()
                .and()
            .formLogin()
                .loginPage("/login")
                .premitAll() ;
    }
}
   
Learning the Spring Security DSL
===========================================
https://www.marcobehler.com/guides/spring-security#security-examples







