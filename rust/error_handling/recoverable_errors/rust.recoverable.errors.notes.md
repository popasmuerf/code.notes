Revoverable Errors with "Result"
==================================================
Most errors arent' serious enough t require the program to stop entirely.
Sometimes, when a function fails, it is for a reason that you can
easily interpet and respond to.  For example, attempting to open a file and that
operation fails because the file doesn't exist, you might want to create the file
instead of terminating the process....


The Result Enum
=====================================
The Result Enumeration has to variants..
"Ok" and "Err" as follows:


	enum Result<T,E>{
	    Ok(T),
	    Err(E),
	}





Teh T and E parameter are generic type paramters: we will disucss generics in
more detail in Chapter 1-.  What you need to know right now is that
T represents the type of the error and that will be returned in a faiilr  case.



What if we wanted to open a file that didn't exist ?
------------------------------------------------------------

	use std::fs::File ;

	fn main(){
		let f = File::open("foo.bar") ; //panic("There ain't no file named FOOBAR MAN!!!!!")!
	}





