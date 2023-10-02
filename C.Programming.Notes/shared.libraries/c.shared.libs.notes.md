(source)[https://www.cprogramming.com/tutorial/shared-libraries-linux-gcc.html]



Shared libraries with GCC on Linux
-> Most larger software projects will contain sveral components
-> You will probably want to use some of the more generic in function logic in other programs(like I/O, networking, graphics, math...etc)
-> The advantage of this is that you have tested logic that you can use over and over again in different programs that don't require you to continue compilinging this logic over and over again for each program.
-> I feel also this allows for patching or updating software that only requires the recompilation of the shared libraries




Building static libraries is fairly simple, and since we rarely get questions on them , I will not cover them here.
I will stick with shared libraries, which seem tobe more confusing for most people


Before we get started, it might help to get quick rundown of everythign that happens from source code to running program:
1. C Preporsessor
    -> processes all the preporcessor directives 
2. Compilation Proper
    -> compiles source files to object files 
    -> *.c  compiles to *.o (or *.so) files 
3. Linking
    -> All object files are linked together to create binaries
    -> static library object files are included in the final binary
    -> dynamic library object files are not included in the final binary, only a references to the functions and variables within the dynamic library are included in the final binary's  symbol table along with the actual location of the shared objects
4. Loading 
    -> This stage happens when your program starts up.  Your program is scanned for referneces to shared libraries.  Any referneces found are resolved and the libraries are mapped into your program



## our source code:
    //foo.h
    #ifndef foo_h__
    #define foo_h__
    
    extern void foo(void);
    
    #endif  // foo_h__
    ##foo.c:
-------------------------------------------------------------
    #include <stdio.h>
        //foo.c
        void foo(void)
        {
            puts("Hello, I am a shared library");
        }
-------------------------------------------------------------
    //main.c:
    #include <stdio.h>
    #include "foo.h"   
    int main(void)
    {
        puts("This is a shared library test...");
        foo();
        return 0;
    }



## Step 1 :  Compiling with Position Independent Code (PIC)
We need to compile our library source code into position independent code 
> gcc -c -Wall -Werror  foo.c 


## Step 2: Creating a shared library from an object file 
> gcc -shared -Wall libfoo.so foo.o 

## Step 3: Linking the shared libs with our final binary executable (we are naming it "driver")
// -L switch tells the compiler where to look 
// -l switch tellthe compiler what I am looking for
> echo $LD_LIBRARY_PATH # your binary needs to know where to load the shared objects
> LD_LIBRARY_PATH=/home/username/foo:$LD_LIBRARY_PATH
> $LIB_LOC=/path/to/lib/object/files
> $LIB_NAME=foo #always leave the 'lib' prefix off
> gcc -Wall -L. -lfoo -o driver main.c
>  #-OR- 
> gcc -Wall -L$LIB_LOC -l$LIB_NAME -o driver main.c

## Step 3.1  We really should'nt be using $LD_LIBRARY_PATH for Loading

We really shouldn't for anything but quick tests.  Other application may be 
depending on this system variable and we might cause problems for ourselves and other
programs with prolonged use.  If you go on to regularly use this variable...make sure you always clear it


### Using rpath
-> rpath (run path) is a way of 
embedding the location of shared libraries in the executable itself
-> is used during linking
-> there are downsides of using rpath
    --> required shared libraries to be set in a fixed place
    --> if your shared libraries are located on a shared directory like a NFS or SMBS
    share, your program may experience unpredictable delays

//building with rpath 

> #compiling  
> gcc -c -Wall -Werror foo.h  -o foo
> #Sharing 
> gcc -shared -Wall libfoo.so foo.o
> #Let's clear $LD_LIBRAY_PATH to ensure that rapth won't be overruled or ignored
> unset LD_LIBRARY_PATH
> #Let's now link using rapth. Assume *.so path is working directory, and
> #our executible is named 'driver'
> gcc -Wall -c -L. -lfoo -rpath=.  -o driver driver main.c   