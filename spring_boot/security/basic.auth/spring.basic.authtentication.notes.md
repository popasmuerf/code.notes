Enabling Basic Authentication in Spring Security...
================================================

Spring Security provides a special CsrfTokenRepository

	*	The CsrfTokeRepository is used to send cookies
	*	When you start with a clean browser(or in incognito mode)
		, the first request to the sever has no cookies.
	*	Initial requests(usually your first request), the server
		sends back a:
		-	Set-Cookie for
			*	JSESSIONID (the regular HttpSession)
			*	X-XSRF-TOKEN (CRSF cookie)

	*	All subsequent rquests will have these cookies
	*	Spring Security(in all contexts ?) doesn't work without
		CSRF cookies
	*	CSRF cookies  provide basice securtiy functions
		-	authentication
		-	CSRF protection

	*	After log out, the values of the cookies change.




Basic Authentication via Spring Security Refresher
============================================================

Enabling Basic Authentication in Spring
---------------------------------------------------

*	include Spring Boot starter Security dependency in build file
*	//Code

@Configuration
@Order(SecurityProperties.ACCESS_OVERRIDE_ORDER)
public class SpringSecurityConfiguration_InMemory extends WebSecurityConfigurerAdapter{

	@Autowired
	protected void configureGlobal(AuthenticationManagerBuilder auth) throws Exception{
		auth.inMemoryAuthentication()
		.withUser("admin")
		.password("password")
		.roles("USER","ADMIN")
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		http.Basic()
		.realmName("userRegisteration System")
		.and()
		.authorizeRequests()
		.antMatchers(HttpMethod.GET,"/api/user/")
		.hasRole("USER")
		.antMatchers(HttpMethod.POST,"/api/user/")
		.hasRole("USER")
		.antMatchers(HttpMethod.PUT,"/api/user/**")
		.hasRole("USER")
		.antMatchers(HttpMethod.DELETE,"/api/user/**")
		.hasRole("ADMIN")
		.and()
		.csrf()
		.disable() ;

	}

}



^^^ What's wrong with the above ?
======================================
Nothing....except that every time you open a browser and access a web page, a pop-up
appears in the borwser for a username and password.

We can fix this issue by sendng an authorization header with each request in AngularJS
or whatever front end tech we are using.


This means that each request is independent of other requests, and the server doesn't maintain
any state information for the client.


How should we go about this ?

We could send an authentication header with each and every request....
We could refactor the GET/POST/PUT/etc request methods/modules in Angular(let's just assume
we are using Angular).....
...but that's stupid.

We could come up with an "http interceptor".....an "object" that is called before and after 
requests and responses respectively.....that adds the header to the outgoing/incomping message from  the server.....
...this is smart..


with interceptors...we can modify headers...add extra logic ...etc..etc...



var app = angular.module('userresgistrationsystem',['ngRoute','ngResource']);

app.factory('AuthInterceptor',[function(){
	return {
		'request':function(config){
			config.headers = config.headers || {} ;
			var encodedString = btoa("admin:password") ;
			config.headers.Authorization = 'Basic' + encodedString ;
			return config ;
		}
	}
});


app.config(function(routeProvider){
	routeProvider
	.when('list-all-users':{templateUrl:'templatelistuser.html',controller:'listuserController'})
	.when('list-all-users':{templateUrl:'templatelistuser.html',controller:'listuserController'})
	.when('list-all-users':{templateUrl:'templatelistuser.html',controller:'listuserController'})
}

app.config(["httpProvider",function("httpProvider){
"httpProvider.interceptors.push("AuthInterceptor")}]) ;







