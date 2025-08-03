# Creating a Build 


- Building with CMake is a two-step build process that 
requires first running one or more CMake scrptsthat will generate a native build that is 
run to create the create the build targets 




- Cmake scripts of a build define :
    * targets
    * dependent sources and properties required for th ebuild 
    * The main.cpp source file referenced in the CMakeLists.txt contains the following HelloWorld code 

    # CMakeLists.txt


    cmake_minimum_required(VERSION 2.8)

    project(helloworld CXX)

    set(CMAKE_BUILD_TYPE 
        "Release"
        "Build Type")

    add_executable("HelloWorld main.cpp")


    // main.cpp



        #include <iostream>
        int main()
        {
            std::cout<<"Hello World"<<std::endl ;
            return 0 ;
        }



The `set` command sets the value of a variable that can then ba accessed by ${VARIABLE_NAME}

When we run cmake :


    > cmake .
    CMake Deprecation Warning at CMakeLists.txt:1 (cmake_minimum_required):
    Compatibility with CMake < 3.5 will be removed from a future version of
    CMake.

    Update the VERSION argument <min> value or use a ...<max> suffix to tell
    CMake that the project does not need compatibility with older versions.


    -- Configuring done (0.0s)
    -- Generating done (0.0s)
    -- Build files have been written to: /Users/mikeyb/src/cpp/lab/build_tools/_cmake_/bar



Ok...great....now we have our build set up nice and tidy....in a neat little package.  Now let's actually run the build 


    > make
    make
    [ 50%] Building CXX object CMakeFiles/HelloWorld.dir/main.cpp.o
    [100%] Linking CXX executable HelloWorld
    [100%] Built target HelloWorld


Now we should have an executable object file to run :

    > ./HelloWorld
    Hello World



## Variables 

- Variables are useful in the CMake language to maintain certain values 
in a build in  addition to important built-in variables of CMake.

The twor  most important built-in variables are 

     CMAKE_SOURCE_DIR

     CMAKE_BINARY_DIR

These two directories  represent the source directory and output build 
directory, repspectively, when cmake is generating build scripts


Cached binary variables that are set in the configure stage of running the CMake GUI are set with the "option" command 

It is typiclal to name the variables in all-caps


Comments in cmake are declared with a leading pound sign `#`


Let's give it a shot 


    #This build will work for CMake version 2.8 or higher

    cmake_minimum_required(VERSION 2.8)
    project(foobar CXX)
    set(CMAKE_BUILD_TYPE "Build Type")
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
    add_executable(HelloWorld main.cpp) #build HelloWorld.exe

    ---------------------------------------------------------------

    > cmake .
    CMake Deprecation Warning at CMakeLists.txt:3 (cmake_minimum_required):
    Compatibility with CMake < 3.5 will be removed from a future version of
    CMake.

    Update the VERSION argument <min> value or use a ...<max> suffix to tell
    CMake that the project does not need compatibility with older versions.


    -- Configuring done (0.0s)
    -- Generating done (0.0s)
    -- Build files have been written to: /Users/mikeyb/src/cpp/lab/build_tools/_cmake_/foobar


Ok....so we should be able to run make now to run our build 

    > make
    [ 50%] Building CXX object CMakeFiles/foobar.dir/main.cpp.o
    [100%] Linking CXX executable bin/foobar
    [100%] Built target foobar

Now we should be able to find our executable object file in /bin

    > tree ./bin

    ./bin
    └── foobar

    1 directory, 1 file


Now let's run our executable....

    > ./bin/foobar 
    FooBAR....Bitches!!!!!



