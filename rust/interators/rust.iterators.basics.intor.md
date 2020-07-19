Iterators
=========================================================
Aother important funcitona aspest is that of **lazy interation**.
Given a collection of types, one shold be able to loop over those
or a subset in any given order.

In Rust, a common iterator is a **range** which has a **start** and
an **end**.  How does this work ?


	use std::ops::Range ;
	use std::ops::RangeInclusive;
	#[feature(inclusive_range_syntax)]


	fn main() {
	    println!("Working with ranges...");

	    let numbers:Range<i32> = 1..5 ;

	    for number in numbers{
		println!("{}", number);
	    }

	    println!("--------------");

	    let inclusive:RangeInclusive<i32> = 1..=5  ;
	    for number in inclusive{
		println!("{}", number);
	    }
	}



This range is an exclusive range that spans fom the first
element to the last but one.

The second range is an inclusive one which spans till the
last element.  Note that the inclusive range is an experimental
feature that might change in the future.

As one would expect, Rust does provide interfaces with which a user-defined
type can be iterated on.  The type just needs to implement the
trait **std::iterator::Iterator

How about an example ?

Suppose we are interested in generating the Collatz sequence, given an
integer.  This is given by the recurrence relation below, given an
integer:

	If it is even, divideit by two.  If it is odd, multiply
	it by 3 and add one.  According to the conjecture, this
	sequence wil always terminate at 1.  We will assum that this is
	ture and define out code respecting that.



use std::ops::Range ;
use std::ops::RangeInclusive;
	#[feature(inclusive_range_syntax)]


	struct Collatz{
	    current:u64,
	    end: u64
	}


	impl Iterator for Collatz{
	    type Item = u64 ;

	    fn next(&mut self) -> Option<u64>{
		if self.current % 2 == 0 {
		    self.current = self.current/2 ;
		}else{
		    self.current = 3 * self.current + 1 ;
		}
	    

		if self.current == self.end{
		    Option::None 
		}else{
		    Option::Some(self.current)
		}

	    }
	}

	fn collatz(start:u64) -> Collatz{
	    Collatz{current:start, end:164}
	}


	fn main() {

	    let input = 10 ;

	    //First 2 items
	    for n in collatz(input).take(2){
		println!("{}",n);
	    }
	    //Dropping first 2 items

	    for n in collatz(input).skip(2){
		println!("{}", n);
	    }
	    
	}



In our code, the stae of the current iteration is represented
by the stuct called Collatz.  We implement the Iterator protocol on it.
For that, we need to implement the **next** function...
which takes in the current state and produces the next state.

When it reaches the end state, it must return a **None** so that the 
caller knows that the iterator has been exhaussted.  This is represented by the 
nullable return value of the function.  Given the recurrence, the implementation
is straight forward.


In our main function, we instantiate the initial state and we can iterate using
regular **for** loops

the Iterator trait automatically implements a number of useful functions;
the **take** function takes the given number of elements from the interator,
while the **skip** function skips the given number of elements.  All 
these are very important for working with iterable collections.

