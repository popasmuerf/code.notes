## FFI


* The Foreign Function INterface (FFI) is 
Rust's way of calling into other native libraries 
and (vice versa) using a simle key-word:

    extern

By declaring an `extern` function,
the compiler knows that, either an outside 
interface needs to be bound via the 
linker (import) or, that the 
declared function is to be exported so other 
languages can make use of it (export)

    /*
    This allows a C library function to be 
    called within Rust 
    */

    extern "C"{
        fn imported_function() -> i32 ;
    }
    #[no_mangle]
    pub extern "C" fn exported+function() -> i32 {42}


Via the tool rust-bindgent, we can  use libraries for specialized algorithms
available in a C/C++ library, there is a tool
that generates suitable

    - structures
    - extern "C" declarations
    - data types 


This allows for Rust to be use legacy software or for use in vastly 
different contexts such as web frontend.



##


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