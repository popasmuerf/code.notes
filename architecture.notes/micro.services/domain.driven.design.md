# Domain Driven Design


- Fundamentals of DDD
- How to design an application using DDD 
- Domain models
- A sample domain model deisn based on DDD



A good sofware design is a MUST (or at least it should be).  You wonder why 
it's such a fucking process to update and maintain your shitty software ?
Cause your software is shit because you ignored the fact the Software Engineering
is in fact a discipline of ENGINEERING.  Proceed at your own risk, but you can never
say you weren't warned --- Mike Brown.   Game Engine Developer



## Domain-Driven design fundamentals

- A cloud application solves business prlblems and other real world problems
- These problems cannot be resolved without konwledge of the domain, you cannot
provide a software solution for  financial system such as online stock tracking if you 
don't undestand the stock exchsanges and their functioning.
- Therefore having domain knowledge is a must for solving problemss
- Now if yo uwnt to ofer a solution using software or apps, you need to 
design it with the help of domain knowledge.
- When we combine the domain and software design, it offers  software design methodology known as
DDD
- Designing models is not reocket science but it does take a lot of effort
    * refining and input from
        - Domain experts
        - software designers
        - software developers
    * Oranniazation Information
        - Divide information into smaller parts
        - groupthemlogically 
        - create modules 
        - each module can be taken up individually 
        and further divided using a similar approach.
        - the granularizing of components continues until you reach 
        a point of component atomization.
        - complex projects have more of such iterations 
        and similarly a simple project could have just a single iteration of it.

    * After documentation and design, we move on to actual implementtaion of the Domain Model.
    * DDD is a combinatio nof design and dev work 
    * DDD allows for continuous  software engineering that in turn allowd for 
    keeping the design up to date based on feedback recieved form the development.
    * DDD solves some of the limittions offered by Agile and Waterfall methodolotiges 
    making software more maintainble while keeping app miniumally viable.
        - DDD requires that the Software Engineers and Domain Experts to be present and have a voice from the 
        very beginning of even conceptial dicussions regarding any imagined engineering project
        - Involving the people who are actually going to be responsible for implementing stake holder conceptions removes the common bottle necks that emerge in projects where engineers are left out of the loop until much later in the SDLC process. In other words
        stake holders stupidly have no idea why there are delays with respect to deliverables when they fully expect engineers to have a deep understanding of the problem that they were never aprised of initially in the first place.

    * DDD allows for a "common and standardized language" across the entire project so no one is 
    left in the dark and have some understanding of what is going on at all levels.


## Multilayered architectured

Multilayred architecture is a common solution for `DDD`. It contains four layers:

1. Presentation layer or User Interface (UI)
2. Application layer
3. Domain layer
4. Infrastructure layer

------------          ----------         -----------
presentation ------>  application -----> domain layer
-------------         -----------        ------------

### Presentation layer
This layer represents the UI and provides the user 
interfae for the interaction and information display.
This layer could be a web application, mobile app or a third-party application
consuming your service
### Application layer
This layer is responsible for application logic.
It maintains and coordinates the overall flow of the 
the product/service.  It does not contain business
logic of UI.  It may hold the state of applicaton objects like
tasks in progress.  For example, your proct REST services would be part of this application layer
### Domain layer
The domain layer is a very important layer as it contains the domain information and business
logic.  It holds the state ofthe business objet.  It presists the state of the 
business objects, and communicates these persited stte to ithe infrastructure layer.

### Infrastructe layer
This layer provides  support to all the other layers and is responsible for communication 
among the other layers.  It contains the supporting libraries that are used by the other layers.
It also implements the persistene of business objects.


## Artifacts of domain driven design

There are different artifacts used in DDD to expres, ecreate and retrieve domain models.

### Entities
- There are certain categories of objects thta are indentifiable and remain the same 
throuought all states of the procut/services they trespass.
These objects are NOT defined by their attributes(tho they may posess attributes), but by its identity and thread of continuity.  These are known as `entities`

For example, say we have a table booking systems.
In this system we have a restuarant class with attribuees such as 
    - name
    - address
    - phone  number
    - establishtment data 
    - etc
