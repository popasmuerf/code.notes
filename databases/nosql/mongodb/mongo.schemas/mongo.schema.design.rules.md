url:https://www.mongodb.com/blog/post/6-rules-of-thumb-for-mongodb-schema-design-part-1

The 6 rules of Thumb for MongoDB Schema Design
==========================================================


Basics: Modeling One-to-Few
=========================================================
The following is an example of "one-to-few" might be the addresses for a 
person.  This is a good use case for embedding -- you would put the 
addresses in an array inside of your Person object.....


{
  name: 'Kate Monster',
  ssn: '123-456-7890',
  addresses : [
     { street: '123 Sesame St', city: 'Anytown', cc: 'USA' },
     { street: '123 Avenue Q', city: 'New York', cc: 'USA' }
  ]
}



This design has all of the advantages and disadvantages of embedding.
The main advantage is that you don't have to perform a separate query to
get the embedded details; teh main disadvantage is that you
have no way of accessing the embdeeded details as 
stand-alone entities.

	Pro:
		-We can access embedded objects withjust one query
		-O(1) operation

	Con:
		-We cannot access these embedded objects as stand-alone objects


For example, if you were modeling a task-tracking system, each Person would have
a number of Tasks assinged to them...Embedding Tasks insided The Person 
document would make quieries like 

	"Show me all Tasks due tomorrow" 

much more difficult than they need to be.



Basics: One-to-Many
===============================================================
An example of "one-to-many" might be parts for a product in
a replacement parts ordering system.

Each product may have up to severl hundred replacemnt parts, but never more than
a couple thousand or so.  This is a good use case for referencing....
you would put the ObjectIDs of the parts ina an array in product document

Each part would have its own document....

> db.parts.findOne()

{
    _id : ObjectID('AAAA'),
    partno : '123-aff-456',
    name : '#4 grommet',
    qty: 94,
    cost: 0.94,
    price: 3.99

}


> db.products.findOne()
{
    name : 'left-handed smoke shifter',
    manufacturer : 'Acme Corp',
    catalog_number: 1234,
    parts : [     // array of references to Part documents
        ObjectID('AAAA'),    // reference to the #4 grommet above
        ObjectID('F17C'),    // reference to a different Part
        ObjectID('D2AA'),
        // etc
    ]
}
> product = db.products.findOne({catalog_number:1234}) ;
> product_parts = db.parts.find({_id: {$in:product.parts}}).toArray() ;



In the above code, we would then use an "application-level join"....
meaning that we would peform the join at the application level programatically...
as there isn't a concept of relational joins in a non-relational DB...(duh!)

for efficient operation, we need to have an index on 

	products.catalog_number

(the part _id WILL ALWAYS BE INDEXED)
