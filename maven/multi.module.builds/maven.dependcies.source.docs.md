url: https://howtodoinjava.com/maven/maven-dependency-management/

Introduction to the Dependency Mechanism
======================================================
Dependency managment is a core feature of Maven.
Managing dependencies for a single project is easy.
Managing dependences for multi-module projects and applications that consist


Transitive Dependencies
===================================================================
A transitive dependency in maven refers to situations where if

A depends on B,
B depends on C,
Then A depends on both  B and C.

Transivity brings a very serious problem
when different versions of the same artifacts are 
included by different dependencies.  It may cause
version mismatch issue in runtime.


Dependency Scope
=====================================================================
there are 6 scopes available:

	*compile
	    -This is the devault scope, used if none is specified.  Compile dependencies
	     that are available in all classpaths of a project.
             Furthermore, those depenendies are propagated to dependent projects.
	*provided
	    -This is much like compile, but indidcates you expect the JDK or a container
             to provide the dependency at runtime.
             For exmaple, when building a web app for JEE, you would set the dependency on
             the Servlet API and related Java EE APIs to scope 

             <provided>

            because the web container provides those classes.  This scope is only
            available on teh compilation and test calsspath, and IS NOT transitive...
	*runtime:
            -This scope indicates that the dependency is not required for compilation,
             but is for execution.  It is in the runtime and test classpaths, but
             not the compile classpath.
	     Note --> there are apparently more than one classpath....
                 1. compile (default) classpath
                 2. runtime classpath
                 3. test classpath
	

	*test
            -This scope indicates that the dependnecy is not required for normal use.
             of the application, and is only available for the test complication
             and execution phases.  This scope os not transitive.
	*system
            -This scope is similar to <provided> except that you have to provide the
             JAR which contains it explicitly.  The artifact is always available and
             looked up in a respository.
	*import
            -This scope is only supported on a dependency of type 
                 
                 <type>pom</type>
               
              in the section

		 <dependencyManagement>....</dependencyManagement>

              it indicates the dependency to be replaced withthe effective list of 
              dependencies in the specified POM's
              
             
Dependency Management
========================================================================================
The dependency management section is a mechanism for centralizing dependency  information.
When you have a set of projects that inherit from a common parent, it is possible to put all information about the dependency in the common POM  and have
simpler references to the artifacts in teh child POMs.  The mechanism is best illustrated
through some examples. Given these two POMs which extend the same parent.



Project-A with stand alone POM:

    <project>
      ...
      <dependencies>
        <dependency>
          <groupId>group-a</groupId>
          <artifactId>artifact-a</artifactId>
          <version>1.0</version>
          <exclusions>
            <exclusion>
              <groupId>group-c</groupId>
              <artifactId>excluded-artifact</artifactId>
            </exclusion>
          </exclusions>
        </dependency>
        <dependency>
          <groupId>group-a</groupId>
          <artifactId>artifact-b</artifactId>
          <version>1.0</version>
          <type>bar</type>
          <scope>runtime</scope>
        </dependency>
      </dependencies>
    </project>


Project-B:

    <project>
      ...
      <dependencies>
        <dependency>
          <groupId>group-c</groupId>
          <artifactId>artifact-b</artifactId>
          <version>1.0</version>
          <type>war</type>
          <scope>runtime</scope>
        </dependency>
        <dependency>
          <groupId>group-a</groupId>
          <artifactId>artifact-b</artifactId>
          <version>1.0</version>
          <type>bar</type>
          <scope>runtime</scope>
        </dependency>
      </dependencies>
    </project>

Now...let's introduce the idea of parent projects...
===========================================================================
Parent POM:

    <project>
      ...
      <dependencyManagement>
        <dependencies>
          <dependency>
            <groupId>group-a</groupId>
            <artifactId>artifact-a</artifactId>
            <version>1.0</version>
     
            <exclusions>
              <exclusion>
                <groupId>group-c</groupId>
                <artifactId>excluded-artifact</artifactId>
              </exclusion>
            </exclusions>
     
          </dependency>
     
          <dependency>
            <groupId>group-c</groupId>
            <artifactId>artifact-b</artifactId>
            <version>1.0</version>
            <type>war</type>
            <scope>runtime</scope>
          </dependency>
     
          <dependency>
            <groupId>group-a</groupId>
            <artifactId>artifact-b</artifactId>
            <version>1.0</version>
            <type>bar</type>
            <scope>runtime</scope>
          </dependency>
        </dependencies>
      </dependencyManagement>
    </project>


