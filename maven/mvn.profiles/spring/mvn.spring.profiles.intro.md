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
    
    > mvn clean spring-boot:run -Dspring-boot.run.profiles=local
    
    > mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Dspring.profiles.active=beta"
    
    > ./mvnw spring-boot:run -Dspring-boot.run.profiles=beta -Dspring-boot.run.arguments="--secret=BETA_SECRET --random=BETA_RANDOM"

    
    
    
So basically Maven/Gradle profiles and Spring profiles are not the same thing.
==========================================================================
https://dzone.com/articles/spring-profiles-or-maven






Maven Profiles
--------------------------------------------------------------------------
    *Provides a build-time solution
    *Build-time is a 100% compile time affair.
     No code is running at this time.  This excludes
     tests of course.
    *Spring profiles are only apply at runtime.
    *Is it possible to write values to spring profile config files
     during the build ?
    * Maven profiles allow for different artifacts to be built but 
      have no bearing on how those artifacts will behave at runtime....
    * This is why using Maven CLI parameters during artifact run-time fails
    * If you want to a certain spring app to run with a certain config at runtime,
      then you must at a minimum pass Spring specific spring profile configuration
      paramters to the the jar Maven/Gradle/Ant/Scons/etc just built.
    
    
With the Maven build system, change between configuration is acheived through so-called
profiles at build time.  Roughly, a Maven profile is a portion of a POM that
can be enabled(or not) .  For example, the following profile snippet
replaces Maven's standard resource directory with 
a dedicated one:

    <profiles>
        <profile>
          <id>dev</id>
          <build>
            <resources>
              <resource>
                <directory>profile/dev</directory>
                <includes>
                  <include>**/*</include>
                </includes>
              </resource>
            </resources>
          </build>
        </profile>
    </profiles>
    
 
Activating a single or different profile is as easy as using
the **-P** switch with their id on the command-line when invokng Maven.
The following command will activate he **dev** profile provided it is 
set in the POM


        > mvn package -Pdev
        
Fun fact about settins.xml....and Maven
------------------------------------------------------------------
Profiles can even be set in Maven **settings.xml** files.
Seems to go to be true ?  Well, very seasoned Maven users know that as
soon as single profile is explicitly activated, the default profile is deactivated.




Come Spring profiles....
----------------------------------------------------------------------
As opposed to Maven profiles, Spring profiles
are activated at runtime.  I am not sure whether this
is a good or a bad thing, but the implementation makes it
possible for real default configs, with the help of @Conditional
cannotations


        @Configuration
        public class MyConfiguration {
         
            @Bean
            @Profile("dev")
            public DataSource dataSource() throws Exception {
                org.apache.tomcat.jdbc.pool.DataSource dataSource = new org.apache.tomcat.jdbc.pool.DataSource();
                dataSource.setDriverClassName("org.h2.Driver");
                dataSource.setUrl("jdbc:h2:file:~/conditional");
                dataSource.setUsername("sa");
                return dataSource;
            }
         
            @Bean
            @ConditionalOnMissingBean(DataSource.class)
            public DataSource fakeDataSource() {
                JndiDataSourceLookup dataSourceLookup = new JndiDataSourceLookup();
                return dataSourceLookup.getDataSource("java:comp/env/jdbc/conditional");
            }
        }





 




