What is a Java EE Application Server ?
========================================
From a technical Java perspective, a Java App Server
is any implementation of of the Java EE Application Server spec
that fully complies with and supports all Java EE features:
	*These features extend the standard java platform for use in internet -based business
	such as JTA, EJBs, JMS, JSF, and Java EE APIs for session persistence,
	dependency injection, and more...

Java EE servers deploy applications using the EAR(Enterprise Archive Tormat),
	*Contains one or more WARs
	*WAR files contain:
		*EJBs
		*JSPs
		*Servlets
	*EAR packages are deployed into a single container, so that 
	its classes and resources can be loaded and managed seperately.

Most commercial application servers like Websphere and Weblogic include
extensive management and monitoring tooling, as well as a family of
additional products that integerate with them and provide additional
functionalities for a fee.




What is a Servlet Container?
========================================
In essense....JEE APP servers could be explained as a "superset" of 
Servlet Containers.   How did I come to this conclusion?:
	* JEE App servers consist of both a container(that encapsulates the EAR/WAR files)
	and extra tools used for Application management....
	* JEE App servers implement the JEE specification for :
		*JSP
		*EJB
		*Servlets
		*JTA
		*JSF
		*etc
	*Servlet containers only need to implement the Java Servlet and JSP specfications
	which deal with the container-managed deployment of web applicatons as 
	well as with associated transactions.
	*The servlet specification, which is part of the Java EE platform, includes:
		* WAR
		*JSP
		*JNDI
	^^means that a servlet container can do many of the same things that a web application
	server can....albeit perhaps more clumsily.....
	*The Servelet specification covers so many important web technologies
	that embeded versions of Tomcat ae used as the web and servlet container for many
	commerical application servers.
	*Servlet containers can provide missing specifcation features of the full JEE spec:
		*OpenEJB plugin
		*3rd Party frameworks that ape App Server JavaEE spec:
			*Spring
			*Seam
			*Hibernate
			*Grails
			*Guice
			*JRuby on Rails
			*Play




Most commercial application servers like Websphere and Weblogic include
extensive management and monitoring tooling, as well as a family of
additional products that integerate with them and provide additional
functionalities for a fee.
