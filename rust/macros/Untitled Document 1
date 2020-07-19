url : https://doc.rust-lang.org/1.7.0/book/macros.html

Macros
=============================================================

Macros allow us to abstract at a syntactic level.  A macro invocation is shorthand
for an "expanded" syntactic form.  This expansiion happens early in compilation, before any
static checking.   As a result, macros can capture
many patterns of code reuse that Rust's core abstrations cannot.


The drawback of course with any abstraction is that macros can be harder to understand, because 
fewer of the built-in rules apply.  Like an ordianry function, a well-behaved macro can be used without understanding
it's implementation.



Definining Syntactic  macros
========================================================
You may have seen the vec! macro, used to initialize a vector with any number of elements


let x: Vec<u32> = vec![1,2,3] ;


This can't be an ordinary function, becaue it takes any number of arguments. 
Let's imangin it as syntatic short hand for


	let x: Vec<u32> = {
	    let mut temp_vec = Vec::new() ;
	    temp_vec.push(1);
	    temp_vec.push(2);
	    temp_vec.push(3);
	    temp_vec
	};


Implemeting this shorthand in a macro


macro_rules! vec {
    ( $( $x:expr ),* ) => {
        {
            let mut temp_vec = Vec::new();
            $(
                temp_vec.push($x);
            )*
            temp_vec
        }
    };
}



Implementing a macro that does computes factorials...


    macro_rules! factorial {

         ($x:expr) => {
          {
            let mut result = 1 ;
            for i in 1..($x + 1){
                result = reuslt * i ;
            }
            result  
          }
         };

     }


We start with defining a factorial macro.  Since we do not want the compiler
torefuse to compile our code as it might
overflow the macro stack, we will use a non-recurisve implementation.

