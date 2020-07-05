What are Macros in Rust ?
__url:https://medium.com/@phoomparin/a-beginners-guide-to-rust-macros-5c75594498f1__
==================================================

	println!("Yo {}!", name)



If you have already tried out Rust, you shol have already used a macro before,
	__println!__

This macro allows you to print a line of text with the ability to
interpolate variables in the text string.



Macros simply allows you to invent your own syntax and write code that
writes more code.


This is called metaprogramming, which allows for syntactic sugars that
make your code shorter and make it easier to use your libraries.  You 
could even crete your own DSL(Domain-Specific Language) within rust.


Macros works by matching against teh specific pattern sdefined in the 
macro rule, capturing part of the match as variales, then exapnd to
produce enve more code.




How do we create a Macros ?
===================================

We can create macros by using the **macro_rules!**
macro.  Macroception!


	//syntax
	macro_rules! hey{
	    () => {}
	}


Breakdown:

	matcher ()
     
	transcriber {}

	() => {}


This is an etry for the macro rule, which we can haven many rules
to match for in a single macro, which we can have many rules
to macth for a single macro.  It is very similar to pattern matching, 
where we can also have many cases, deliminted by the use of commas.


	()       =>      {}
	Matcher	         Transcriber


The curly braces part is the transcriber, which is where we can 
make use of the variables we captured fromt eh matcher


Matching and Capturing Patterns
============================================

($name:expr) => {
    print!("Hey {}", $name)
}



Our first Macro!
===========================================
	macro_rules! yo{
	    ($name:expr) => {
		println!("Yo {}!", $name);
	    };
	}


	fn main() {
	   yo!("Foo Bar")
	}



Repetitions
===============================================
Many of the macros we know an love can take lots of input at
once.  Take the vec! macro as an example' we can create a 
Vector with items in it by invoking the vec! macro like
so:  __vec![1,2,3,4,5]__


how es vec! do that?

	**($($x:exper),*)**



The star (*) will repeat patterns inside the $(...)
The comma(,) is now a separator.








