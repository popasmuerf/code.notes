Unrecoverable Errors with panic!
==============================================================
Sometimes, bad things happen in your code, and whtere is nothing
you can do about it.  IN these cases, Rust has the
"panic!" macro

	panic!

When the panic! macro executes, your program will print a failure messge,
unwind and clean up the stack,and then quite.

The most commonly occurs when a bug of some kind has been
deteced and it is not clear for the programmer how to handle the 
error.


Unwinding the stack or aborting in response to a Panic
===============================================================
By default, when a panic occurs, the program starts unwinding, which
means Rust walks back up the stack and cleans up the data from eaach
function it encounters.

This walk back and cleanup is a lot of work.

Mayber a better plan is to immediately "abort", which ends
the program without cleaning up.  As always the OS is responsible
for the clean up of program memory , then if your binary is particularly
small, then it makes sense for you to switch from unwinding to
aborting upon a panic via  the following:

panic = 'abort'

tothe appropiate [profile] sections in your
Cargo.toml file.

	[profile.release]
	panic = 'abort'



Using a panic! Backtrace
=================================================================
Let's look at another example to see what it is like when a panic! call comes from 
a library becuae of a bug in our code instead of from our code calling the
macro directly.


	fn main(){
	    let v = vec![1,2,3];
	    v[99] ;
	}



Here we are attempting to access the 100th element of our vector(which is at index((
because indexing starts at zero), but it has only 3 elements. in this situation, 
Rust will panic.  Using [] is 
supposed to return an element, but if you pass an invalid index, there is 
no element that Rust cold return here that would the correct.


In C, attempting to read beyond the end of a data structure is undefined
behavior.  You might get whatever is at the location in memory that wold correspond to that element in the data structre, even though them memory doesn't belong to that structure.
This is called a buffer overread and can lead to security vulnerabilities if an attacker is able to manipulate the index in such a way as to read data
they sholdn't be allowed to that is stored after the data structure.


RUST_BACKTRACE
======================================================================
We can set the "RUST_BACKTRACE" enviromen variable to get a backtrace of exactly what happened to cause the error.  A backtrace is a list of all the functions that
have been called to to this point.  Backtrackes in Rust work as the do in other 
languages:  the key to reading the  backtrace is to start from the top and read until you see files you wrote.  That is the spot whre the problem originate.  The lines above
the lines mentinoing your files are code that your code called' th elines below are cod that called your code...these line will likely include core Rust code, standard library code, or creates that you are using.


	> RUST_BACKTRACE=1 cargo run