Project-A referencing Parent POM:

    <project>
      ...
      <dependencies>
        <dependency>
          <groupId>group-a</groupId>
          <artifactId>artifact-a</artifactId>
        </dependency>
     
        <dependency>
          <groupId>group-a</groupId>
          <artifactId>artifact-b</artifactId>
          <!-- This is not a jar dependency, so we must specify type if it isn't
           in fact a jar dependency... -->
          <type>bar</type>
        </dependency>
      </dependencies>
    </project>


Project-B referencing Parent POM:

    <project>
      ...
      <dependencies>
        <dependency>
          <groupId>group-c</groupId>
          <artifactId>artifact-b</artifactId>
          <!-- This is not a jar dependency, so we must specify type if it isn't
          in fact a jar dependency-->
          <type>war</type>
        </dependency>
     
        <dependency>
          <groupId>group-a</groupId>
          <artifactId>artifact-b</artifactId>
          <!-- This is not a jar dependency, so we must specify type. -->
          <type>bar</type>
        </dependency>
      </dependencies>
    </project>



A second, and very important use of the dependency management section is to control the versions of artifacts used in transitive dependencies.  As an example consider these projects...

As an example consider these projects:

Project A:
    <project>
     <modelVersion>4.0.0</modelVersion>
     <groupId>maven</groupId>
     <artifactId>A</artifactId>
     <packaging>pom</packaging>
     <name>A</name>
     <version>1.0</version>
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
         <dependency>
           <groupId>test</groupId>
           <artifactId>d</artifactId>
           <version>1.2</version>
         </dependency>
       </dependencies>
     </dependencyManagement>
    </project>


Project B:

    <project>
      <parent>
        <artifactId>A</artifactId>
        <groupId>maven</groupId>
        <version>1.0</version>
      </parent>
      <modelVersion>4.0.0</modelVersion>
      <groupId>maven</groupId>
      <artifactId>B</artifactId>
      <packaging>pom</packaging>
      <name>B</name>
      <version>1.0</version>
     
      <dependencyManagement>
        <dependencies>
          <dependency>
            <groupId>test</groupId>
            <artifactId>d</artifactId>
            <version>1.0</version>
          </dependency>
        </dependencies>
      </dependencyManagement>
     
      <dependencies>
        <dependency>
          <groupId>test</groupId>
          <artifactId>a</artifactId>
          <version>1.0</version>
          <scope>runtime</scope>
        </dependency>
        <dependency>
          <groupId>test</groupId>
          <artifactId>c</artifactId>
          <scope>runtime</scope>
        </dependency>
      </dependencies>
    </project>

When maven is run on project B; version 1.0 of artifacts a,b,c and d
will be used regardless of the version specifed in their bom


	* a and c both are on project , declared as dependencies of the project so 
          so version 2.0 is used due to dependency mediation
        * b is defined in B's parent's dependency management section and since dependency 
          management takes precdence over dependency mediation for transitiv dependences,
          version 1.0 will be selected should it be reverenced  in a or c's pom.  b will
          also have comple scope.








Importing Dependencies
===================================================================
The examples in the previous section describe how to specify managed
dependencies through inheritance...however, in larger projects it may be
impossible to accomplish this since a project can only inherit from a single parent.

To mitigate this, projects can import managed dependencies form other projects.
This is accomplished by declaring a pom accomplished by delaring a pom
artifact as a dependeny with a scope of "import"


