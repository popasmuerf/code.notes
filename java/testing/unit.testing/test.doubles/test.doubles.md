#Chapter 3 Test Doubles
==========================================
Junit's concept of test doubles and explains various test double types,
such as 
    -   mock
    -   fake
    -   dummy
    -   stub
    -   spy
    
    
    Sometimes, it is not possible to unit test a
    block of code because of unavailability of collaborator objects
    or the cost of instantiation for th ecollaborator.
    
    Test doubles alleviate the need for a collaborator.
    
    
    We know about stunt doubles--- a trained 
    replaceent used for dangerous action sequences in 
    movies, such as jumping out of the Empire State building,
    a fight sequence on top of a burning train, jumping from an 
    airplane, or similar actions.  Stunt doubles are used to protect the 
    real actors or chip in when the actor is not available.
    
    
    While testing a class that communicates with an API, you don't want to 
    hit the API for every single test; for example, when a piece of 
    code is dependent on database access, it is not possible to unit test
    the code unless the database is accessible.  Similarly, while testing a class
    that communicates with a payment gateway, you can't submit payments to a
    real payment gateway to run tests.
    
    Test doubles act as stunt doubles.  They are skilled replacements fore
    collaborator objects .
    
    Gerard Meszaros coined the term **test doubles** and explained test doubles
    in his book xUnit Test Patterns, Pearson Education
    
    
    
                        Doubles
   --------------------------------------------------------------
   |      |      |     |     |
   |      |      |     |     |
  Dummy  Stub   Mock  Fake  Spy
  
  
  
  
  ##Dummy
  =============================================
  An example of a dummy would be a movie scene
  where the doulbe doesn't perform doesn't perform anything but is only present on the screen...such as watching the tennis finales of a US Open match.
  
  
  Similarly, dummy objects are passed to avoid 
  to avoid **NullPointerExceptions** for mandatory parameter 
  objets as follows:
  
          Book javaBook = new Book("Java 101", "123456") ;
          Member dummyMember = new DummyMember()) ;
          javaBook.issueTo(dummyMember) ;
          assertEquals(javaBook.numberOfTimesIssued(),1) ;
          

In the preceding code snippet, a dummy member was created and passed 
to a book object to test if a book can report the nunber o tiems it
was issued.  Here, a member object is not used anywhere but it is needed to issue 
a book


  ##Stub
=============================================
A stub delivers indirect inputs to the caller when the 
stub's methods are called.

Stubs are programmed only for the test scope.

Stubs may record other information such as the number of 
information such as the number of times the methods were 
invoked and so on.


Account transactions should be rolled back if they
ATM's money dispenser fails to dispense money(i.e.....all bank
transactions must be atomic).  How can we test this when we dn't have
the ATM machine, or how can we simulate a scenario where the dispenser fails ?
We can do this using the following code:


  
public interface Dispenser{
    void dispense(BigDecimal amount) throws DispenserFailed ;
}

public class Always FailingDispenserStub implements Dispenser{
    public void dispense(BigDecimal amount) throws DispenserFailed{
        (ErrorType.HARDWARE,"not responding") ;
    }

}


    class ATMTest {
        @Test
        public void transaction_is_rolledback_when_hardware_fails(){
            Account myAccount = new Account("John", 2000.00) ;
            TransactionManager txMgr = TransactionManager.forAccount(myAccount);
            txMgr.registerMoneyDispenser(new AlwaysFailingDispenserStub());
            WithdrawalResponse response = txMgr.withdraw(500.00) ;
            assertEquals(false,response.wasSuccess());
            assertEquals(2000.00,myAccount.remainingAmount());
        }

    }

          

In the preceding code snippet, a dummy member was created and passed 
to a book object to test if a book can report the nunber of times it
was issued.  Here, a member object is not used anywhere but it is needed to issue 
a book










