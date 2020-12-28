#Chapter 3 Working with Mockito 
==========================================
Mokito is an open source mock unit testing 
framework for Java.  In the previous chapter, we 
read about test doubles and  mock objects.
Mockito allows mock object creation, verification, 
and stubbing.


Again...what does Mockito allow us to do ?
    -   mock object createion
    -   verification
    -   stubbing
    
    
Automated tests are sefty nets.  They run and notify
the user if the system is broken so that the
offending code can be fixed very quickly...

If a test suite runs for an hour, then the entire purpose of
quick feed back is compromised.  Unit tests should 
act as a safety net and provide quick feedback;
This is the primary principle of TDD.

I have worked with an enviroment where when a piece of
code is checked-in, the automated tests
would run and would take hours to complet.

So the developer in turn would have to wait for an hout ro check-in
the new code unless the previous build/test run was complete.


Tests may take time to execute due to the following reasons:

    -   Tests acauires a connectionf rom the database that
        fetches/updates data
    -   It connects to the internet and downloads files
    -   It interacts with an SMTP server to send emails
    -   It peforms I/O operations 
    
    
Unit tests should adhere to a number of preinciples for flexibility
and maintainability.  The next section will elucidate the principles that
we will follow throughout this journey .
    
##Qualitities of unit testing
Unit tests 
    -   Order indempendent and isolated:
        *   The Atest.java test should not be dependent 
            on the output of the Btest.java classes
            
    -   Trouble-free setup and run
        *   Unit tests should not require a DB connection, Internet
            , or any other external connection or a clean up temp
            directory
    -   Effortless execution:
        *   Unit tests should run fine on all computers, not
            just on a specific computer
    -   Formula 1 execution : 
        *   A test should not take more than second to finish the 
            execution. 

Now the question is do we really need to acquire
a database connection or download files to unit
test code ?

The answer is yes. If it doesn't connect to a database or download the
latest stock price, few parts of the system remain untested.  So, DB
interaction or network connection is mandatory for few parts of the system, and these
are integration tests.  T unit test these parts, the external dependencies need
to be mocked out.

Mockito plays a key role in mocking out external depdencies.  It mocks out the 
database connection or any external I/O behavior so that 


    
    
    
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
    }t framework

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

          

In the preceding code snippet

        AlwaysFailingDispenserStub
        
raises an error whenever the **dispense()** method is invoked.
It allwos us to test the transactional behavior when the
hardware is not present.


Mockito allows us to mock interfaces and concrete classes....
One mo'  'gain..... Mockito allows us to mock both interfaces and 
concrete classes

Using  Mockito we can actually  the methods of the interfaces we are mocking like

        public interface Dispenser{
            void dispense(BigDecimal amount) throws DispenserFailed ;
        }

        public class Always FailingDispenserStub implements Dispenser{
            void dispense(BigDecimal amount) throws DispenserFailed{
                (ErrorType.HARDWARE,"not responding") ;
            }
        }


Fake 
==========================================================
Fake objects  are working implementations; mostly the fake class
extens the original clas but it usually hacks the performance, which
makes it unsuitable for production. The following example demonstrates the
fake object:

public class AddressDao extends SimpleJdbcDaoSupport{
    public void  batchInsertOrUpdate(List<AddressDTO> addressList, User user){
        List<AddressDTO> insertList = buildListWhereLastChangeTimeMissing(addressList);
        int rowCount = 0 ;
        if(!insertList.isEmpty()){
            rowCount = getSimpleJdbcTemplate().batchUpdate(INSERT_SQL,....) ;
        }
        
        if(!updateList.isEmpty)){
            rowCount += getSimpleJdbcTemplate().atchUpdate(UPDATE_SQL,...) ;
        }
        
        if(addressList.size() != rowCount) {
            raiseErrorForDataInconsistency(...) ;
        }
    }   
    
}


AddrssDAO extends from a Spring framework class and provides an API for mass update
and provides an API for mass update.  The same method is ued to create a new address
and update an existed one; if the count doesn't match, then an error is raised.


AddressDAO extends from a Spring framework class and provides an API for mass update.
The same method is used to crete a new address and update an existing one, if the count doesn't match, then
an error is raised.  this class cannot be tested directly, and it needs 

        getSipleJdbcTemplate()

So, to test this class, we need to bypass the JDBC collaborator ; we can
do this by extending the orginal DAO class but by  overriding the collaborator; 
we can do this extending the orginal DAO class but is a fake implementation of 
AddressDao 


public class FakeAddressDao extends AddressDao{
    @Override
    public SimpleJdbcTemplate(){
        return jdbcTemplate ;
    }

} 