Project B:
=====================================================================
    <project>
      <modelVersion>4.0.0</modelVersion>
      <groupId>maven</groupId>
      <artifactId>B</artifactId>
      <packaging>pom</packaging>
      <name>B</name>
      <version>1.0</version>
     
      <dependencyManagement>
        <dependencies>
          <dependency>
            <groupId>maven</groupId>
            <artifactId>A</artifactId>
            <version>1.0</version>
            <type>pom</type>
            <scope>import</scope>
          </dependency>
          <dependency>
            <groupId>test</groupId>
            <artifactId>d</artifactId>
            <version>1.0</version>
          </dependency>
        </dependencies>
      </dependencyManagement>
     
      <dependencies>
        <dependency>
          <groupId>test</groupId>
          <artifactId>a</artifactId>
          <version>1.0</version>
          <scope>runtime</scope>
        </dependency>
        <dependency>
          <groupId>test</groupId>
          <artifactId>c</artifactId>
          <scope>runtime</scope>
        </dependency>
      </dependencies>
    </project>


Assuming A is the pom defined in teh preceding example,the end result would be the same.
All of A's managed dependencies would be incorporated int B execpt for d since  
it is defined in this pom.




Project-X
    <project>
     <modelVersion>4.0.0</modelVersion>
     <groupId>maven</groupId>
     <artifactId>X</artifactId>
     <packaging>pom</packaging>
     <name>X</name>
     <version>1.0</version>
     
     <dependencyManagement>
       <dependencies>
         <dependency>
           <groupId>test</groupId>
           <artifactId>a</artifactId>
           <version>1.1</version>
         </dependency>
         <dependency>
           <groupId>test</groupId>
           <artifactId>b</artifactId>
           <version>1.0</version>
           <scope>compile</scope>
         </dependency>
       </dependencies>
     </dependencyManagement>
    </project>


Project-Y

    <project>
     <modelVersion>4.0.0</modelVersion>
     <groupId>maven</groupId>
     <artifactId>Y</artifactId>
     <packaging>pom</packaging>
     <name>Y</name>
     <version>1.0</version>
     
     <dependencyManagement>
       <dependencies>
         <dependency>
           <groupId>test</groupId>
           <artifactId>a</artifactId>
           <version>1.2</version>
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

Project-Z

    <project>
      <modelVersion>4.0.0</modelVersion>
      <groupId>maven</groupId>
      <artifactId>Z</artifactId>
      <packaging>pom</packaging>
      <name>Z</name>
      <version>1.0</version>
     
      <dependencyManagement>
        <dependencies>
          <dependency>
            <groupId>maven</groupId>
            <artifactId>X</artifactId>
            <version>1.0</version>
            <type>pom</type>
            <scope>import</scope>
          </dependency>
          <dependency>
            <groupId>maven</groupId>
            <artifactId>Y</artifactId>
            <version>1.0</version>
            <type>pom</type>
            <scope>import</scope>
          </dependency>
        </dependencies>
      </dependencyManagement>
    </project>


In the example above Z imports the maanaged dependencies from both X and Y.  However
, both X and Y contain dependency a.  Here, version 1.1 of a would be used since X is declared first X is decleared first and a is not declared in Z's <dependencyManagement>


This process is recursive.  For example, if X imports another pom, Q, when Z is procesed it 
will simply appear that all of Q's managed dependencies are defined in X

Imports are most effective when used for defining a "library" of related artifacts
that are genearlly part of a multiproject build.  It is fairly common
for one project to sue one or more artifacts that are generally  part of a multiproject
build.  It is fairly common for one project to use one or more artifacts from these
libraries.  However, it has sometimes been difficult to keep the versions in the project using the artifacts in synch with the versions distributed in the library.  The
pattern below illustrates how a "bill of materials" (BOM) can be created for use by 
other projects.


The root of the project is the BOM pom.  It defines the versions of all the 
artifacts that will be created in the library.  Other projects that wish to use
the library should import this pom into the <dependencyManagement> section of their pom.


