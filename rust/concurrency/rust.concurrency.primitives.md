Concurrency primitives
===========================================

One of the promises of Rust is to enable
fearless concurrency.  Quite naturally, Rust has
support for writing concurrent code through a number 
of mechanisms.  In thsi chapter, we will discuss a few of these.

We have seen how the Rust compiler uses borrow checking to ensure
correctness of programs at compile time.  It turns
out that those primitives are also useful in 
verifying correctness of concurrent code.  Now there 
are multiple ways of implementing threading in a programming
language.  The simplest possible way to create a new OS thread is for 
each thread created in the platform.

This is called **1:1 threading**.  On the hand, a number of application 
threads can be mapped to one OS thread.  This called **N:1 threading**.
While this approach is resource-light since we end up with 
few actual threads,  A middle ground is called 
**M:N threading**, where multiple application threads are mapped to multiple
OS level threads.  This approach requires the maximum amount of
safeguarding and is implemented using a runtime, something that 
Rust avoids.

So yeah..Rust uses the **1:1 threading model** .  A thread in Rust 
corresponds to the one OS thread in contrast to languages like **Go**.

Let's start with a look at how Rust enables writing multithreaded applicaitons:



	use std::thread ;


	fn main() {
	    for i in 1..10{
		let handle = thread::spawn(move ||{
		    println!("Hello from thread number {}", i);
		});

		let _ = handle.join() ;
	    }
	}



We start by importing the threading library.
in our main function, we create an empty vectory that
we wil luse to store references to the threads we create
so that we can wait for them to exit.

The threads are actually created using **thread::spawn**, to
which we must pass a closure that will be executed in each of those
threads.  Since we must borrow a variable from the 
enclosing scope(the loop index i) in our closure, the closure
itself must be a move closure that will be executed in each
of those threads. 
Right before exiting the closure, we call join on
the current thread handle so that all threads wait for one
another. This produces the following output....


	popasmuerf@pop-os:~/src/rust/lab1/basics/concurrency/threads$ cargo run
	   Compiling threads v0.1.0 (/home/popasmuerf/src/rust/lab1/basics/concurrency/threads)
	    Finished dev [unoptimized + debuginfo] target(s) in 1.69s
	     Running `target/debug/threads`
	Hello from thread number 1
	Hello from thread number 2
	Hello from thread number 3
	Hello from thread number 4
	Hello from thread number 5
	Hello from thread number 6
	Hello from thread number 7
	Hello from thread number 8
	Hello from thread number 9



The real power of multithreaded applications is when threads can cooperate to do 
meaningful work.  For that, two important things are necessary.

Threads need to be able topas data from one another and there
should abe ways to coordinate how the threads are scheduled so that
there aren't race conditions.  For the first problem, Rust provides a
message passing mechanisms via channels.....let's take a look:



	use std::thread ;
	use std::thread::JoinHandle;

	use std::sync::mpsc::channel;
	use std::sync::mpsc::{Sender,Receiver};


	fn main() {

	    let rhs = vec![10,20,30,40,50,60,70];
	    let lhs = vec![1,2,3,4,5,6,7] ;
	    let (tx, rx):(Sender<i32>,Receiver<i32>) = channel();
	    
	    assert_eq!(rhs.len(), lhs.len());

	    for i in 1..rhs.len(){
		let rhs = rhs.clone() ;
		let lhs =lhs.clone() ;

		let tx = tx.clone() ;

		let handle = thread::spawn( move || {
		    let s = format!("Thread {} added {} and {}, result {}",
		     i,
		    rhs[i],
		    lhs[i],
		    rhs[i] + lhs[i]);

		    println!("{}",s);
		    tx.clone().send(1).unwrap() ;



		});
		let _ = handle.join()
		        .unwrap() ;
	    }
	    drop(tx);
	    for result in rx{
		println!("{}", result);
	    }
	}




This example is much like the previous one.
We import the necessary modules to be able to work with channels.

We define two vectors, and we will create a thread for each pair of elements
in the two vectors so that we can add tohse and return the result.

We create the channel, which returns handles to the sending and the recieving ends

Later, we join all the threads.  Before we loop over the recieving end and print the 
results, we need to explicityly drop the reference to the original handle to the sending
end so that all senders are destroyed before we start recieving (the cloned
senders will be automatically destroyed when the threads exit)
