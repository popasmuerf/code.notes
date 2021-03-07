Profiles accordig to Spring
====================================================
Spring Profiles provide a way to segregate parts of your application configuration
and make it only available in certain enviroments.

Any bean that has been annotated with 

	@Component
	@Configuration

may be annotated with 

	@Profile


to limit when it is loaded...


	//Code

	@Configuration
	@Profile("production")
	public class ProductionConfiguration{
		//....
	}


In the normal Spring way, you can use the properties to specify
which profiles are active.  You can specify the Enviroment property

	spring.profiles.active

You can specify the proerty in any of the usual ways, for example you 
could include it in your configuration file application.properties:

	spring.profiles.active=dev,hsqldb


or specify on the command line using the switch

	mvn spring-boot:run -Dspring.profiles.active=dev,hsqldb





Adding active profiles
===================================================
The

	spring.profiles.active

property  follows the same ordering rules as other properties, the 
highest PropertySource will win.

This means that you can specify active profiles in 

	application.properties

then replace them using the cmmand line switch.


Sometimes it is usefult ohave profile specific properties that add to the active
profiles rather than replace them.

The  property

	spring.profiles.include

can be used to unconditionally add active profiles.
The  app entry point

	SpringApplication

aslo has a Java API for setting addtional profiles(i.e. on top of those activated by
spring.profiles.active property)


For example, when an application with the following properties is run using the 
switch

	-spring.profiles.active=prod


the proddb and promq profiles will also be activated.


	#code

	---
	my.property: fromyamlfile
	---
	spring.profiles: prod
	spring.profiles.include: proddb, prodmq


NOTE: Remember that the spring.profiles property can be defined in a YAML
document to determine when this particular document is included in the 
configuration.


Programmatically setting profiles
================================================
We can programmatically set active profiles by acalling 

	SpringApplication.setAdtionalProfiles(...)

before your application runs.  It is also possible to activate
profiles  using  Spring's interface


	ConfigurableEnviroment



Profile specific configuration files
==================================================
Profile specific variants of both 

	application.properties
		-or-
	application.yml

and files referenced via 

	@ConfigurationProperties




Spring profiles according to Baeldung...
===========================================================

Overview
------------------------------------------------------------
Profiles are a core feature of the framework...allowing us to map our beans
to different profiles...
for example, dev, test, prod


Why?  We can activate different profiles in diffrent enviroments to bootstrap
just the beans we need...






@Profile on a Bean
-------------------------------------------------------------------
Let's start simple and look at how we can make a bean belong to a particular profile
Using the @Profile annotation - we are mapping the bean to that particular profile; the 
annotation simply takes the names of one (or multiple) profiles.


for example, dev, test, prod
are considered as files are loaded.

Consider a basic scenario - we have a bean that should only be active during 
development, in production, the dev simply won't be active

	//code
	@Component
	@Profile("dev:)
	public class DevDatasourceConfig


As a quick sidenote, profile names can also be prefixed with a NOT operator e.g.
"!dev" to excude them from a profile

	//code
	@Component
	@Profile("!dev:)
	public class DevDatasourceConfig


Declare Profiles in XML
--------------------------------------------------
Profiles can also be configured in XML - the <beans> tag has "profiles" attribute
which takes comma separated values of the applicable profiles:

<beans profile="dev>
	<bean id="devDatasourceConfig" 
         class="org.baeldung.profiles.DevDatasourceConfig"/>
</beans>




Set Profiles
--------------------------------------------------------------
The next step is to activate and set the profiles so that the
respective beans are registered in teh container...
This can be done in a variety of ways -- which we will explore in the 
following sections



Programmatically via WebApplicaitonInitializer Interface
--------------------------------------------------------------
In web applications, 

	WebApplicationInitializer 

can be used to configure the ServletContext programmatically


It is also a very handy loation to set our active profiles programmatically:

	@Configuration
	public class MyWebApplicationInitializer implements WebApplicationInitializer{

		@Override
		public void onStartup(ServletContext servletContext) throws ServletException{
		    servletContext.setInitParameter("spring.profiles.active","dev") ;
		}

	}



Progammatically via ConfigurableEnviroment
-----------------------------------------------------

	@Autowired
	private ConfigurableEnviroment env ;
	...
	env.setActiveProfiles("someProfile") ;



Context Parameter in web.xml
--------------------------------------------------------
Similarly, profiles can be activated in the web.xml of the 
web application as well, using a context parameter:

	<context-param>
	    <param-name>contextConfigLocation</param-name>
	    <param-value>/WEB-INF/app-config.xml</param-value>
	</context-param>
	<context-param>
	    <param-name>spring.profiles.active</param-name>
	    <param-value>dev</param-value>
	</context-param>


JVM System Parameter
-----------------------------------------------------------
The profile names can also be passed in via a JVM system paramter.
Teh profile names passed as teh parameter will be activated during 
application start-up

 #VM properties.....
 -Dspring.profiles.active=dev 

mvn spring-boot:run -Dspring.profiles.active=dev 

Maven Profile
----------------------------------------------------------------------
Spring profiles can also be activated via Maven profiles,
by specifying the 

	spring.profiles.active

configuration property.

In every Maven profile, we an set a spring.profiles.active property:



	<profiles>
		<profile>
		    <id>dev</id>
		    <activation>
			 <activeByDefault>true</activeByDefault>
		    </activation>
		    <properties>
			    <spring.profiles.active>dev</spring.profiles.active>
		    </properties>
		</profile>

		<profile>
		    <id>dev</id>
		    <activation>
			 <activeByDefault>true</activeByDefault>
		    </activation>
		    <properties>
			    <spring.profiles.active>dev</spring.profiles.active>
		    </properties>
		</profile>

	</profiles>


It's value will be used to replace the @spring.profiles.active@placeholder
in application.properties

	spring.profiles.active=@spring.profiles.active@


Now, we need to enable resource filtering in pom.xml:
--------------------------------------------------------------
	<build>
	    <resources>
		<resource>
		    <directory>src/main/resources</directory>
		    <filtering>true</filtering>
		</resource>
	    </resources>
	    ...
	</build>


...and append a -P paramter to switch which Maven profile will be applied:

	mvn clean package -Pprod




DZone on Profiles....
================================================================
url: https://dzone.com/articles/spring-boot-profiles-1


Every enterprise application has many enviroments like:

	Dev
	Test
	Stage
	Prod
	UAT / Pre-Prod


Each enviroment requires a setting that is specific to them.
For example, in DEV we do not need to constantly
check database consistency.  Whereas in TEST and
STAGE, we need to.  These enviroments host
specfic configurations called Profiles.


How do we maintain Profiles
------------------------------------------------------------
This is simple.....properties files!!!
We need an property file for each enviroment and set
the profile in the application accordingly, so it will pick
the respective properties file.  Don't worry, we will see 
how to set it up..


Then, we need to create three  application.properties:

     application-dev.properties 
     application-test.properties 
     application-prod.properties







Spring Boot Profiles
===================================================================
You can define default configuration in application.properties
Enviroment specific overrides can be configured in specific files.

	application-dev.properties
	application-qa.properties
	application-stage.properties
	application-prod.properties

Setting A Spring Boot Profile
===============================================================================

