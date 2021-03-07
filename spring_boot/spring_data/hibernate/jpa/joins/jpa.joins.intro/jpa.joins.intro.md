url:[https://www.baeldung.com/jpa-join-types]
#JPA Join Types                          

##1.Overview
In this tutorial we will look atg diffrent join types supported by JPA.
For that purpose, we will use JPQL, a query language for JPA.



##2. Sample Data Model
        //Let's look at our sample data model that we will use in the examples.
       //Firstly, we'll create an Employee entity:

        @Entity
        public class Employee{
            @Id
            @GeneratedValue(strategy = GenerationType.IDENTITY)
            private long id;

            private String name;

            private int age;

            @ManyToOne
            private Department department;

            @OneToMany(mappedBy = "employee")
            private List<Phone> phones;

            // getters and setters...

        }


        //Each Employee will be assigned to only one Department

        @Entity
        public class Department {

            @Id
            @GeneratedValue(strategy = GenerationType.AUTO)
            private long id;

        //Lastly, each Employee will have multiple Phones:          private String name;

            @OneToMany(mappedBy = "department")
            private List<Employee> employees;

            // getters and setters...
        }

        //Lastly, each Employee will have multiple Phones:       

        @Entity
        public class Phone {

            @Id
            @GeneratedValue(strategy = GenerationType.IDENTITY)
            private long id;

            private String number;

            @ManyToOne
            private Employee employee;

            // getters and setters...
        }
        
        
        
##3.  Inner Joins
We will start with inner joins.  When two or more entities are inner-joined, only the
records that match the join condition are collected in the result

###3.1 Implicit Inner Join with Single-Valued Assoication Naviagtion
Inner joins can be implicit.  As the name implies, the developer doesn't specify
implicit inner joins


        @Test
        public void implicitInnerJoin(){
            TypedQuery<Department> query = 
                entityManager.createQuery(
                    "SELECT e.department FROM Employee e",
                    Department.class
                );

        }
        
In the above, the Employee entity has a many-to-one relationship
with the Department entity.    If we navigate from an Employee entity 
to her Department -- specifyin ge.dpartment -- we will be
navigating a single valued assoication....As a result, JPA will create 
an inner join.  Furhtermore, the join
condition will be derived from mapping metadata.



###3.2 Explicit Inner Join with Single-Valued Association
Next, we will look at explicit inner joins where we use th eJOIN keyword i n
our JPQL query: 

        @Test
        public void expliciteInnerJoin(){
            TypedQuery<Department> query = 
                entityManager.createQuery(
                    "SELECT d FROM Employee e JOIN e.department d",
                    Department.class
                );

        }
        
        
        
        
In the query above, we specified a JOIN keyword and the associated Department entity in the FROM clause, whereas in the previous one they were not specified at all. However, other than this syntactic difference, the resulting SQL queries will be very similar.






###7. Fetch Joins
Now' let's talk about fetch joins.  It is primaryly used for fetchingt lazy-loaded associations
eagerly for the current query.: 

        @Test
        public void whenFetchKeywordIsSpecified_ThenCreatesFetchJoin() {
            TypedQuery<Department> query 
              = entityManager.createQuery(
                  "SELECT d FROM Department d JOIN FETCH d.employees", Department.class);
            List<Department> resultList = query.getResultList();
            
            // Assertions...
        }
        
        
Although this query looks very similar to other queries, there is one difference, and that is that the Employees are eagerly loaded. That means that once we call getResultList in the test above, the Department entities will have their employees field loaded, thus saving us another trip to the database.

But be aware of the memory trade-off. We may be more efficient because we only performed one query, but we also loaded all Departments and their employees into memory at once.


We can also perform the outer fetch join in a similar way to outer joins, where we collect records from the left entity that don't match the join condition. And additionally, it eagerly loads the specified association:

        @Test
        public void whenLeftAndFetchKeywordsAreSpecified_ThenCreatesOuterFetchJoin() {
            TypedQuery<Department> query 
              = entityManager.createQuery(
                  "SELECT d FROM Department d LEFT JOIN FETCH d.employees", Department.class);
            List<Department> resultList = query.getResultList();
            
            // Assertions...
        }


url:[https://www.baeldung.com/jpa-composite-primary-keys]
ur:[https://www.baeldung.com/jpa-join-types]

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
            https://www.baeldung.com/jpa-join-types
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

