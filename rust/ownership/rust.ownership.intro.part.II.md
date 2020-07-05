Borrowing Part 2
==================================================
In real life applications, mos of the time we have to 
pass variable bindings to other functions 
or assign them other, variable bindings.  In this case,
we are referencing the original binding: borrow the data of it.



What is Borrowing?
========================================
Borrow(verb)
To recieve something with the promise of returning it.

Shared & Mutable borrowings
=========================================
There are two types of Borrowing....

1. Shared Borrowing (&T)
	*    A piece of data can be borowed by a single or
	     multiple users, but data should not be altered


2. Mutable Borrowing (&mut T)
	*    A pieced of data can be be borrowed and altered by a single user, 
             data should not be accessible for any other users at that time.


Rules for borrowings
=============================================
There are very important rules regarding borrowing

1. One piece of data can be can be borrowed either as a 
   shared borrow or as a mutable borrow at a
   given time.  But not both at the same time.

2. Borrowing applies for both copy types and move types

3. The concept of Liveness....