We cant ake two instances of the restaurant class that are not indentifiable using the
restaurant name, as there could be other restaurrants with the same name.
Similarly if we go by any othe single attributes we will not find any attributes 
that can singlularly indentify a unique restaurant.  If two restuarants have all the 
same attribute values, these are the same an are interchangable without each other.
Still, these are the not eh same entities as both have different referneces (memory addersses)


Conversely, we could have a class for US Citizens.  Two citizens could have the same name, 
same address, etc....but they are definied as two entirely different entities by their social security number that will presist even when both are dead as long as the US social security system exists.

So basically entities are defined primarily by their identity at high level as opposed 
to their constituent attributes.  In other words we don't define people by having two arms, two legs, all their teeth, etc(because a person can have none of these things and still be a person)...we used their actual identities to identify people.


Therefor creating an entity in a product means creating identity.


There are different ways to create a unique identity for objects described as following:

- Using the primary key in table 
- Using an automated generated ID by a domain module
- A few real life objects carry user-defined identifiers themselves
    * For example each country has its own country codes for dialing ISD calls
- An attribute or combination of attributes can also be used for creating an identifier
as explained for the preceding restaurant object 



Entities are very important for domain mdoelds,therefore they should be defined from the outset 
of the design process.


### Value objects
#####  Frequently asked questions
### Services
### Aggregates
### Repository



NOTE:
- Eric Evans coined the term DDD in his book `Domain-Driven Design: Tackling Complexity in the Heard of Software published in 2004.`


### Value Objects


Entities have traits such as
    - identity
    - thread of continuity
    
Value Ojbects 
    - no conceptual identity
    
A best practice is to keep value Objects as immutable objects.
If possible you shouldkeep entity objects immutable also


Entity concepts may bias you to keep all objects
ase ntities, a uniquely identifiable object im memory
or database withlife cycle continuity, 
but there has to be one instance for each object.

Each customer object would represent the resturant guest and this cannot 
be used for booking orders for other guests.  This may 
create millions of customer entity objects in the memory if
millions of customers are using the system.  You will need to 
keep track of all of this.  This is resource intensive, and will impact performance


Applications don't always needs to have an identifable customer object and be trackable.
There are cases when you just need to have some or all attributes of the domain 
element.  these are the cases when value objects can be used by the application.
It makes things simple and improves the performance,


Value objects can be create dan destroyed easily, owing to the absense of identity.  This
simplifies the design -- it makes value objects available for garbage collection if no other object has referenced them.


