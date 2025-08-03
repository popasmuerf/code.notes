# Executable Target 


- A library target is added to a build using the command 

    add_library

which takes several forms.  The typical `add_library` form 
includes these arguments:

    library
    library type
    one or more dependent source files





    cmake_minimum_required(VERSION 2.8)
    project(alpha CXX)
    set(CMAKE_BUILD_TYPE "Build Type")
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
    add_executable(foobar main.cpp) #build foobar.exe





