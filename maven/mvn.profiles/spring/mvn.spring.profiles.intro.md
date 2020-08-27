Maven resource filtering
==============================================
Let's stay in pom.xml for a moment.
In the previous step, you defined a mapping
between Maven and Spring profiles.  But you
still need to 
transfer profile mapping into your Spring Boot application


How ?


You are going to use Maven to set Spring property called

    "spring.profiles.active" 
   
 in the 
 
    "application.properties" 
    
file with the values from defined Maven profiles


In order to do so, you need allow Maven to manipulate
resource files as a part of the build process.

You do this by enableing filtering for the Resources Plugin
in pom.xml.  However, if you use 
spring-boot-starter-parrent as 
the parent of your pom.xml, you can skip this steop...
However, if you use "spring-boot-starter-arent"
as the parent of your pom.xml


After starting your application, the Soring framework activates Srong
profiles as a defined in the filutered application.poperties file.
Next the framework reads


spring.profiles.active is a pom variable that is available during build
but not at run time.....this makes sense as Maven IS A BUILD TOOL...
it has no relevance outside of the build...


If we want our code during runtime to build to be informed of 
any build configurations...we need to pass the build
variable to your application so that it is available hen it 
is started.


1. Define a placeholder in your applic





https://maven.apache.org/guides/introduction/introduction-to-profiles.html
==============================================================================



<profiles>
    <profiles>
        <id>integration-tests</id>
    </profile>
    <profile>
        <id>mutation-tests</id>
    </profile>
</profiles>


Within each profile element, we can
    *   dependencies
    *   plugins
    *   resources
    *   finalName
    
    
In Maven 3, we can actually add profiles to any of the three
locations:

    1. Project-specfic profiles go int the project's pom.xml file
    2. User-specfic profiles go into the user's settings.xml file
    3. Glboal profiles go into the global settings.xml file
    
https://www.baeldung.com/maven-profiles
    
Profiles should be configred in the pom.xml whenever possible.
===============================================================
The reason is that we want to use the profiles both on our development
machines and on the build machines.  Using the settings.xm  file
is more difficult and error-prone as we have to distribute it across
build enviroments ourselves.

Activating Profiles
===========================================
After we create one or more profiles we can start using them, o
in other words, "activating them"


Viewing active profiles...
----------------------------------------------------------------
We can use this mvn command to see which profiles are active...

    > mvn help:active-profiles


Using -P 
---------------------------------------------------------------
We can activate profiles using the -P argument.

> mvn package -P integration-tests




Based on a Property
=================================================================
We can activate profiles on the command-line.  However,
sometimes it is more convenient if they are activated atuomatically.
For instance, we can bae it on a -Dsystem property...


    <profile>
	        <id>active-on-property-environment</id>
	        <activation>
	            <property>
	                <name>environment</name>
	            </property>
	        </activation>
    </profile>
    
We now activate the profile with the command 

    > mvn package -Denviroment
    
It's also possible to activate a profile if a property is not present:

    <property>
        <name> !enivroment </name>
    </property>


Or we can activate teh profile if the property has a specfic value:


	<property>
	    <name>environment</name>
	    <value>test</value>
	</property>
	
Where we can now run the profile with 

    >mvn package -Denviroment=test



    
    
   





What actually worked
============================================================
    ./mvnw spring-boot:run -D"spring-boot.run.profiles"=local

    >./mvnw spring-boot:run -D"spring-boot.run.profiles"=foobar

