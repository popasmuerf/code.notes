What is Ownership ?
====================================================
Rust's central feature is ownership....it is a simple, yet
has deep implications...



All programs hae to manage the way they use a computer's memory while
running.  Some languages have garbage collection that constantly
looks fo rno longer used memory as the program runs; in other languages,
the programmer must explicitly allocate and free the memory.
Rust uses a thir option...memory is managed through a system of 
ownership with a set of rules that the compiler checks at 
at compile time.  




The Stack and The Heap

=============================================================


In many progamming languages, you dont have to think about the stack
and the heap very often.  But in a systems programming language
like Rust, whether a value is on the stack or the heap has more 
of an effect on how the language behaes and why you have to make certain
decisions.  Parts of ownership will be described in relation to the
stack and heap later in this chapter



Both the stack and the heap are parts of memory that are available
to your code to use at runtime, but they are structured in different ways.

The stack stores values in the order  it gets them and removes
the values in the opposite order.

This is referred to as last in, first out.


All data stored on the tack must have a known...fixed size.
Data with a unknown size at compile time or a size that might
change must be stored on the heap instead


The heap is less organized" when yu put data on the heap, you request
a certain amount of space.  The operating system finds a spot in 
the heap that is big enough, marks it as being in use, and returns 
a poiner, which is the address of tha tlocation.

This is known as "allocating on the heap" and is sometimes abbreviated
as just "allocation"

Pushing values onto the stack is not considered allocating.  Because the 
pointer is known, fixed size, you can store the pointer on the
the stack, but when you want the atual data, you must follow th pointer.


Pushing to the stack is faster than allocating on the heap because the
operationg sytem never has to search for a place to store new data'
that location is always at the top of the stack.  Comparatively, allocationg
space on the heap requires more work, beause the operating
system must first find a big enough space to hold the data and then perform bookkeeping
to prepare for the next allocation.



Accessing data in heap is slower than accessing data on teh stack
because you ahvet to follow a pointer to get there.  Contemporary
processors are faster if they jump around less  memory.



When your code calls a function, the values passed into the function
(including, potentially, pointers to data on the heap) and the function's
local variables get pushed onto the stack.

When the function is over, those values get popped off the stack

Keeping track of what parts of code are using what data on  the heap, minimizing he
amouint of duplicate data ont he heap, and cleaingin up unused data on the heap so you
don't run out of space are all problems that ownershp address.







Ownership Rules
======================================
First, let's take a look at the ownershp rules.  Keep these
rules in mind as we work through the examples that 
illustrate them:

*Each value in Rust has a variable that  is called it's "owner"
*There can only be one owner at a time
*When the owner goest out of scope, the value will be dropped.


Variable Scope
=============================================

The variable 's' refers to a string literal, where the value
of the string is hardcoded into the text of our program.
Teh variable is valid from teh point at which it is declared
until the end of the current scope.

	//is not valid here...it hasn't been declared yet

	{

	let s = "hello" ; //  s is valid from this point on...

	}

	//s is no longer valid..as it's owner is no longer within scope...


In other words, there are two important points in time here:

	*	When 's' comes into scope, it is valid
	*	It remains valid until it goes out of scope


The take away...
	*	While s is in scope..it is valid..
	*	When s goes out of scope..it is no longer valid...



The String Type
============================================
A few things...
	*	string literals are immutable...why?
		because their size is know at compile time..
		they are placed on to the stack...
		..and as such...they must be immutable so that their
		memory footprint doesn't change

	*	There is the String type that is allocated on the heap...
		As it is able to store an amount of text that is unknown
		to us at compile time.  Yu can create String from a 
		string literal using the following syntax...

		//Code

		let s = String::from("hello") ;



There is a natural point at which we can return the memory our String needs
to the operating system:  when s goes out of scope.  When a variable goes 
out of scope, Rust calls a special function for us.

This function is called 

	drop

and it is where the author of String can put the code to return
the memory.  rust calls drop() automatially at the closing 
of each and every curly bracket.


Note:  In C++, thi s pattern of deallocating resources at the end of an item's
lifetime is sometimes called Resource Acquisition is Initialization (RAII).
The drop function in Rust will be familiar to you if you have used the RAII 
patterns.


Ways Variables and Data Interact : Move
=========================================================
Multiple variables can interact with teh same data in different ways in 
Rust.  Let us look at an example using an integer in Listing 4-2

	let x = 5 ;
	let y = x ;


We can probably guess what this is doing...
"bind the value  5 to x ; then make a copy of the value in 
x and bind it to y."

We now have two variables, x and y, and both equal 5.

This is indeed what is happening, because integers are simple values with a known, fixed
size, and these two 5 values are pushed onto the tack 


Now let's look at the String versin:

let s1 = String::from("hello") ;
let s2 = s1 ;


A String object is made up of 3 attributes...
	*	Pointer to the first element 
	*	capacity
	*	length

All three of these values(meta) are stored on the stack
as they their total memory specifications are known 
at compile time....
	*	A pointer is a 4 byte int
	*	Capacity is a 4 byte int
	*	Length is a 4 byte int...

The actual data is stored on the heap....


Stack 	Val		Heap
-----	----		------
name			index  value
----	----		-------------
ptr 	---------------> 0	F
len      3		 1      o
capacity 3               2      0



When we make a copy of this String....which is bascially an array of characters...
we copy the following to a new owner...

	*	ptr
	*	len
	*	capacity...

So basically we would have a ptr that is owned by two variables(the copy because
everything is known at compile time...is also on the stack...The data on the 
heap is not copied....


We could make complete copies including the heap data....but that would make each
and very copy operation expensive...





This could be a problem....


If you have heard the terms "shallow copy" and "deep copy" while working with
other languages, the concept of copying the pointer, length , and capacity
without copying the data probably sounds like making a shallow copy...but
because Rust also invalidates the first variable, instead of being called a
shallow copy, it is known as a "move".  In this example, we would say that 
s1 was moved into s2.

Only s2 in this scenario is is valid as s1 as far as the compiler is concerned
is now out of scope in a manner of speaking as it is not valid...but the 
drop() funciton is not called on s1....does this mean that I can do things like
switch up owneship of a ptr at will ?

In additin, there's a design choice that is implied by this:  Rust will never
automatically create "deep" copies of your data.  Therefore, any automatic
copying can be assumed to be inexpensive in terms of runtime performance.



Ways Variables and Data Interact: Clone
------------------------------------------------------













