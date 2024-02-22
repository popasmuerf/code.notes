## Partial and Total Participation

- Relationships between entities can be optional or compulsory.
- We can decide that a person is considered to be a customer only if they have bought a product
- On the other hand, we can saythat a customer is a person whom we know about and whom we hope might buy something
- We can have people in our DB that may never buy a product 
- In the first case, the customer entity has total participation in the bought relationship
- Int he first case, teh customer entity has total participation in the bought relationsihip (all customers have bought a product,
and we can't have a customer  who hasn't bought a product ), while in the second case it has partial participation *a customer can buy a product).
- These are referred to as the participation constraints of the relationship.  In an ER diagram, we
indicate total participation with a double line between teh entity box and the relatiopnship diamond


### Entity or Attribute ?

From time to time, we encounter cases where we wonder whether an item should be 
an attribute or an entity on its own.  For example, an email address could be modeled as an entity in its own
right.  When in double, consider thesse rules of thumb :


Is the item of direct ineterest to the database ?

- Objects of direct interest should be entities, and information that describes them should be stored in attributes.
    Objects -> entities 
- Information that describes Objects should be stored in attributes 
    Information describes an Object -> attribute
- SO BASICALLY THE QUESTION IS FUNDAMENTALLY WHEN MODELING A DB : is the focus



## Is the item of direct interest to the database ?

1. Objects of direct interest should be entities
2. Information that describes them shoudl be stored in attributes 
3. An inventory and sales DB is really interested in :
    - customers 
4. An inventory and sales DB is not really interested in : 
    - email addresses
    - email addresses describe customers.  
    - email addresses should be implemented as one of the attributes of customers 


## Does the item have components of it's own ?
Now here is where things get tricky.....

If so, we must find a way of representing these components; a separate entity might be
the best solution In the student grades example, we store the course name, year and semester for each course that a student takes.
It would be more compact to treat the course as a seperate entity and to create a class ID number to identify each time a course is offered 
to students (the "offering")


## Cn the object have multiple intances ?
    - we must find a way to store a data on each instances.
    - cleanest way to do this is to represent the object as a separate entity.
    - In our sales example, wemuse ask whether customers are allowed to have more than one eamial address as a separate tnetity.
    - 

## Is the object often nonexistent or unknown ?
    - If so, it is effectively an attribute of only some of the entities, and it wold be better to model it 
    as a separate entity rather than as an attribute that is often empty.
    - consider a simple example: 
        * Store student grades for different courses 
        * We could have an attribute for the student's grade in every possible course
        * Because most students will have grades for only a few of these courses
        * it is better to represent the grades as a separate entity set as 




## Entity or Relationship ?
 
 An easy way to decide whether an object should be an entity or  a relationship
 is to map nouns in the requirements to entities, and to map the verbes to relations.

 For example, in the statement, 

 " A degree program is made up of one or more courses," we can identify entities "program"
 and "course", and the relationship "is made up of". Similarly, in the statment, "A student enrolls in one program",
 we can identify the entities "student"  and "program", and the rleationship "enrolls in".
 Of course, we can choose different terms for entities and relationships



## Intermediate Entities 

It is often possible to conceptually simplify M:N relationships by replacing the M:M relationship with a 
new intemediate entity (AKA as an associated entity) and connecting the original entities through a M:N 
and a 1:M relationship.

Consider the statement: " A passenger can book a seat on flight"  This is a M:N relationship between 
the entities "passenger" and "flight"  The related ER diagram fragment is shown in 


However, let's look at this from both sides o the relationship: 

* Any given flight can have many passengers with a booking 
* Any given passenger can have bookings on many flights 


Hence, we can consider the M:N  relationships one each way.  This points us to the 
existence of a hidden intermediate entity, the booking , between the flight and 
the passenger entities.  The ruirement coudl be better worded as :

"A passenter can make a booking for a seat on a flight"


## Weak and Strong Entities

Weak entities cannot exist on their own within the context of the Database's focus.
for example.....if the focus of the DB is on People with kids....the kid table 
is a weak entity because it cannot exist without the Parent table.
Beause the Kids entity  is a Weak entity, that only exists within the context of the Parents
entity, we only need to know who the Parent is, and just a little information 
about the Kids entities that may be associated with that Parent object.

Weak entities are said to participath ``totally`` in the identiy relationship because again...their existence is 
based on the relationship with some other Strong Entity (The parent)

Relationships formed by Weak Entities are themselves Week and are represented in ER diagarams
as reenforced daimand.
Keys for Weak Entities....are typically their own primary key and the primary key of their 
associated Strong Object  they are in a relationship in 

Both Weak Entities and Weak Relations/Associations.....are represented in ER diagrams 
as reinforced entities (drawn with double line boundries)



# The Music Database 

1. Stores details of a personal music library
2. Manages MP3, CD, vinyl collection 
3. For personal use, so it will be relatively simple 
4. Stores only relationships between
    - artists 
    - albums 
    - tracks 
5. Requirements that will be ignored 
    - Music generes 
6. this DB schema will focus on storing popular music as opposed to generes 

7. Requirements 
    * The collection consists of albums 
    * An album is made by exactly one artist 
    * An artists makes one or more albums 
    * An album contains one or more tracks 
    * Artists, albums and tracks each have a name 
    * Each track has time length, measured in seconds
    * When a track is played, the data and time the playback began (to the nearest second) should
    be recorded; this is used for reporting when a track was last played, as well as the number of times
    music by an artist, from an album, or a track has been played


ER entities 
--------------------
artists : entity 
album : entity
tracks : weak entity 



# The University Database 

1. University database stores details about 
    - University offers one or more programs 
    - A program is made up of one or more courses 
    - A student must enroll in a program 
    - A student takes the courses that are part of their program 
    - A program has a
        - name 
        - programId
        - total credit points 
        - year commenced
    - Courses have 
        - name 
        - courseId 
        - credit point value 
        - year commenced 

    - Students have
        - one or more given names
        - surname
        - studentId
        - DOB
        - year enrolled
        -
    - When a student takes a course 
        - year and semester he attmepted it are recorded 
        - Whe he finishes the course, a grade (such as A or B) and a mark (such as 60 percent) are recorded

    - Each course in a program is sequence into a year (for example year 1) and a semester (for xmaple, semester 1)




##  The Flight Database 

- The airline has one or more airplanes 
- An airplane has a
    - model number 
    - unique registration number 
    - capacity to take one or more passengers

- A flight has a 
    - unique flight number 
    - departure airport 
    - destination airport 
    - departure data and time 
    - arrival data and time 

- Each flight is carried out by a single airplane 

- A passenger has
    - given names
    - surname 
    - unique email address 
    - A passenger can book a seat on a flight 
  
- A passenger  can book a seat on a flight 




## Mapping the entities to database tables

- For each strong entity, create a table comprising 
its attributes and designate the primary 

The parts of any composite attributes are also included here


For each weak entity, create a table comprsing it's 
attributes and including the primary key ot 
its own owning entity. 

# Map the realtionshyips to database tables