<modelVersion>4.0.0</modelVersion>
  <groupId>com.test</groupId>
  <artifactId>bom</artifactId>
  <version>1.0.0</version>
  <packaging>pom</packaging>
  <properties>
    <project1Version>1.0.0</project1Version>
    <project2Version>1.0.0</project2Version>
  </properties>
 
  <dependencyManagement>
    <dependencies>
      <dependency>
        <groupId>com.test</groupId>
        <artifactId>project1</artifactId>
        <version>${project1Version}</version>
      </dependency>
      <dependency>
        <groupId>com.test</groupId>
        <artifactId>project2</artifactId>
        <version>${project2Version}</version>
      </dependency>
    </dependencies>
  </dependencyManagement>
 
  <modules>
    <module>parent</module>
  </modules>
</project>



The parent subproject below has the above project's  BOM pom as it's parent.  It is a normal multiproject pom.


    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
      <modelVersion>4.0.0</modelVersion>
      <parent>
        <groupId>com.test</groupId>
        <version>1.0.0</version>
        <artifactId>bom</artifactId>
      </parent>
     
      <groupId>com.test</groupId>
      <artifactId>parent</artifactId>
      <version>1.0.0</version>
      <packaging>pom</packaging>
     
      <dependencyManagement>
        <dependencies>
          <dependency>
            <groupId>log4j</groupId>
            <artifactId>log4j</artifactId>
            <version>1.2.12</version>
          </dependency>
          <dependency>
            <groupId>commons-logging</groupId>
            <artifactId>commons-logging</artifactId>
            <version>1.1.1</version>
          </dependency>
        </dependencies>
      </dependencyManagement>
      <modules>
        <module>project1</module>
        <module>project2</module>
      </modules>
    </project>



Next are the actual project poms


Project-1
    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
      <modelVersion>4.0.0</modelVersion>
      <parent>
        <groupId>com.test</groupId>
        <version>1.0.0</version>
        <artifactId>parent</artifactId>
      </parent>
      <groupId>com.test</groupId>
      <artifactId>project1</artifactId>
      <version>${project1Version}</version>
      <packaging>jar</packaging>
     
      <dependencies>
        <dependency>
          <groupId>log4j</groupId>
          <artifactId>log4j</artifactId>
        </dependency>
      </dependencies>
    </project>
     
    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
      <modelVersion>4.0.0</modelVersion>
      <parent>
        <groupId>com.test</groupId>
        <version>1.0.0</version>
        <artifactId>parent</artifactId>
      </parent>
      <groupId>com.test</groupId>
      <artifactId>project2</artifactId>
      <version>${project2Version}</version>
      <packaging>jar</packaging>
     
      <dependencies>
        <dependency>
          <groupId>commons-logging</groupId>
          <artifactId>commons-logging</artifactId>
        </dependency>
      </dependencies>
    </project>


This following project shows how the library can now be used in another project without
having to specify the dependent project's versions...

    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
      <modelVersion>4.0.0</modelVersion>
      <groupId>com.test</groupId>
      <artifactId>use</artifactId>
      <version>1.0.0</version>
      <packaging>jar</packaging>
     
      <dependencyManagement>
        <dependencies>
          <dependency>
            <groupId>com.test</groupId>
            <artifactId>bom</artifactId>
            <version>1.0.0</version>
            <type>pom</type>
            <scope>import</scope>
          </dependency>
        </dependencies>
      </dependencyManagement>
      <dependencies>
        <dependency>
          <groupId>com.test</groupId>
          <artifactId>project1</artifactId>
        </dependency>
        <dependency>
          <groupId>com.test</groupId>
          <artifactId>project2</artifactId>
        </dependency>
      </dependencies>
    </project>



Finally, when creating projects that import dependencies beware of the following:

*    Do not attempt to import a pom that is defined in a submodule of the current pom
     Attempting to do that will result in a build fail since it won't be able to locate
     the pom.

*    Never delcare the pom importing a pom as the parent(or grandparent,etc) of the target
     pom.  There is no way to resolve the circular referencing and an exception will be
     thrown.

*    When referring to artifacts whose poms have transitive dependencies the project
     will need to specify versions of those artifacts as managed dependencies.  Not
     doing so will result in a build vailure since the artifact may not have a version
     specified.








