url:[https://www.baeldung.com/jpa-composite-primary-keys]


#Composite Primary Keys in JPA


##1. Introduction
In this tutorial, we will learn aboutt Composite Primary Keys, and the 
corresponding annotations in JPA


##2.Composite Primary Keys
A composite primary key -- also called a composite key -- is a combination of
two or more columns to form a primary key for table...


##In JPA, we have tgwo options to define the composite primary keys, we should
##follow some rules.
-   The composite primary key class must be public
-   It must have a no-arg constructor
-   It must define equals() and hasCode() methods
-   It must be Serializable


##3. the idClassAnnotation....

###As per the JPA specification, let's careate an 
###AccountId class with these primary key fields

        public class Account implements Serializable{

            private String accountNumber ;
            private String accountTypoe;
            
            //default constructor
            
            public AccountId(String accountNumber, String accountType){
                this.accountNumber = accountNumber ;
                this.accountType = accountType ;
            }
            
            //equals() and hashCode()

        }
        
Next, let's assoicate the AccountId class with the entity Account.
In order to do that , we need to annotate the entity with the 
entity with the @IdClass annotation.  We must also
delcare the fields from the AccountId class in the entity
Account and annotate them with @Id.


        @Entity
        @IdClass(AccountId.class)
        public class Account{
            @Id
            private String accountNumber ;
            
            @Id
            private String accountType ;

            //other fields, getters and setters
        }
        
        
        
##4.  The EmbeddedId Annotation

@EmbeddedId is an alternative to the @IdClass annotation.
Let's consider another example wherewe have to persist some
information of a Book with title and language as the 
primary key fields.

In this case, the primary key class, BookId,must be annotated with 
@Embeddable



        @Embeddable
        public class BookId implements Serializable{
            private String title;
            private String language ;
            
            //default constructor
            
            public BookId(String title, String language){
                this.title = title ;
                this.language = language; 
            }
            
            //getters, equals() and hashCode() methods

        }
        
        
 then, we need to embed this class in the Book entity using  @EmbeddedId
 
         @Entity
         public class Book{
            @EmbeddedId
            private BookId bookId;
            //constructors, other fields, getters and setters
         }
         
         
 
 ##5. @IdClass vs @EmbeddedId
 
 As we just saw, the difference on the surface between these two is that
 with @IdClass, we had to specify the columns twice --- and with @EmbeddedId
 we didn't.
 
### What are the tradoffs?
 For example,  these different structures affect the JPQL quieies that
 we write.
 For erxample, with @IdClass, the query is a bit simpler:
 
        SELECT account.accountNumber FROM Account account ;
        
        
With @EmbeddedId, we have to do one extra traversal:

        SELECT book.bookId.title FROM Book book

Also, @IdClass can be quite useful in places where we are using a composite key class that we can't modify.

Finally, if we're going to access parts of the composite key individually, we can make use of @IdClass, but in places where we frequently use the complete identifier as an object, @EmbeddedId is preferred.       

