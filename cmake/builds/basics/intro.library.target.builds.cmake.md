
# Library Target 

A library target is added to a build using the command, which 
takes several form.

The typical `add_library` form includes these arguments:
    * name of library
    * library type
    * dependent source file(s)

    * First form of add_library
    
        add_library(<name>  [STATIC | SHARED | MODULE] src1 src2 src3 ......  )

    --------------------------------------------------------------------------
    #CMakeList.txt
    cmake_minimum_required(VERSION 2.8)
    project(beta CXX)
    set(CMAKE_BUILD_TYPE "Build Type")
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
    add_library(libbeta libbeta.cpp) 



There is a seconde form of add_library that allows 
CMake to reference external libraries alredy built on the 
system, such as system libraries.  This Imported library fule does not 
generate any build commands .

       * Second form of add_library
    
        add_library(<name>  [STATIC | SHARED | MODULE] src1 src2 src3 ......  )


    ----------------------------------------------------------------------------

    add_library(ssl SHARED IMPORTED)


the above statement shows how to reference the ssl library and the additional step 
of defining where the ssl library is located on a Mac.
The IMPORT_LOCATION propery supplies a custom library location to find the ssl target.




IMPORTED_LOCATION  property supplies a custom library 



    cmake_minimum_required(VERSION 2.8)
    project(helloworld CXX)
    set(CMAKE_BUILD_TYPE "Release" "Build Type")
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}.lib)
    add_library(ssl SHARED IMPORTED)
    set_property(
        TARGET ssl
        PROPERTY
        IMPORTED_LOCATION /user/lib/libssl.dylib)
    add_executable(HelloWorld main.cpp)
    target_link_libraries(HelloWorld ssl)
