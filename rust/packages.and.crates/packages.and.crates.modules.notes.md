Packages and Crates
===================================================
What is a crate ?
-----------------------
	-	is either a binary or a library
	-	the crate root is a source file that the Rust compiler starts from
		and makes up the root module  of your crate

What is a package ?
----------------------
	-	must contain 0-1 libary crates
	-	can contain 0-N binary crates
	- 	must contain at least one crate 
	


url : https://doc.rust-lang.org/book/ch07-02-defining-modules-to-control-scope-and-privacy.html



Defining Modules to Control Scope and Privacy...
=======================================================
    -   The "use" keyword brings a path into scope
    -   The "pub" keyword to make items public
    -   



Modules
====================================================
    -   allow the organization of code within a crate
        into groups for readability and easy resuse.

    -   Modules also control the privacy of items, which is whether
        an item can be used by outside code(public)
        or is an internal implementation dtail and not available for
        outside use (private)


Writing a lib module that provides the features of a restaurant..
=================================================================
> cargo new  --lib restaurant

//code for src/lib.rs

mod front_of_house {
    mod hosting {
        fn add_to_waitlist(){} 
        fn seat_at_table(){}
    }
    mod serving{
        fn take_order(){}
        fn serve_order(){}
        fn take_payment(){}
    }
}


Cargo.toml
============================================================
When we entered the command, Cargo creates a Cargo.toml file, giving
us a package.

Looking at the contents of Cargo.toml, there's no mention of src/main.rs beause Cargo follows a convention that 
src/main.rs is the crate root of a binary crate with the same name as the package.  Cargo knows that if the package directory contains src/lib.rs, thepackage contains a library crate with the same
name as the package, and src/lib.rs is it's crate root

Cargo pass teh crate root files to rustc to buld the library or binary.



Defining Modules to Control Scope and Privacy
=============================================================
https://doc.rust-lang.org/book/ch07-02-defining-modules-to-control-scope-and-privacy.html
















