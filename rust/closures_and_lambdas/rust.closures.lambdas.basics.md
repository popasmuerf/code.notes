Higher-order functions in Rust
========================================================
*	Rust functions define an isolated scope
*	Local variables live within this scope
*	Variables outside the scope can neer lead into
	it unless they are explicitly passed as arguments.


There are cases when the above behavior isn't desired
==================================================================
*	Closures provide an anonymous function like
	mechanic which has access to all the resources
	defined in the scope in which it is defined.

*	This does not violated compile borrow checking
	rules 

*	Code reuse here is made easier.

*	In Rust, a typical closure borrows all
	bindings of tis surround scope.

*	A clusre can be forced to own those by marking it
	with the **move** keyword


	//Examples of typical closures

	//closure with two parameters
	    let add = |a,b| a+b ;
	    assert_eq!(add(2,3),5);

	//common use cases are on iterators
	//A real example of closures for functional programming
	//We are interested in filtering a list of integers to collect
	//only the even ones out of it.
	//Ranges return a built-in type **Range**
	//**Range** implements the trait **IntoIterator**
	// **IntoIterator** behaves as an iterator

	    println!("{:?}",(1..10)
	    .filter(|x| x % 2 == 0)
	    .collect::<Vec<u32>>());

	    //using a variable from enclosing scope
	    let times = 2 ;
	    println!("{:?}", (1..10).map(|x| x * times)
	    .collect::<Vec<i32>>());
	  
  

Let's look at an example of using the  **move**
keyword in closures

	 let mut times = 2 ;
	    {
		//This is in a new scope
		let mut borrow = |x| times += x ;
		borrow(5);
	    }
	    assert_eq!(times, 7);

	    let mut own = move |x| times += x;
	    own(5);
	    assert_eq!(times,7);


The difference between the first closure (borrow)
and the ones we have discussed so far is that
this mutates the variable it inherits form the enclosing scope.
