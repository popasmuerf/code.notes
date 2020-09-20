url: https://www.blueskyprojects.com/print-design/



Delegates in C#
=======================================
C# introduces the concept of delegates, which represent methods that are callable without
knowledge of the target object.  Conscider these situations:


Java Code:


    public class Class1{

        ...
        public void show(String s) {...}
    }

    public class Class2{
        ...
        public void display(String s) { .. }
    }




If the twor classes share a common interface, we can simply treat
instances of either class as instances of that interface


These two classes have the methods show and display,
which peform a similar signature.  That is, they 
take simlar arguments and return similar data, and coudl be used in a lopp
doing conceptually simlar things.  However, because the names
of the tow methods are different, no inteface willreognize the tow as performing
the same function


Java may address these issues through reflection (by generating an interface and 
implementing it with inner wrapper classe) or by constructing a 
dynamic proxy.   All of these solutions work but are clumsy and require a bit
of non-trivial implementation.


C# code :

    //define three classes with simlar methods
    //two instances with differing names, one static

    public class Class1{
        public void show(String s){Console.WriteLine(s);}
    }

    public class Class2{
        public void display(String s){Console.WriteLine(s);}
    }

    public class Class3{
        public static void staticDisplay(String s){Console.WriteLine(s);}
    }
    
    
 We will now define a new data type, doShow, which abstracts the common features of the methods in all
 three classes  
 
 C# Code 
 
 public delegate void doShow(String s) ;
 
 Think of a delegate as an interface declaring exactly one method.  An instantiation
 of a delegate is ismilar to an anonymous inner class that implements the
 interface through a one-line call to a single method(static or instance) with a
 compatible signature.
 
 
 C# Code
 
 public class TestDelegate
 {
    //define a datatype as a method taking a string  returning void
    public delegate void doShow(String s) ;
    
    public static void Main(string[] args)
    {
        doShow[] items = new doShow[3] ;
        
        items[0] = new doShow(new Class1().show) ;
        items[1] = new doShow(new Class2().display) ;
        items[2] = new doShow(new Class3.staticDisplay) ;
        
        for(int i = 0 ; i < items.Length;  i++_
        {
            items[i]("Hello World") ;
        }
    }
 }
    
    
    
So basically C# delegates are an inverstion of control for methods ?

In C#, methods are 1st class objects...in the same way a Class like String.class is a
1st class object in Java.

In C#, if we reference a method on an object(omitting the parenteses that wold normally signal a metho
call), C# instead treats the metodh like a field, returning the ojbec representing that method.  The contstructor
of a C# delegate expects to be called with just 
such a method object.


In Java terms, C# is dynamically creating an interface that declares a single method.
When one considers how many interfaces(especially listeners and other event handlers) fit this
description, the utility of this approach is apparent.  C# uses delegates rather than
Listener interaces to implement mos of its event handling.


Threads in C# are constructed with delegates...

    System.Threading.ThreadStart
    
as opposed to to Java which uses Runnable interface




Implementing Delegates in Java
==============================================================

The Delegator Class
------------------------------------------------------------------
Two methods may be considered comparable if the argument lists of each method
are assignable the same common list of clasesad if the return types are
assignable to a common type.  As an example, if Foo is a superclass of Bar,
the two methods

    public String m1(Foo p1) ;
    public Object m2(Bar p1) ;

both match a signature taking Bar and returning Objet.

We could express this signature in code by providing a Class object tht
represents the return type and an array of Class to represtne the paramter types.
We 





/*  C#
    Delegates in C# pretty much are refernces to 
    methods that all phylogenetically speaking
    are 

*/ 

public delegate voide SomeFunction() ;

SomeFunction doSomething = SomeMethod;
doSomething() ;
doSomething = SomeOtherMethod ;
doSomething() ;




/*  Java
ISomeBehavior someBehavior = new TypeABehavior() ;
someBehavior.SomeFunction() ;
someBehavior = new TypeBBehavior() ;
someBehavior.SomeFunction() ;


*/





So in summary....
===============================================================

    Introduction

    The newest version of the Microsoft Visual J++ development environment supports a language construct called delegates or bound method references. This construct, and the new keywords delegate and multicast introduced to support it, are not a part of the JavaTM programming language, which is specified by the Java Language Specification and amended by the Inner Classes Specification included in the documentation for the JDKTM 1.1 software.

    It is unlikely that the Java programming language will ever include this construct. Sun already carefully considered adopting it in 1996, to the extent of building and discarding working prototypes. Our conclusion was that bound method references are unnecessary and detrimental to the language. This decision was made in consultation with Borland International, who had previous experience with bound method references in Delphi Object Pascal.

    We believe bound method references are unnecessary because another design alternative, inner classes, provides equal or superior functionality. In particular, inner classes fully support the requirements of user-interface event handling, and have been used to implement a user-interface API at least as comprehensive as the Windows Foundation Classes.

    We believe bound method references are harmful because they detract from the simplicity of the Java programming language and the pervasively object-oriented character of the APIs. Bound method references also introduce irregularity into the language syntax and scoping rules. Finally, they dilute the investment in VM technologies because VMs are required to handle additional and disparate types of references and method linkage efficiently.

