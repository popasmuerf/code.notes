url: https://stackoverflow.com/questions/37419572/if-async-await-doesnt-create-any-additional-threads-then-how-does-it-make-appl



#Async/Await Basis
--------------------------------------


Let's tackle a simple button click eevent in a Windows Forms application:


public aysnc void button1_Click(object sender, EventArgs e)
{
    Console.WriteLine("before awaiting") ;
    await GetSomethingAsync() ;
    Console.WriteLine("after awaiting") ;
}


Let's not worry about what **GetSomethingAsync()** returns...
Just know that it returns/completes in roughly 2 seconds.


In a traditional, non-asynchronous, world  your button click envent handler
would look something like this:

public void button1_Click(object sender, EventArgs e)
{
    Cosnsole.WriteLine("before waiting") ;
    DoSomethingThatTakes2Seconds() ;
    Console.WriteLine("after waiting") ;
}


When we click on the button in the form, the application will appear to 
freeze for 2 seconds, while we wait for this method to complete.
What happens is that until this method **DoSomethingThatTakes2Seconds()** 
...Basically this method is **BLOCKING**  our hypothetical event loop that is
running this code...and thus...the code is *blocking**


Our hypothetical loop continuously asks windows "Has anyone done something, like
moved the mouse, clicked on something ?  Do I need to repain something ?  If so, 
then you need to tell me!!!...and then it will process that "something".
The loop recieved a signal that the user clicked on  **button1**  and ended up
calling our button1_Click method above.  Until this method returns, this event loop
is now blocked as it waits for **button1_Click()** returns.

Most things that deal with GUIs are done using messages, which means that if the message
loop stops pumping messages, enven for just a second, it is quickly noticable by the user.


async/await does create new threads...so how does it manage to allow for code that
would otherwise be **blocking** code to be **non-blocking** code ?

Well...what happens is that our method behind the scense is actually split in two...

    1. All the code leading up to await, including the call to **GetSomethingAsync()**
    2. All the code following await
    

**Illustration**

    code... code... code...await X();...code... code... code...

**Rearanged:

    code... code... code... var x = X(); await X; code... code... code...
    ^                                  ^          ^                     ^
    +---- portion 1 -------------------+          +---- portion 2 ------+


##What's Going on Here ?
1. Everything is executed up to **await**
2. **GetSomethingAsync()** is executed which does it's thing, and 
   returns something that will complete in 2 seconds in the future.

So far we are still inside the original call to **button1_Click()** , happening on
the main thread, called form the message loop.  If the code leading up to **await**
takes a lot of time, the UI will still freeze.  In our example, not so much.


3. With the **await** keyword, together with some clever compiler magic, does is that it 
   basically something like:
        Ok...you know what ? I am going to simply return from the button click event handler
        here.  When you(as in, the think we are running for) get around to completing, let me know
        because I still have some code left to execute.
        
        Actually it will let the SynchronizationContext class know that it is done, which,
        depending on the synchronization context that is in play at the moment; will queue
         up for execution.  The context class used in a Windows Forms program will queue it using the
         queue that the message loop is pumping.

4. So it returns back to the message loop, which is now free to continue pumping messages,
   like moving the window, resizing it, or clicking other buttons
   
5. Two seconds later, the thing we are waiting on for completes and what happnes now is that
   it (really the synchronization context) places a message into the queue that the message loop is
   saying "Hey I got some more code  for you to execute", and thi scode is all the code after the  await
   
6. When the message loop gets to that message, it will basically "re-enter" that method
   where it left off, just after **await** and continue executing the rest of the method.  
   Note that this code is again called form the message lop so if thi scode happens to do something
   lengthy without using async/await properly...it will again block the message loop.
   
   
 There is a lot of moving parts working under the hood...for more info:
 
 [Asynchronous Programming with Async and Await (C# and Visual Basic)](https://msdn.microsoft.com/en-us/library/hh191443.aspx)
 [SynchronizationContext Class](https://msdn.microsoft.com/en-us/library/system.threading.synchronizationcontext(v=vs.110).aspx)
 [Stephen Cleary - There is no thread ](http://blog.stephencleary.com/2013/11/there-is-no-thread.html)
 [Channel 9 - Mads Torgersen: Inside C# Async ](https://channel9.msdn.com/Shows/Going+Deep/Mads-Torgersen-Inside-C-Async)
 
 
#There is a reason we don't talk about what DoSomethingThatTakes2Seconds() does...

This is because I want you to focus on what async/await actually is and how it provides for
a truely parallel operation that doesn't itself use threads....but that doesn't mean that
there are no threads involved at all in the execution of the actual task.....**DoSomethingThatTakes2Seconds()** more than likely does use a seperate thread of 
execution...especially if it is doing something CPU intensive....if it is a network operation
then it definitely by definition will be seperate processes of execution. 
 
   
  