Let's discuss the value object's immuntablility
Value objects should bbe designed and coded  as immutable.
Once they are crated they should never be modified during their life-cycle.
If you need a different value of the Value Object(VO) or any of its
objects then simply create a new value object but don't modify the original value object.
Here, immutabilitycarries all the significance from OOP.  A value
object can be shared and used without impacting on its integrity if and only if it is 
immutable (This is the reasoning behind much of Rust's resource borrowing idioms.)


#### Frequently asked questions 
1. Can a value object contain another value object ?

Yes, it can

2. Can a value object refer to another value object or entity?

Yes, it can


3. Can I create a value object using the attributes of different value objects or
entities ?

Yes you can



#### Services 

While creating the domain model you may encounter various situations, where behaviro may not be
related to any object specifically.  These behaviors can be accommodated 
in services objects.

Services are common in technical framework. 
These are also used in domain layers in DDD.  A service 
object does not have any internal state, the only purpose of it is to provide
a behavior to the domain.  


While creating the services, you need to tick all the following points:

- Service objects' behavior performs on enttities and value objects but it does not belong
to entities or value objects
- Service object's behavior stat is not maintained and hence they are statelees
- Services are part of the domain model



Services may exist in other layers also.  It is very important to keep 
domain layer services isolated.  It removes the complexities and keeps the 
design decoupled.



#### Aggregates


Aggregate domain pattern is related to the object's life cycle and defines ownership and 
boundaries.


When you reserve a table in your favorite restaurant online, using any app, you won't need
to worry about the interal system and process that  takes places to book your reservation such 
as searching the available restuarants, available tables during the given date, time , and 
so on and so forth.  Therefore, you can say that a reservation app is an aggregate of several
other ojects and works as a root for all other objects for a table reservation system.


This root should be an entity that binds collections of objects together.  It is also
called the aggregate root.  This root object does not pass any reference of inside objects
to external worlds and projects the changes performed in internal objects.


We need to undertand why aggregators are required.  A domain model can contains large numbers of 
domain objects.  The bigger the application functionalies and size and the more complex its deisn, the greater number of objects there will likely be.

A relationshop exists amoung these objects.  Some may havea  many-to-many 
relationship, a fw may have a one-to-many relationship and others may have a one-toone relationship.

these relathinships are enforced by the model implementtaion in the code or in the database that
ensures that these relationships among the objects are kept intact.

No matter how much simplification you input, you may still end up with relationships in teh model.
These relationships need to be maintained in the code.  When one object is removed, the code
should remove all the references of this object from other places.  For example, a 
reocrd removal from one table needs to be addressed wherever it has references in the form of foreign keys and such to keep the data consistent and maintain its integrity; and variant rules 
need to be forced and maintained whenever data changes.

Relationships, contraints, and invariants bring complexity that requires an efficient handling in code.  We find the soluton by using the aggregate represented by the single entity known as the root that is associated withthegrouop of objects that maintains cnsistency with 
respect to data changes.



This root is the only object that is accessible from outside, so this root element
works as a boundary gate that seperates the internal objects from that separates the internal objects 
can have references to other inside objects that may or may not have relationships with the root.  However,
outside objects can also refer to the root and not to any inside objects


An aggregate ensures data integrity and enforces the invariant.  Outside objects cannot make any change
to inside objects they can only change the root.  However, they can use the root to make a 
change inside the objet by calling exposed operations.  The root should pass the value of inside objects
to outside objects if required.


If an aggregate object is stored in the data base then the query should only return the aggregate object.
Traversal associations should be used to return the object when it is internally linked to the 
aggregate root.  These internal objects may also have references to other aggregates.

An aggregate root entity holds its globaly identity and hold local identities inside their entities.


An easy example of an aggregate in the table booking system is the customer.  Customers can be exposed
to external objects and their root object contains their internal object address and contact information.
When requested, the value object of internal objects like address can be passed to external objects:



            -- The customer as an aggregate 
            -------------                ------------
            |Customer   |                |ContactInfo|
            |------------                ------------
            |customerID | -------------->|workPhone  |
            |firstName  |                |homePhone  |
            |lastName   |                |email      |
            -------------                ------------
                |
                |
                |
                V
            -------------
            |Address    |
            |------------
            |houseNo    |
            |street     |
            |Area       |
            |city       |
            |state      |
            -------------


## Repository

- In a domain model, at a given point in time, many domain objects may exist.
- Each object may have its own life cycle from the creation of objects to their removal or persistence
- Whenever any domain operation needs a domain object, it should retreive the reference of the requested object efficiently
- It would be very difficult if you didn't maintain all the available domain objects in a central object tht carries the refernces
of all the objects and is responsible for returning the requested object reference.
- This central object is known as the reporistory.
- The repository is a pont that interacts with insfrastructures such as the database or file system. 
- A repositor y object is the part of the domain model that interacts with storage such as
    * databases
    * external sources
    * and so on
to retrieve the perrsisted objects 
- When a request is recieved by the repository for an onbject'sreference, it returns the existing object's reference.
- If the requested object does not exist in the repository then it retrieves the object from storgage
- The main purpose of a repository is having a consistent way to retrieve objects where the requestor does not need to interact
directly with the storage such as the database 
- Repositories may query objects from various storage types such as one or more
    * databases 
    * filesystems 
    * factory repositories
    * etc.
In these cases a repository may have strategies that also point to different sources for different object types
or categories 



## Factory 

- The factory is required when a simple constructor is not enough to create the object.
- It helps to create complext objects  or an aggregate that involves the creation of other related objects.
- A factory is also a part of the life cycle of  domain objects as it is responsible for creating them 
- Factories and repositories are in some way related to each other as both refer to domain objects 
- The factory refers to newly created objects whereas the repository returns the already existing objects either from in 
the memory or from external storages 

## Modules
- Modules are the best way of separating related business objects. Thee ae best suited to 
large projects where the size of domain objects is bigger.
- For the end user, it makes sense to divide the domain model into modules and set the relationship between
these modules.

# Strategic design and principles 
- An enterprise model is usually very large and complex.
- It may be distributed among different departments in an organization.
- Each department may have a separate leadership team so working and designing together
can create difficulty and coordination issues
- In such scenarios, maintaining the integrirty of the domain model is not an easy task
- In such cases, working on a unified model is not the solution and large enterprise models need
to be divided into different submodels.  These submodels contain the predenfined accurate 
relationship and contract in minute detail.
- Each submodel hast to maintain the defined contracts without any exception 

- These submodels contain the predenfined accurate relationship and contract in minute detail.
- Each submodel has to maintain defined contracts without an exception 


There are various principles that could be followed to maintain the integrity of the domain 
model, and these are listed as follows

* Bounded context
* Continuous integration
* Context map
    - Shared kernel
    - Customer-supplier
    - Conformist
    - Anticorruption layer
    - Separate ways
    - Open host service
    - Distillation


### Bounded context


Bounded context 
- When you have different submodels, it is difficult to maintain the code when all submodels
are combined. 
- You need to have a small model that can be assigned to a single team.
- You might need to collect the related elements and group them. 
- context keeps tand maintains the meaning of the domain term defined for its repsective 
submodel by applying thi set of conditions

- These domain terms defines the scope of the model that creates the boundaries of the context

- Bounded context seems very similar to the module that you learned about in the 
previous section.
- In fact, module is part of the bounded context that defines the logical frame wher a submodel
takes places and is developed.


Again...with our Restaurant example

- Guest visits the app and would request a table reservation in a selected restuarant, data, and time.
- Then there is backend systems that informs the restaurant about the booking information, and similarly,
the restaurant would keep their system updated with respect to table bookings, given that tables 
can also be booked by the restaurant themselves.

- so when we llok at the syste4ms finer points, 

* The online table reservation system
* The offline restaurant managment system

Both have own bounded context and you need to make
sure that the interface between them works fine



### Continuous integration 

- This code may be organized into different modules and has applicable bounded context for repsective submodels
- This sort of developoment may bring with it





- When you are developing, the code is scarred among many teams and various technologies
- This code may be organized into different modules and has application bounded context for respective submodels
- This sort of development may bring with it a certain level of complexity with respect to duplicate code, 
a code break or maybe broken bounded context
- It happens not only because of the large size of code and domain model, but also 
because of other factors such as changes in team members, new members or not having a well documented model
to name just a few of them
- When systems are designed and developed using DDD and AGILE, domain models are not designed fully 
before coding starts and the domain model and its elements get evolved over a period of time with continuous improvements
and refinement happening over time .



- Integration continues and this is currently and this is currentlyone of the key reasons for development  today,
so it plays a very important role.  IN the continuous integration, code is merged frequently to avoid any breaks
and issues with the domain model.
- Merged code not only gets deployed but it also is tested n a regular basis.  There are various continuous integration tools
available in the market that merge, build and deploy the code at scheduled times.  Organizations, these days, put
more emphasis on the automation of continuous integration.
- Having a test suite attached to each build confirms the consistency and integrity of the model.
- A test suite defines the model from a physical point of view, whereas UML does it logically
- It tells you about any error or unexpected outcome that requires a code change.
- It also helps to identify errors and anomalies in a domain model early 


## Context map 
- Context maps helpo you to understand the overall picture of a large enterprise application
- It shows how many bounded contexts are present in the enterprise model and how they are interralated
- Therefore we can say that any diagram or document that explains the bounded contexts and relationship between them is 
called a `context map`

- Context maps helps all team members, whether they are in the same team or in different teams
- To undertand the high-level enterprise modelin the form of various parts (bounded context or submodels) and relationships.
- This gives individuals a clearer picture about the tasks one performs and may allow him to raise any concern/questions about the 
model's integrity

            ................................................................................................
            .Table resevation Context .                                                                    .
            .                         .                                                                    .
            .                         .                                                                    . 
            .                         .                                                                    . 
            .         /----> Table1 <----------------\                                                     . 
            .        /                .               \                                                    . 
            .Restaurant               .                \-----> Table1                                      . 
            .        \                .                                                                    . 
            .         \----> Table1 <----------------\                                                     . 
            .                         .               \------> Table2                                      . 
            .                         .                                      Restaurant Ledger Context     .
            .                         .                                                                    . 
            .                         .                                                                    . 
            .                         .                                                                    .
            ................................................................................................


- The context map example diagram is a sample of a context map.
    
    * Table1 and Table2 both appaer in the `Table Reservation Context`
    and also in the `Restaurant Ledger Context`. 

    The interesting thing is the `Table1` and `Table2`  have their own repspective concept in each bounded 
    context.  Here, ubiquitous language is used to name the bounded context as table reserviation and restaurant ledger


### Shared Kernel

As the name suggests, one part of the bounded context is shared with the other's bounded context.
As you can see below the Restaurant entiry is being shared between  the Table Reservation Context and the
Restaurant Ledger Context 


### Customer-supplier

- The customer-supplier pattern represents the relationshp bewteen two bounded 
contexts when the output of one bounded context is required for th eother bounded context that is, one
supplies the information to the other(known as the customer/consumper) who consumes the information.

In a real world example a car dealer could not sell cars untilthe car manufacturer delivers them.
(Haha...a clear case for the `Flow` architecture...but lets continue) Hence in this
domain-model, the car manufacturer is the supplier and the dealer is the customer.  This relationship
establishes a customer-supplier relationship because the output(car) of one bounded context (car-manufactuerer)
is required by the other bounded  context (dealer)


Here, both customer  and supplier teams should meet regularly to establish a contract and form
the right protocol to communicate with each other



### Conformist 

This pattern is similar to that of the customer and the supplier, where one needs to provide the contract
and the information while the other needs to use it.  Here, instead of bounded context, actual teams are involved in having an upstream/downstream relationship.


Moreover, upstream teams do not provide for the needs of the downstream team because of their lack of motivation.
Therefore, it is possible that the downstream team may need to plan the work on items which will never be available.
to resolve such cases, either the customer team could develop their own models if the supplier provideds inforamtion that
is not worth conscidering.  If the supplier provided information is really of worth or of partial worth, then the customer can
uste the interface or translators that can be used to consume the supplier-provided information with the customer's own 
model.



### Anticorruption layer


The anticorruption layer remains part of a domain and itis used when a system needs data from 
external systems or from their own legacy systems.  Here, anticorruption is the layer that interats with external systems and 
uses external systems data in the domain model without affecting the integraityand orginality of the domain model.


For the most part, a service can be used as an anticorruption layer that may use a facade pattern with an adapter and translator to consume
within the internal model. Therefore, our system would always use the service to retrieve the data.  The service layer
can be deisgned using the facade pattern.  This would make sure that it would work with the domain 
model to provide the ruqured data in a given format.

Basically this is the pattern where neither the producer nor the consumers know about the details of what 


### Separate ways

When you have a large enterprise application and domain where different domains have no common elements and it is made of large 
submodels hat can work independently, this still works as a ingle application for an end-user.


In such caes, a designer cold carate sperate models that ha e no realationship and develop a small application 
on top of them.  these small applications become a single application when merged together 

An employer's INtranet application that offers various small applications such as those that are HR-related, issue ittrackers,
transport or intra company social networks, is one such application where a designer could use the separate ways pattern

Inegrating applications that have absolutely nothing to do with one another can be a head-ache...and maybe not worth the effort




### Open host service

A translation layer is used when two submodels interact with each other.
]This translationlayer is used when you integrate models with an external system.
This works fine when you have one submodel that uses this external system.  Te 
open host sevice is required when this external system is being used by many submodels 
to remove the extra and duplicated code because then you need to write a translation layer for 
each submodel external system.

An open host service provides the services of an external system using a wrapper to all submodels 




### Distillation

In DDD distillation is hte process that filters out the information tha tis not required, and keeps only the meaningful informaton.
(this) that is not required, and keeps only the meaningful information.  It helps you identify the core domain and the essential 
concepts for your business domain.  It helps you filter out the generic concepts until you get the code domain concept.

Core domain hsould be designed, developed and implemented with the highest attention to detail, using th edevelopers an designers,
as it is crucial for th ecussess of the whole system.  In out table resevervation system example, which 
is not a large, or complex domain application, it is not difficult to identify the core domain.  The core domain heree exists to share the real-time accurate vacant tables in the restarants and allows the user to reserve them in a hassle free process.
(Basically his is an example of the consciderations that need to be taken into account in Data Engineering regarding data ingestion.....)


# Sample Domain Service 




























