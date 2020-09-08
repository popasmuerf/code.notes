url: https://spring.io/blog/2016/06/13/notes-on-reactive-programming-part-ii-writing-some-code


Generators
====================================
A Flux is a publisher of a sequence of events of a specific POJO type, so
it is generic, i.e. 


        Flux<T> is a publisher of T
        
**Flux** has some static convenience methods to 
create instances of itself from varierty of sources
for example to create a **Flux** from an array:

        Flux<String> flux = Flux.just("red", "blanco", "blue") ;
        
We just generated a **Flux**, and now we can do stuff with it.
There are actually only 3 things you can do with it:

    -transform it via operating on it
    -combine it with other sequences
    -subscribe to it(it's a publisher after all)
    
    
    
Single Valued Sequences
===============================================
Often you encounter a sequence that you know has on one or 
zero elements, for example a reository methond that finds an
entity by its id.

Reactor has a **Mono** type that represents a single valued or empty 
**Flux**.

**Mono** has a very similar API to **Flux**  but more focused because not
all operateors make sense for single-valued sequences 

Rxjava also has a bolt on (in version 1.x) called **Single**, and also 
**Completable** for any empty sequence.  The empty sequence in 
Reactor is **Mono<Void>**


Operators
=================================================
There are a ton of methods on a **Flux** ad nearly all of
them are operators.  Here we will get a feel for a few of them...

//Request for internal events inside a **Flux** to be 
//logged to STDOUT, we can call **.log()** or we can transform it
//using **.map()**

        Flux<String> flux = Flux.just("red","white", "azul") ;
        Flux<String> upper = flux.log().map(String::toUpperCase);
        
        
The observation that should be taken from the above code is that there
is no data actually proccessed here.  It's just a plan of execution.

There are however some important differences between **Flux** and **Stream**
which make Stram an inappropriate API for Reactive use cases. **Flux** has a lot more
operators, but the real diffrence comes when you want to conume the data, so that is what we need to look at next.


Subscribers
===================================================================
To make the data flow you have to subscribe to the
**Flux** use one of the **subscribe()** methods.
Only those methods make the data flw.
They reach back through the chain of operators you declared on your sequence
if any...and request the publisher to start creatin data.

