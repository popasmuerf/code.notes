

--crate-type=bin, #![crate_type = "bin"]

* Runnable executable will be produced
* source file must contain a main function
* links all rust and native dependencies
* is a single distributable binary
* default crate type

--crate-type=lib, #![crate_type = "lib"]

* Rust lib will be produced
* The exact nature of the produced lib is 
abiguous w/r to what exactly is produced 
as the library can manifest itself in several forms
* output lib will always be usable by rustc 
* actual type of the library can be changed 
from time-to-time.
* output 
    > ???




--crate-type=dylib, #![crate_type = "dylib"]

* Dynamic lib is produced 
* different from lib ouptut type in that this forces dynamic libray generations
* dylibs can be used as a dependency for aother libraries and 
executables.
* output 
    > *.so 


--crate-type=staticlib, #![crate_type = "staticlib"]
* Static lib will be produced
* compiler will never attept to link this lib
* contains all the local crate's code along with all upstream dependencies.

* output
    > *.a (*nix)
    > *.lib(Windows, MVSC, MinGW)


--crate-type=cdylibib, #![crate_type = "cdylib"]

* Dynamic lib is produced 
* used over =dylib whenever there is a use-case for producing 
dynamic libraries in Rust that are to be linked to by other programs written
in other programming languages 

* dylibs can be used as a dependency for aother libraries and 
executables.
* output 
    > *.so (linux)
    > *.dylib (MacOS)
    > *.dll (Windows)

--crate-type=rlib, #![crate_type = "rlib"]
 * A rust specfic library will be produced.
 * intermediate artifiact and can be thought of as a kind of 
 "static library"
 * are interpreted by the compiler in future linkage unlike
 typical *.a files



--crate-type=proc-macro, #![crate_type = "proc-macro"]
    * The output produced is not specified, 
    but it a -L path is provided to it the the compiler will
    recognize the output artifiats as a macro 
    thatcan be loaded for a program.

    * this crate type will only be exported as procedural macros.



Current startegy of the compiler : depending on teh outuput 
format 

(--crate-format= rlib,dylib,staticliv,library)

decises o the best linking type with yor influence via flags 

The output cannot statically link the same library twice 