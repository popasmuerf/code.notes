Keycloack Configuration
url:https://www.baeldung.com/spring-boot-keycloak
===========================================
Here's the basic, mandatory configuration:

keycloak.auth-server-url=http://localhost:8100/auth
keycloack.realm=SpringBootKeycloack
keycloack.resource=login-app
keycloack.public-client=true 


#Security constratits
keycloack.security-constraints[0].authRoles[0]=user
keycloack.security-constraints[0].securityCollections[0].pattenrs[0]=/customers/*




Dependency
========================================================================
To use Spring Security with Spring Boot, we must add this dependency:
<dependency>
    	<groupId>org.springframework.boot</groupId>
	    <artifactId>spring-boot-starter-security</artifactId>
	    <version>2.2.6</version>
</dependency>



Configuration Class
===========================================================================
Keycloak provides a **KeyCloackWebSecurityConfigurerAdapter** as a convenient
base class for creating a **WebSecurityConfigurer** as a convenient base class
for creating a **WebSecurityConfigurer** instance, which is convenient because
a configuration class extending **WebSecurityConfigurerAdapter** is needed
for any application secured by Spring Security:


        @Configuration
        @EnableWebSecurity
        @ComponentScan(basePackageClasses = KeycloakSecurityComponent.class)
        class SecurityConfig extends KeycloackWebSecurityConfigurerAdapter{

	            @Autowired
	            public void configureGlobal(
	              AuthenticationManagerBuilder auth) throws Exception {
	         
	                KeycloakAuthenticationProvider keycloakAuthenticationProvider
	                 = keycloakAuthenticationProvider();
	                keycloakAuthenticationProvider.setGrantedAuthoritiesMapper(
	                  new SimpleAuthorityMapper());
	                auth.authenticationProvider(keycloakAuthenticationProvider);
	            }
	         
	            @Bean
	            public KeycloakSpringBootConfigResolver KeycloakConfigResolver() {
	                return new KeycloakSpringBootConfigResolver();
	            }
	         
	            @Bean
	            @Override
	            protected SessionAuthenticationStrategy sessionAuthenticationStrategy() {
	                return new RegisterSessionAuthenticationStrategy(
	                  new SessionRegistryImpl());
	            }
	         
	            @Override
	            protected void configure(HttpSecurity http) throws Exception {
	                super.configure(http);
	                http.authorizeRequests()
	                  .antMatchers("/customers*")
	                  .hasRole("user")
	                  .anyRequest()
	                  .permitAll();
	            }


        }
    
    
    
 application.properties
 ===================================
 Because we have set up the security constraints with Spring 
 Security, we can remove the previous security constraints
 we placed in application.properties
 
 keycloak.principal-attribute=preferred_username
 
 
 
 Controller
 ========================================
 To make use of User's username, we are updating our controller
 to inject the Principal:
 
         @GetMapping(path = "/customers")
	        public String customers(Principal principal, Model model){
	            addCustomers(); 
	            model.addAttribute("customers", customerDAO.findAll());
	            model.addAttribute("username", principal.getName());
	            return "customers";
	        }
 
 
 
 
 
 
 Thymeleaf
 ====================================================
 Under the div container, we will add this one line to greet the user:
 
 <h1>Hello, <span th:text="${username}">--name--</span>.</h1>
 
