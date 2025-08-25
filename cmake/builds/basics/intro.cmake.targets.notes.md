[Introduction to the basics](https://cliutils.gitlab.io/modern-cmake/chapters/basics.html)




# Enviroment variables 
You can also 

    set(ENV{variable_name} value)


and get 

    $ENV{variable_name}

enviroment variables, though it is 
generally a very good idea to avoid them



## The Cache 

The cache is actually just a text file, 

    CMakeCache.txt 

This is how Cmake remembers anything you set, so you do't have to 
re-list your options everytime you rerun CMake.


## Properties 

The other way CMake stores information is in properties.  This is like a variable, but it is attached to some other item, like a directory or a target.  A global property can be usueful uncached global variable.
Many target properties are initialized from a matching variable with 
`CMAKE_` at the front.  So setting `CMAKE_CXX_STANDARD`, for examble, 
will mean that all new targets creted will have `CXX_STANDARD` set 
to that when they are created.  There are two 
ways to set properties 



set_propert(TARGET target_name PROPERTY CXX_STANDARD 11)


    -- SUMMARY OF PROPERTIES --
    Properties in CMAKE are variables with the added feature that
    they are tied to some real world resource:

        directories
        targets 
        etc
    Properties  are initialized from a matching variable with 

        CMAKE_

    at the front.   So setting CMAKE_CXX_STANDARD for example 
    will mean that all new targets created will have CXX_STANDARD set 
    to this value when created 
    


## Wait...what are CMAKE targets ?


Targets in Cmake are the fundamental building blocks that represent the different
components of a software project.  They are logical entities that encapsulate the 
instructions for beuilding specific outputs :

    executables
    libraries 
    custome commands

From StackOverflow : 

"A `Target` is a name for something to do : execute, build or create, depending on the target.
Typically, target names represent an executable file or library file

The term `target` is older than CMake as it comes from the `make`command.   `make` takes
target names as arguments and builds them using rules that specify what to do to create a specific 
target/file.  In `make` a `target` is just a path to a file to produce, for example an actual 
executable name.

The build system generate by CMake "updates a target" (executes the commands needed to build
the executable file or library file) when the perequisite files have been modified since the the
target was last modified or the target does not exist( "the target" = the file that is the result of building the target.)

Targets can be part of a project (in which case they have source files and need to be built as prt of the 
build system), or `IMPORTED` in which case they laready exist in binary form and have no sources and do not need to be built (they were already built outside the buildsystem to be generated for a project)

Targets can have dependencies between them.   For exmple, An executable target depending on a library target to use its functions and data.  For more info on this see [the docs for target dependencies](https://cmake.org/cmake/help/latest/command/add_dependencies.html), which can have implications for linking binaries together, and for build order: making sure dependent targets are re-built (if needed- which is not always the case, for example non-interface changes to shared libraries) when depended-upon targets need to be rebuilt.

There are some target types which are not `IMPORTED` which also have nothign to build (for example, [interface libraries](https://cmake.org/cmake/help/latest/command/add_library.html#interface-libraries)  and other types you can read about in the `add_library` does, but those 
are a more advanced feature"



Key characteristics of CMake targets :

* Represents build artifacts:  
    - Executables:
        * Created using :
            add_exectuable()
        * These are standalone programs
    - Libraries:
        * Created using :
            add_library()
        * these can be :
            static libraries
            shared object/libraries
            Interface Libraries
            module libraries
    -  Custom targets
        * Created using :
            add_custom_target()
        * These define arbritrary commands to be executed, often for tasks like:
            - running tests,
            - gerating documentaion 
            - deploying files 


* Encapsulate properties
    - Each target has associated properties that efine it's characteristics and how it should be built
    - These properties can include 
        * source files
        * include directories
        * linked libraries
        * compile options
        * etc
    - Commands like :
         set_target_properties()
         get_target_property()
    are used to manage these 

* Define dependencies
    - Targets can declare dependencies on other targets
    - target-A declaring a dependency on target-B ensures that the build system 
    generates the correct build order, allowing CMake to automatically manage the compilation build 
    compilation adn linking order of different components within a project
* Facilitate modularity and resuability 
    - Clearly defined targets allows CMake to promote a modular project structure, where components
    can be independently built and reused across different parts of the project or even in other projects
* Provide a high-level abstraction 
    - Cmake targets offer a higher level of abstration compared to directly managing compiler and linker commands.  This allowd developers to focust on teh logical structre of their project rather than low-level build detaisl.

