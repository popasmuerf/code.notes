Interface ApplicationContext
=================================================


All Superinterfaces:
-----------------------------------------------------
    ApplicationEventPublisher, BeanFactory, EnvironmentCapable, HierarchicalBeanFactory, ListableBeanFactory, MessageSource, ResourceLoader, ResourcePatternResolver

All Known Subinterfaces:
------------------------------------------------------
    ConfigurableApplicationContext, ConfigurableWebApplicationContext, WebApplicationContext

All Known Implementing Classes:
------------------------------------------------------
    AbstractApplicationContext, AbstractRefreshableApplicationContext, AbstractRefreshableConfigApplicationContext, AbstractRefreshableWebApplicationContext, AbstractXmlApplicationContext, AnnotationConfigApplicationContext, AnnotationConfigWebApplicationContext, ClassPathXmlApplicationContext, FileSystemXmlApplicationContext, GenericApplicationContext, GenericGroovyApplicationContext, GenericWebApplicationContext, GenericXmlApplicationContext, GroovyWebApplicationContext, ResourceAdapterApplicationContext, StaticApplicationContext, StaticWebApplicationContext, XmlWebApplicationContext 



Spring ApplicationContext
==============================================================================
ApplicationContext is a corner stone of a Spring Boot aplication.  It represents the 
Spring IoC container and is responsible for instantiating, configuring, and assembling
the beans.   

The container gets its instructios on what objecst to instantiate,
configure, and assemble by reding configuration metadata.  

The configuration metadata is represented in XML, Java annotations, or Java code..




Appliation Context provides the following:

1. Bean factory methods for accessing application components
2. The ability to load file resources in a generic way
3. The ability to public events to registered listeners
4. The ability to resolve messages, supportin internalization



 


public interface ApplicationContext
====================================================

Central interface to provide configuration for an application.
This is read-only while application is running, but may be relaoded if the implementation
supports this.

An ApplicationContext provides:


    *Bean factory methods for accessing application components. Inherited from ListableBeanFactory.
    *The ability to load file resources in a generic fashion. Inherited from the ResourceLoader interface.
    *The ability to publish events to registered listeners. Inherited from the ApplicationEventPublisher interface.
    *The ability to resolve messages, supporting internationalization. Inherited from the MessageSource interface.
    *Inheritance from a parent context. Definitions in a descendant context will always take priority. This means, for example,  that a single parent context can be used by an entire web application, while each servlet has its own child context that is independent of that of any other servlet. 



ApplicationContext has several implementations.  For instance, the
ClassPathXmlApplicationContext takes configuration from an XML file on the
classpath or AnnotationConfigApplicationContext, which reads configuratrion using 
annotations, especially @Configuration.



Getting ApplicationContext
=============================================
To access the application context, we can autowire the AppicationContext interface
or implement the **ApplicationContextAware** class...


A quickly take a step back --- 
--------------------------------
A Spring Application Context
manages the lifecucle of all the beans registered
with it.  Application Context hierarchies provide a way to resue beans --
beans defined in the parent context are accessible in 
the child contexts...


Consinder a contrived use-case of using multiple application
contexts and the application context hierarchy 
-- this is to provide tow different ports




			Root
			-----
		      /      \
	             /        \
                   Child1     Child2



Child1 and Child2 are typical Spring Boot Applications,
along these lines:



	package child1;   
	import org.springframework.beans.factory.annotation.Value; 
	import org.springframework.boot.autoconfigure.SpringBootApplication; 
	import org.springframework.context.annotation.Bean; 
	import org.springframework.context.annotation.PropertySource; 
	import root.RootBean;   


	@SpringBootApplication
	@PropertySource("classpath;/child1.properites")
	public class ChildContext1{
		@Bean
		public ChildBean1 childBean1(RootBean rootBean,
					    @Value("${foot.property}"} String someProperty)
		{
			return new ChildBean1(rootBean, someProperty) ;
		}
	}


	#child1.properties
	server.port=8080
	spring.application.name=child1







	package child2;   
	import org.springframework.beans.factory.annotation.Value; 
	import org.springframework.boot.autoconfigure.SpringBootApplication; 
	import org.springframework.context.annotation.Bean; 
	import org.springframework.context.annotation.PropertySource; 
	import root.RootBean;   


	@SpringBootApplication
	@PropertySource("classpath;/child2.properites")
	public class ChildContext2{
		@Bean
		public ChildBean1 childBean2(RootBean rootBean,
					    @Value("${foot.property}"} String someProperty)
		{
			return new ChildBean1(rootBean, someProperty) ;
		}
	}


	#child2.proerties
	server.port=9090
	spring.application.name=child2



Each of the applications resides in its own root package to 
avoid collisions when scanning for beans.  Note that the 
bean in the child contexts depends on a bean that
is expected to come from the root context


The port to listen on is provided as properties, since the
two contexts are expected to listen on different ports
I have explicitly specified the property file to load with 
a context along these lines:



	#child1.properties
	server.port=8080
	spring.application.name=child1


	#child2.proerties
	server.port=9090
	spring.application.name=child2





Given this setup, Spring Boot provides a fluid interace to 
load up the root context and thtwo child contexts:

SpringApplicationBuilder appBuilder = 

    new SpringApplicationBuilder()
	.parent(RootContext.class)
	.child(ChildContext1.class)
	.sibling(ChildContext2.class) ;


ConfigurableApplicationContext appliationContext = appBuilder.run();



The application context returned by the  SpringBootApplicationBuilder
appears to be the final one in the chain, defined via ChildContext2.


If the application isn ow started up, there would be a root
context with two different child contexts, each exposing
an endpoint via a different port.  A visualization
viat the /beans actuator endpoint shows this:




[
	{
         "context:"root",
         "parent": null,
         "beans":[...]
        },
	{
         "context:"root",
         "parent": null,
         "beans":[...]
        },
	{
         "context:"root",
         "parent": null,
         "beans":[...]
        },
]




























