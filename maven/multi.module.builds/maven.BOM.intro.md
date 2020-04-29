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




Spring with Maven BOM
============================================================

Overview
---------------------------------------------------------
In this quick tutorial we are going to look at how Maevn, a tool based on the
concept of Project Object Model(POM), can make use of a BOM or "Bill Of Materials".

Waht is Maven POM ?
---------------------------------------------------------------
Maven POM is an XML file that contains information and configurations
(about the project) that are used by Maven to import dependencies and to buid the
project.



What is Maven BOM ?
---------------------------------------------------------------------------
BOM stands for Bill of Materials.  A BOM is a special kind of POM that is used
to contorl the version of a project's dependencies and provide a central place to define and update those versions.

BOM provides the flexibility to add dependency to our module without worrying 
about the version that we should depend on.





Transitive Dependencies
--------------------------------------------------------------
Maven can discover the libraries that are needed by own own dependencies in our pom.xml
and includes them automatically.  There is not limit to the number of dependenc levels that the libraries are gathered from.

The conflict here comes when 2 dependencies refer to different versions of a 
specific artifact.

Which one will be included by Maven ? 

The answer here is the "nearest definition". This means that the version used will be the
closest one toour project in the tree of dependenices.  This is known as dependency
mediation.....

A->B->C->D 1.4   and A->E->D 1.0

In the above example...

A depends on B.
B and E have their own dependencies which 
encoounter different vesions of teh D artifact.
Artifact D 1.0 will be used in the build of project A 
because the path through E is shorter



There are diffent techiques to deterin which version of the artiffacts should 
be included:
	*	We can always guarnatee a version by declaring it explicityly in 
		our project's POM.
	*	We can use the Dependency Mangement section to control artifact versions
                s we will explain later in this article


Dependency Management
-----------------------------------------------------
Simply put...Dependency Management is a mechanism to centralize the dependency
information.

When we have set projects that inherit a common parent, we cna put all 
dependency information in a shared POM file called a BOM.....


<!-----BOM example------->
<project ...>
     
    <modelVersion>4.0.0</modelVersion>
    <groupId>baeldung</groupId>
    <artifactId>Baeldung-BOM</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>pom</packaging>
    <name>BaelDung-BOM</name>
    <description>parent pom</description>
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>test</groupId>
                <artifactId>a</artifactId>
                <version>1.2</version>
            </dependency>
            <dependency>
                <groupId>test</groupId>
                <artifactId>b</artifactId>
                <version>1.0</version>
                <scope>compile</scope>
            </dependency>
            <dependency>
                <groupId>test</groupId>
                <artifactId>c</artifactId>
                <version>1.0</version>
                <scope>compile</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>
</project>


Now...how does the above differ exactly from a POM of any other parent project ?
It's the section :

	"Normal" parents act as single parents.  All of their children
	may only inherit from them and them alone.

	You can however import as many BOMs into any particular module that you
	would like.



We can also import the BOM
-----------------------------------------------------
In larger projects, the approach of inheritance is not efficient because the
project can inherit only a single parent.  Importing is the alternative as 
we can import as many BOMs as we need.

Let's see how we can import a BOM file into our project POM


<project ...>
    <modelVersion>4.0.0</modelVersion>
    <groupId>baeldung</groupId>
    <artifactId>Test</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>pom</packaging>
    <name>Test</name>
     
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>baeldung</groupId>
                <artifactId>Baeldung-BOM</artifactId>
                <version>0.0.1-SNAPSHOT</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>
</project>


Overwriting BOM Dependency
------------------------------------------------------------

The order of precedence of the artifact's version is:
	1.The version of the artifact's direct declaration in our project pom
	2.The version of the artifact in the parent project
	3.The version int he imported pom, taking into consideration the order of importing files 
	4. Dependency mediation


Spring BOM
-------------------------------------------------------------
We may find that a third-party library, or another Spring project that pulls
in a transitive dependency to an older release.  If we forget to explicityly declare
a direct dependency, unexpected issues can arise.


To overcome such problems, Maven supports the concept of BOM dependency.

We can import the spring-framework-bom in our dependencyManagement section to 
ensure that all Spring dependencies are at the same version



<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-framework-bom</artifactId>
            <version>4.3.8.RELEASE</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>

We don't need to specify the version attribute when we us the Spring artifacts
as in the following example


<dependencies>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-context</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-web</artifactId>
    </dependency>
<dependencies>




If you ahve ever weorked on a maven project for dependency management, then you
must have faced one prolbem at least once or may be more than that.  And the problem
is VERSION MISMATCH.  It generally happens when you got some dependencies with different
version numbersalready, they can face undesired results in compile time
as well as runtime also.


Ideally to avoid above issue you need to explicitly exclude the related dependency,
but it is quite possible that you can forget to do so.


To solve version mismatch issue, you can use the concpt of a "bill of materials" (BOM) 
dependency.  A BOM dpendency keep track of version numbers and ensure that
all depenendcies(both direct and transitive) are at the same version.



How to add a maven BOM dependnecy
===========================================
Maven provides a tag :

	<dependencyManagement>
	...
	...
	...
	</dependencyManagement>


for this purpose.  Youneed to add the maven bom 
information in this tag as follows...

<dependencyManagement>
	<dependencies>
	    <dependency>
		<groupId>org.spring.framework</groupId>
		<artifactId>spring-framework-bom</artifactId>
                <version>4.0.1.RELEASE</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
	</dependencies>

</dependencyManagement>



An added benefit of using the BOM is that you no longer need to specify the version attribute when depending on Spring framework artificats.  So i will work perfectlyf ine.
as depicted  in the below....

<dependencies>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-context</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-web</artifactId>
    </dependency>
<dependencies>


Each project has it's own maven bom file
=====================================================
Please note that there is no common or univeal bom file.
Each project(if support this feature) provides its own bom 
file and manages versions of it's related dependencies....

A few examples of various bom files are below:



1) RESTEasy Maven BOM dependency

<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.jboss.resteasy</groupId>
            <artifactId>resteasy-bom</artifactId>
            <version>3.0.6.Final</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>


2) JBOSS Maven BOM dependnecy
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.jboss.bom</groupId>
            <artifactId>jboss-javaee-6.0-with-tools</artifactId>
            <version>${some.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement> 

3) Spring Maven BOM dependency
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-framework-bom</artifactId>
            <version>4.0.1.RELEASE</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>


4) Jersey Maven BOM dependency
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.glassfish.jersey</groupId>
            <artifactId>jersey-bom</artifactId>
            <version>${jersey.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>


It's suggested that I try this feature....and I shall....



Maven BOM vs POM
==================================================
First of all, BOMs are ordinary pom.xml files....
let me repeat...BOMs are actually just POM files...

They do not contain any source code(you mean the project in which they exist..right?)
and their only purpose is to declare their bundled modules.  It defines the the versions of all the artifacts that will be created in the library.

Other projects that wish to use the library should import this pom into the 
dependencyManagement section of their pom.


POM files are more than just dependnecies   For example..organization and licenses,
the URL of where the project lives, the project's dependencies, plugins prorfiles
and many such things...It also controls the completes build processes 
of the project....



A note about Manual Dependency Installation...
===================================================
Ideally we will want to pull dependencines into our projects
from public repositories or from our enterprise repo manager.
HOwever there will be times when we will need an archive available in
our local repo so that we can continue our development.





