FakeAddressDao extends AddressDao but only overrides getSimpleJdbcTemplate() and returns
a JDBC templage stub.  We can use Mockito to create a mock version of the JdbcTemplate
and return it from the fake implementation.   This class cannot be
used in production as it uses a mock JdbcTemplate; however, the fake class inherits all
functionalities of the DAO, so this can be used for testing.  The fake classes are
very useful for legacy code .



Mock
============================================================
Mock objects have expectations;

    -   a test expects a value from a mock object
    -   during execution a mock object returns the
        expected result.
    -   Mock objects can keeop track of the invocation count,
        which is the number of times a method on a mock
        object is invoked.
        

The following example is a continuation of the ATM example with a mock version.
In the previous example, we stubbed the dispense method of the Dispenser interface to tho
trows aan exception;  here, we will use a mock object to replicate the 
same behavior.  




        public interface Dispenser{
            void dispense(BigDecimal amount) throws DispenserFailed ;
        }

        /* Don't bother implementing this class....
           When we can just mock it instead.... */
        public class Always FailingDispenserStub implements Dispenser{
            void dispense(BigDecimal amount) throws DispenserFailed{
                (ErrorType.HARDWARE,"not responding") ;
            }
        }


        public class ATMTest {

            @Mock 
            Dispenser failing Dispenser ;
            
            @Before public void setUp() throws Exception{
                MockitoAnnotations.initMocks(this) ;
            }
            
            @Test public void transaction_rollback_test() throws DispenserFailed{
                Acount myAccount - new Account(2000.00,"John") ;
                TransactionManager txMrg = TransactionManager.forAccount(myAccount) ;
                txMgr.registerMoneyDispenser(failingDispenser) ;
                
                doThrow(new DispenserFailed())
                .when(failingDispenser)
                .dispense(isA(BigDecimal.class));
                
                txMgr.withdraw(500);
                assertEquals(2000.00, myAccount.getRemainingBalance());
                verify(failingDispenser, new Times(1))
                .dispense(isA(BigDecimal.class));   
            }
        }   


The preceding code is the mock (Mockito) version of the 
ATM test.  The same object can be used in different tests;
just the expectation needs to be set.  Here,

**doThrow()** reasises an error whenever the mock object is called
with an BigDecimal value.






##Some things we should mention
==========================================
*   JUnit5 and Mockito 2.21.0
    -   @RunWith(MockitoJUnitRunner.class)  no longer is supported
        or is depreicated...I can't remember...but don't use it.
           
    -     @RunWith(MockitoJUnitRunner.class) has taken the place of
          **@RunWith(MockitoJUnitRunner.class)**  so this class level annotation
          now is responsbile for initializing any fields that are annotated with 
          **@Mock** that are intended to be used as mocked doubles of interfaces and 
          classes
          
*   Things that Mockito cannot do..
    -   Mockito cannot mock or spy the following functions:
        *   final classes
        *   final methods
        *   enums
        *   static methods
        *   p;rivate methods
        *   hashCode()
        *   equals
        *   anonymous classes
        *   primitive types
        

*   We can do some of these things via derivatives of Mockito
    -   PowerMock(an extension of EasyMock
        *   supports mocking of private methods
        *   allows custome expectations on new invocations
            for private member innder classes, and 
            local or anonymous classes.
    -   But you really shoulen't be mocking private properties..
        as it violates encapsulation, instead  refactor the
        offending code to make it testable
    -   PowerMockito(extension of the Mockito framwork)
    
    
    
The Mockito framework supports stubbing and allows us to return
a given value when a psecific method is called...this is accomplished via
using the method 

        impport static org.mockito.Mockito.when ;
        Mockito.when();
        Mockito.thenReturn() ;
        
        
##UnnecessaryStubbingException

### Strict Stubbing
With version 1.x of Mockito, it was possible to configure and 
interact with mocks with no kind of restriction   This meant that,
over time, tests would often become overcoplicated and at times harder to 
debug

Since version 2.+ , Mockito has been introductin new features that nudge the ramework
towards "strictness".  the main goals behind this are:

1.  Detect unused stubs in the test code
2.  Reduce test code duplication and unneessary test code
3.  promote cleaner tets by removing "dead" code
4.  Help improve debuggability and productivity


##Configuring Strict Stubs
Since Mockito 2.+, strict stubbing is used bhy default when initializing
our mocks using either of  :

    MockJUnitRunner
    MockitoJUnit.rule() ;

##One last important point to make is that in Mockito 3.0, all stubbings will be “strict” and validated by default.
