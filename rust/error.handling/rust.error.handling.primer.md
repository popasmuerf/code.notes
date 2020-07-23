Error Handling
=============================================
One of Rust's major goals is enabling developers to write
robust software.  An essential component of this advanced
error handling.  In this section, we will take a deeper look at 
how Rust does error handling.  In this section, we will take a
deeper look at how Rust does error handlig.


But before that, let us take a detour and look 
at some type theory...



Some Type Theory.
=======================================================
Specifically, we are interested in algebraic data types(ADT),

1. Types are formed by combining other types.
2. The tow most commonADTS are sum and product types
3. A struct is a product type.
4. The range of it's type is essentially a  cartesian product 
   of the ranges of each of it's components, since an
   instance of the type has values for all of it's contituent types.


5. While similar to enums in C and other languages, Rust enums
   provide a number of enhancements:  They allow variants to 
   carry data.




Now back to error handling.  Rust mandates that operations which 
can result in an error must return a special enum that carries .
Conveniently, thi senum looks like this:


	//code

	enum Result<T, E>{
	   Ok(T),
	   Err(E),	
	}



The two possible oprtions are called variants.  In this case, they 
represtent the non-error case and the error case,
respectively  Not that this is ggnericaly  defined so that an
implementation is free to define the types in both cases.  this is
useful in appliations that want to expand on the standard error type and implement custom
errors.  Let us look at an example of this aion.



In th ecase where File::open succeeds, the value in the variable 'f' will
be an instance of 'Ok' that contains a file handle.  In the case where it fails,
the value in 'f' will be an instance of 'Err' that contains more information
about the kind of error that happened.

We need to add the code to take different actions depending on the valu e
File::open rturns.

	/* Using a match expression to handle the Result variants that might be returned  */
	use std::fs::File;

	fn main(){

	    let f = File::open("hello.txt") ;

	    let f = match f {
		Ok(file) => file,
		Err(error) => panic!("Problem opening the file : {:?} ", error) ;
	    }

	}


Note that, like the Option enum, the Result enum and it's variants have
been brought into scope by the prelude, so we don't need to specify
Result:: before the Ok and Err variants in the match arms(but let's do it anyway..)



	/* Using a match expression to handle the Result variants that might be returned  */
	use std::fs::File;

	fn main(){

	    let f = File::open("hello.txt") ;

	    let f = match f {
		Result::Ok(file) => file,
		Result::Err(error) => panic!("Problem opening the file : {:?} ", error) ;
	    }

	}



For this example, we define a function that simply returns the quotient
when the first operand is divided by the second.  This function must 
handle th eerror case when the divisor is zero.  We 
also want it to signal an error to its caller if that is the case.

Also, let's assume that this is a part of a library that will expand
to include more such operations.

For the Rust compiler to know that the enum is an error type, our enum has
to implement the Error trait from the standard library.


A related idiom in the standard library is the Option type, as
shown in the following code snippet.  This is used to inducate the
nullability of an operation, indicated by the None variant.
Some variant handles the case where it holds the actual value of the 
type T:

	pub enum Option<T>{

	    None,
	    Some(T),

	} 


Given the above...we could have written our divide function
like this:

//chapter2/options.rs

fn divide(dividend:u32, divisor:u32) -> Option<u32>{
    if divisor == 0u32{
        Options::Some(dividend/divisor)
    }else{
        Options::None
    }


}













