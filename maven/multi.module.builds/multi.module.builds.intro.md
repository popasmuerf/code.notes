Maven's multimode projects...
url:https://www.baeldung.com/maven-multi-module


Overiew
=========================
In this tutorial, we wil show how to build a mult-module
project with Maven.





Maven's multi-module project
===================================
A multi-module project is built from a an aggregator 
POM that manages a group of submodules.  In
most cases, the aggregator is located in the project's
root directy and most have packaging of the type "pom"



By building the project thorught he aggregator POM, each project
that has packaging tpe different from that of "pom" will result
in a built archive file




Benefits of Using Multi-Modules
==============================================
The significant advantage of using this approach is that we 
may reduce duplication


Let's say we have an application which consists of sveral modules.
Let it be a front-end module and a back-end module.  Now we work
on both of them and change functiionality which affects
the two.  In that case, without a specialized build too, we will have to build
both components seperately or write a script which would compile the code, run tests and 
show the results.

If after we get even more modules in the project, it will become harder to manage and 
maintain.

Besides in the real world, projects may need certain Maven plugins to perform various operations during build lifecycle, share dependencies and profiles or include other
BOM projects.


Therefor, when leverageing multi-modules, we can build our application's modules in asingle
command and if the order matters, Maven will figure this out for us.  Also we can share a vast amount of configuration with other modules.





Parent POM
===================================
Maven supports inheritance in a way that each pom.xml file has theimplicit parent POM,
called  

	Super POM 

and can be located in the Maven binaries.  These tow files are merged by
Maven and form the 

	Effective POM



We can create our own pom.xml file which will serve us as the parent project.
Then, we can include all configurations with dependencies and set thsi as the parent of our
child modules, so they will inherit these aformentioned configurations....




Besides the inheritance, Maven provides the notion of the aggreation.  Parent POM that
leverages this functionality is called an aggregate POM.  Basically, this 
kindo of POM declares its modules explicity in its pom.xml file



Quick summary
=========================
1. Maven supports pom inheritance.
2. Every maven build has a pom out out the box that
implicitly inherits form a "super pom" that is embeded deeply
out of site within the source of maven.
3. Maven parent poms:
	-	are implicit deriviates of the Super Pom
	-	may be configured just like any other pom
		*	constants
		*	devloper profiles
		*	dependencies
		*	etc
 	-	The configuration attributes of the parent POM may be
		inherited by  other poms.
	-	May also serve as aggreator poms that
		*	Declares its modules explicitly in its pom.xml
                        as oppose to letting implementing/extending poms
                        specify the parent pom to extend/implement




Submodules
==============================================================
Submodules or subprojects are regular Maven projects that inherit from a 
parent POM.  As we already know, inheritance lets us share the configuration
and dependencies with submodules.

HOwever, if we wold liek to build or release our project in one shot...
we have to declare our submodules explicitly in the parent POM(bascially if we
are going to do this in one shot...then our parent pom now must play the role
of aggregator also....)....ultimately our parent POM will be the 
parent as well as the aggregate POM.



Buildig the Application Excercise...
=====================================
Now that we understand Maven's submodules, and hierarchy, let us
build a sample application to demonstrate them.  We will use Maven's 
command line interface to generate our projects.


This app will consist of three modules, that will represent:
	*	The core poart of our domain
	*	The web service provding some REST APIs
	*	A webapp containing user-facing web assests of soem sort



Generating a Parent POM
==============================================
> mvn archetype:generate -DgroupId=io.thirdplanet -DartifactId=parent-project

Once the parent is generated, we have to open the pom.xml file located
in the parent's directory and change the packaging to pom:

	<package>pom<packaging>

By setting packaging to pom type, we are declaring that project will serve as a parent or an aggregator -- it won't produce further artifacts

Now, as our aggregator is done, we can generate our submodules.


We need to note at the risk of ad nauseum...that this isthe place where all the configuration to be shard is located and eventually re-used in child modules.  Amoung other things, we can make use of 

	dependencyManagement
		-or-
	pluginManagement

here.


Creating Submodules
========================
As our parent POM was named "parent-project", we need to make sure
we are in the parent's directoy and run generate commands

> cd parent-project
parent-project> mvn archetype:generate -DgroupId=io.thirdplanet -DartifactId=core
parent-project> mvn archetype:generate -DgroupId=io.thirdplanet -DartifactId=service
parent-project> mvn archetype:generate -DgroupId=io.thirdplanet -DartifactId=webapp


Notice the command used.  It is the same as we used for the parent.  The thing here is, these modules are regular Maven projects....yet Maven recognized they are nested.  When we changed the directory tothe parent-poject...it found that parent has packaging of type pom and modified both pom.xml files accordingly


After that...Maven will generate three submodules and modify for us the parent's pom.xml
file by adding soe tags:


	<modules>
		<module> core </module>
		<module> service </module>
	        <module> webapp </module>
	</modules>


Now our parent explicitly declares aggregated  modules....
====================================================================
Next, when running mvn package command in the parent project directory, 
Maven will build and test all three modules.

Moreover, Maven Reactor will analyze our project and build it in proper order.
So if our webapp module depends on the service module, Maven will build first
the service, then the webapp.

After all, if we wish to share all the configuration with our submodules, in their
pom.xml files, we will have to declare the parent:

	<parent>
	    <groupId>org.baeldung</groupId>
	     <artifactId>parent-project</artifactId>
	     <version>1.0-SNAPSHOT</vesion>
	</parent>


We need to note, the submodules can have only one parent.  However we can import
many BOMs.  More details about the BOM files can be found in this article.


Building the Project
======================================================================
Now we can build all three modules at once.  IN the parent's project directly run

	> mvn package

[INFO] Scanning for projects...
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Build Order:
[INFO] parent-project
[INFO] core
[INFO] service
[INFO] webapp
...
[INFO] Reactor Summary:
[INFO] parent-project ..................................... SUCCESS [  0.140 s]
[INFO] core ............................................... SUCCESS [  2.195 s]
[INFO] service ............................................ SUCCESS [  0.767 s]
[INFO] webapp ............................................. SUCCESS [  0.572 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------



Conclustion...
=======================================================
	*	In this tutorial, we disucssed the benefits of using Maven multi-modules.
	*	We distinguished between regular Maven's:
		-	Regular Maven parent POM
		-	Maven parent Aggregate POM
	*	How to set up a simple multi-module to start to play with










