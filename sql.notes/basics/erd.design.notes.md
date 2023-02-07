

## Cardinality 
---------------------
One to One  <--> 1:1
One to Many <--> 1:N
Many to Many <--> M:N


Cardinality of relationships require
some real thought.



The number of entities on either side of a relationship
(the cardinality of the relationship) deinfe the key contraints of the
realtionship) define the key constraints of the relationship.

It's important to think about the cardinality of relationshps carefully

There are many relatinshps that may first seem to be 1:1 , but 
turn out to be more compolex.  For example, people 
soemtimes change their names; in some  applications, such as police dtabases, this is
or particular interest, and so it may be necessary to model
a many-to-many relationshp between a peerson entity and a name 
entity.  Redesigning a database can be time consuming if you 
assume a relationship is simpler than it really is.


in an ER diagram, we represent a relationship set with 
a named diamond.  The cardinality of the relationship is often indicated 
alongside the relationship diamond ;





Here we can start working on an ERD where 
the relationshp between entity customer and entity product
is <buys> 


Customer:
	Given Names
	Surname
	Email address
	Telephone number
	Postal address



Postal address:
	Street address
	City 
	Zip Code
	Country


Buys:
	ProductID
	CustomerID
	Number
	Timestamp

Product:
	ProductID
	Name
	Price




customer -----<buys M:N>-------- Product 




So to jump ahead.....a relationshp is also an entity with 
it's own atttributes.....




## Partial and Total Participation


Relationships between entities can be optional or compulsory.  In our example, 
we could decide that a person is considered to be a customer only if they have bought a product.  On the otherhand, 
we could say that a customer is a person whom we know about tahd whom we hope might buy something -- that is,
we can have people listed as customers in our database who never buy a product.  In the first case, the customer
entity has **total paticipation** in the bouth relationship
in that all customers have bought a product, and we can't have a customer who hasn't bought a product, while in the 
second case it has partial participation...a customer can by a product.

these are known as "participation contstraints of relationsps"


Do you really want to play this game of who's 
"community" has the most worst pathology given that
1. 99% of serial killers are White
2. White on White violence is responsbile for 82% of all violence involving white victims
3. 99% of all mass shooters are White
4. 99% of all domestic terrorists are White
5. 99% of The literal insurectionists who tried to overthrow the US government and lynch Congress Men they didn't like were White
6. 99% of all the utter m0r0ns who voted for Trumnp...TWICE are White
7. 99% of White collar crime are White
8. 100% of Racist cowards who past the trash you just did are White 



## Entity or Attribute ?

From time time, we encounter cases where we wonder whether an item should be an 
attribute or an entity on its own.  For example, 
an email address could be modeled as an entity in its own right; as concievabley
A customer can and will have at least two addresses they would like to use or 
have been resident at....be it one or more domeciles, and or a business 
address.....

There is a rule of thumb here: 

Is the item of direct interest to the database ?

Objects of direct interest should be entities, and information that describes them sould e stored in 
attributes.

Objects of direct interst should be entities, and 
indormation that desribes them shoudl be stored in attributes.

If our inventory and sales database is really interested in customers, and not 
thier email addresses, so the email address would be best modeled  as 
an attribute of the customer entity.....however if our application is 
interested in the customer's addresses also(like Amazon....they allow you
to ship to multiple addresses...) then yes....the cusotmer's address 
should be an object in relation to customer as opposed to only bein an 
attribute of of the customer object....

Can the object have multiple instances ?  If so...then yeah....it should 
be an entity.


Ia the object often nonexistent of unknown?  If yes...then it should be an attribute



Here's a decent example:

To store  student grades for differnet courses, we could have an attribute for the 
for the student's grade in every possible course.  Because most students
will have grades for only a few of these course, it is better to represent the grades as a separate entity set







## Entity or Relationship?

An easy way to decide whether an object shoudl be an entity or a relatiohship is to map 
nouns in the requirements to entities, and to map the verbs to relationshs.

For example, in the statement :

"A degree program is made up of one or  more courses"

We can identify identify the entities 
	- "program"
	- "course"

and the relationship 
	- "is made up of"


Similiarly, in  the statement : "A student enrolls inone program",
we can identify the entities  
	- "student"
	- "program"
We can indentify the relationship  as :
	- "enrolls in".


W e can shoose different terms for entities and relationships
than htose that appear in the relatinoships, 
but it is a good idea not to deviate 
too far from thenaming conventions used in the
requirements so that the design can 
be checked against the requirements.  All
else being equal, try to keep the design simple,
and avoid indtoriducting trivial entities where possible, i.e.
there is no need to have a spearate entity for the 
student's enrollment when we can model it as a relatihship
between teh existing student and program entities



## Intermediate Entities

It is often possible to coneptually simplify M:N relationships by 
replacing the M:N relationship with a new 

**intermediate** **entity** 
	AKA 
**associate** **entity**


and connectin ght eoringinal entities through 
	M:1  

	-and- 

	1:M 

relationship.


Consider the statement : A passenger can book  a seat on a flight"

this is a M:N relation ship between the entities 

	"passenger"

	-and-

	"flight"


	|Flight|-----M-------<Books>-----N------|Passenger|



Fonsideer the statement:  

"A passenger can book a seat on a flight"  This is a M:N 
relationship between the entitiew "passenger" and "flight".  


HOwever, let's look at this from both sides of the 
relationship: 

- Any given flight can have many passengers with a booking.
- Any given passenger can have bookings on many flights

Hypothetically we can consider the M:N relationship to be in fact
two 1:N relationships, one each way.  This points us to the 
existence of a hidden intermediate entity, the booking,
between the flight and the passenger entities.


HOwever, let's look at this from both sides of the relationship:


- Any given flight can have many passengers with a booking
- Any given passenger can have bookings on many flights


Hence,we can consider the M:N relationship to be in 
fact two  1:M realthiships, one each way.

this points us to the the existence of ta hidden nintermediate entity,
the booking, between the flight and passenger entities.  The requirement
could be better wored as:  A passnger can make a booking ofor a set on a flight.





	|Passenger|-----1-------<Makes>-----M------|Booking|
                                                   |
                                                   N
                                                   |
	|Flight|--------1--------<is for>-------------- 



	Each passenger can be involved in multiple bookings,
	but each booking belongs to a single 
	passenger, so the cardinality of this realtionship is 
	1:N.  Similarly, there can be many bookings for a given
	flight, but each booking is for a single flight, so this
	relaship also has crdinality 1:N. Xincd each booking must be
	associated with a particular passenger and flight, the booking entity
	participates totally in the relathionships with the entities.  This total participation could
	no be captured effectively in the representation


## Weak adn Strong Entities
Context is veery important in our daily interations; if we know the 
context, we can work with a much smaller amount of information;
if we know the context, we can work with a much smaller amount of 
information.  For example, we generally call 
family members by only their firsst name or nickname.  Where ambiguity
exists, we add futher information such as the surename 
to clarify our intent.  In DB design
can omit some key information for entities.

For example, if we wanted to store the names 
of our customers' children, we could create a child
entity and store only enough key information to idnetify it in 
the context of its parent.  We could simply list a child's first name on the
the assumption that a customer will never have sveeral children with the
same first name.  Here, the child entity is a weak entity, and its relationship ith
the customer entity is called an idntifying relathisip.

Weak entities participate totally in the 
identifying relationship. since they can't exit
in the database independently of their owning entity.

Weak entites adn identifying relationships are described with 
double line......










































