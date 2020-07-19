url:https://stackoverflow.com/questions/32304595/whats-the-difference-between-self-and-self


self  when used as a first method argument is actually shorthand for :

	self:Self

There is also &self

	self:&Self
	-or-
	self: &mut Self
	-or-
	&mut self

Self in method arguments is syntatic sugar for the recieving type of the
method...this also allows for generic types without too much 
repetition

Self is the type of the current object.  It may appear either in a
trait or an impl, but appears most often in traait wher it is
a stand-in for whatever type will end up implementing the trait
(which is unknown when definintion)  where it is 
as standin for whatever type will end up implementing the trait(which
is unknown when defining the trait):

	trait Clone{
		fn clone(&self) -> Self ;
	}

If I then implement Clone:


	//this is valid...
	impl Clone for SomeType{
		fn clone(&self) -> Self ;
	}

	//and so is this...
	impl Clone for SomeType{
		fn clone(&self) -> SomeType ;
	}


We can also use it in regular impl if we decided to be lazy:

	impl SomeType{
		fn new() -> Self{}
	}



self is the name used in a trait or an impl for the first argument of a method.
Using another neam is possible, however there is a notable difference:

*    if using self, the function introduced is a method
*    if using any other name, the functin introduced is an assocaiated function

In Rust, there is no implicit "this" argument passed to a type's methods:
you have to explicitly pass the "current object" as a method parameter.

this would result in:

	impl Foo{
	    fn do_it(this:&Foo, a:u32) {...}
	}

as we have seen, as a shorter form this could also be (still verbose)

	impl Foo{
	    fn do_it(this:&Self, a:u32){...}
	}

Thus the correspondence table:

	self => self:Self
	&self => self:&Self
	&mut self => self: &mut Self


	impl MyType {
	    fn doit(&self, a: u32) {
		// ...
	    }
	    fn another(this: &Self, a: u32) {
		// ...
	    }
	}

	fn main() {
	    let m = MyType;

	    // Both can be used as an associated function
	    MyType::doit(&m, 1);
	    MyType::another(&m, 2);

	    // But only `doit` can be used in method position
	    m.doit(3);     // OK: `m` is automatically borrowed
	    m.another(4);  // ERROR: no method named `another`
	}




	
