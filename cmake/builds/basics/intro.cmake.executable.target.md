# Executable Target 

And executable target is added to a build using the 

    add_executable


command.


The main arguments are the name of the executable and the dependent source files.


    add_executable(<name> src1 src2 ...)


The following example shows how to build a single executable target, `Alpha` that when 
created will add the appropiate extension for he native system 

The executable will be created in the `/bin` directory of the ouput build directory, presented
by ${CMAKE_BINARY_DIR}


    cmake_minimum_required(VERSION 2.8)
    project(alpha CXX)
    set(CMAKE_BUILD_TYPE "Build Type")
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
    add_executable(foobar main.cpp) #build foobar.exe





