Explanation how proxy based Mock Frameworks work
=============================================================
url :  http://blog.rseiler.at/2014/06/explanation-how-proxy-based-mock.html



Have we ever wondered how these Mockito lines work ?


	//code
	Foo foo = Mockito.mock(Foo.class)
	Mockito.when(foo.echo("foo")).thenReturn("foo");




The first important thing to know is that there are two types of frameworks.
--------------------------------------------------------------------------------
1. the proxy based mocke frameworks: Mockito, EasyMock, jMock,....
2. the mock frameworks based on bytecode manipulation: PowerMock,....







Thre is a big difference between these two concepts
------------------------------------------------------------------
1. Proxy based mokcing is much easier to implement but they are 
   more restricted in the features they can support

2. Bytecode manipulating mocking is indeed a very , dark, arcane
   magick.  It can break on major Java releases.  So be careful if
   you start to use such frameworks, because they could prevent you
   from upgrading your java version.  



What is a Proxy?
-----------------------------------------------------------------------
A proxy is just an object which will be used instead of the orginal object.
....
one more time....
A proxy is just an object which will be used instead of the original object
.....
again..one more time for business...
A proxy is just an object which will be used instead of the original object...


If a method of the proxy object is called then the proxy object can decide what it 
will do with this call:

	1. Delgate it to the orginal object
	2. Handle the call itself.

So again....I can call a method on this proxy that is "mocking" the original 
object....and then that proxy that is mocking some object...can decide to

	1. Delegate that call to the original object being mocked by the proxy
	2. The proxy that is mocking some object can handle the call itself....


Proxies can be used to implement some kind of permissioni system.
The proxy checks if the user is allowed to call the method and if the user doesn't
hae the permmission then it throws an exeption....



Limits of a Proxy
--------------------------------------------------------------------------------
There are a few important restructions to proxies.  It not possible to:

1. Intercept static method calls
2. intercept private method calls
3. intercept final method calls
4. build a proxy for a final class
5. Proxies must be careated explicityly




How to create a Proxy
--------------------------------------------------------------------------------
If you look into the Java API you will find the

	java.lang.reflect.Proxy 

class.


/**
	Returns an instnace of a proxy class for the specified 
	interfaces that dispatches method invocations to the 
	specified invocation handler

	@param loads the class loader to define the proxy class
	@param interfaces the list of interfaces for the proxy class to
	       implement
	@param the invocation handler to dispatch method invocations to
	       implement
	@param The invocation handler to dispatch method invocations to 
               Proxy.newProxyInstance(ClassLoader loader, Class<?>[] interfaces
	       InvocationHandler h)

*/


So if I am reading the above correctly...mocking proxies operat like this...
1. Load the ClassLoader to define the class to be proxied.
2. Generate a list of interfaces for the proxy class to implement(with you actually implementing
   the logic for the method signartures yourself programatically
3. The invocation handler then dispatches the method incoations to 
   Proxy.newProxyInstnace(ClassLoader loader, Class<?>[] interfaces Invocation Handler h)



Building our own Simple Mock framework
-----------------------------------------------------------------------------------


	/*
		The code creates a static mock
	       method which returns the proxy objet

	*/
	public class Mock{
	    public static<T> T mock(Class<T> _class){ 
		MovkInvocationHandler invocationHandler = new MockInvocationHandler() ;

		T proxy = (T) Proxy.newPoxyInstance(Mock.class.getClassLoader(),
		                                    new Class[]{_class}, invocationHandler) ;
		return proxy ;
	    }
	}


	/*

		In real life....
	*/

	public class Mock{
		public static<Integer> Integer mock(Class<Integer> _class){
			MockInvocationHandler invocationHandler = new MockInvocationHandler() ;

			Integer proxy = (Integer) Proxy.newProxyInstance(Mock.class.getClassLoader(),
		                                                         new Class[]{_class},
		                                                         invocationHandler) ;
			return proxy ;
		}
	}






The following code creates a proxy object for the _class variable and redirects all
calls to the to the MockInvocationHandler which looks like this:



	private static class MockInvocationHandler implements InvocationHandler{
		@Override
		public Object invoke(Object  proxy, Method method, Object[]args)throws Throwable{
		    return null ;
		}
	}


So each call to a method of the proxy object will return null.  At this stage we
have  proxy object on wich we can call methods.





How to dynamically define the Proxy?
----------------------------------------------------------------------------------------
Now the question is how to setup the proxy to return someting else than just null.
We can do something like: 

	Mock.when(foo.echo("foo")).thenReturn("foo")


But how does this work ?  To understand how this owrks, you have to 
analyze the one line of code very carefully and think about what ti actually does.




What does the when() method actually gets ?
---------------------------------------------------------------------------------------------
In the case of our example it would just get a null object.  IN teh first step
we created the foo object which is a proxy which is always going to return null.
The when() method doesn't get the method echo() with a parameter.  It is a common
method call.  It is a call to the proxy which will return null and pass the null value to the
when() method.  That's it.



How then does the thenReturn() method work?
------------------------------------------------------------------------------------------
We have learned that the when() method is just going to be passed a proxy object that will 
in turn when it's mocked method is called...it will return a null value....

It's actually just smoke and mirrors...


The solutin is simple:  with static variables in which the state is stored.

1. In the MockInvocationHandler we store the method and the arguments of the last call

2. In the Mock class -  Mock.when(foo.echo("foo")).thenReturn("foo")
   we store the reference to the MockInvocationHandler which was called last


 These two steps happens in the invoke() method of the proxy object - in the MockInvocationHandler. The when() method doesn't have any logic. When thenReturn() is called then we store the return value for the stored (remembered) MockInvocationHandler with it's last method and arguments. If the proxy is called again then it will return the stored return value (if it's the same method gets called with the same parameter).





Basically that is it...so now the Summary
--------------------------------------------------------------------------------
1. create a proxy
2. if a proxy method is called then remember which method was called.
   2.1 this proxy method call is normally located inside of the Mock.when() 
       method..even if it has no relationsip to the when() method
3. If thenReturn(value) is called; then store the "value" to the stored/remembered 
   method.

4. The proxy returns the "value" if the method is called again with the correct arguments.




The genius behind this is
------------------------------------------------------------------------------------------------------
The very simple API which makes the whole thing looks like very nice. Another great decision is that the when() method uses generics so that the thenReturn() method is type safe.

But what's about classes?
-----------------------------------------------------------------------------------------------------------
The current solution only works for interfaces. Because java.lang.reflect.Proxy only supports interfaces and not classes. So we need another mechanism to create the proxy. We have to dig a little be deeper and finally come to CGLIB - Code Generation Library. So we are back to magic. But it's by far not so dangerous like bytecode manipulation. We just use bytecode generation to create the proxy which shouldn't fail. In fact many tools are using CGLIB (e.g. Spring, Hibernate).

To create a proxy with CGLIB isn't any more difficult than with the Java`s Proxy class.


public static<T> T mock(Class<T> _class){
    Enhancer enhancer = new Enhancer() ;
    enhancer.setSuperclass(_class) ;
    enchancer.setCallback(new MockMethodInterceptor()) ;
   return (T) enhancer.create() ;
}



private static class MockMethodIntercepter{
    @Override
    public Object interept(Object obj, Method method,  Object[] args, MethodProxy proxy) throws Throwable{
	return null ;
    }

}


/*
You can create a proxy for a real object.
All calls will be delgatedto the real object
except if the method call is redefined.  With  
CGLIB this is very easy to build.  If you
want to know more just take a look at the 
source code.

*/

Foo foo = new Foo() ;
foo = Mockito.spy(foo) ;
Mockito.when(foo.echo("foo")).thenReturn("bar");



