url: http://makble.com/normalization-and-denormalization-with-mongodb

Normalization and denormalization with MongoDB
=====================================================================


Pros and Cons
-----------------------------------------------------------
	-	Normalization means refernece data with foreign key or referneces
	-	Denormalization means  embed the data to the location its being
		being referenced

Another example of denormalization is used is Lucene and Solr, like MongoDB,
they also adopted document model, actually it's very natural to use MongoDB
as data storage and use Lucene or Solr a searching , analyzing and index
building for the data.


Normalization makes your data compact....
-------------------------------------------------------------
	-	makes your data more compact
	-	easy to stor and easy to achieve consistency
	-	hard to scale to horizontally

DeNormalization makes your data more nimble..
-----------------------------------------------------------------
	-	provides high performance 
		querying
	-	may cause data inconsistency
	-	may cause the overall size of your data
		to be signifcantly larger due to potential 
		data redundancy...
	

Tradeoffs....tradeoffs....how do we choose ?
----------------------------------------------------------------
	- 	Depends on your use case....

	
Example of nomalization
-------------------------------------------------------------------
 
array(
    'title' => 'post title',
    'category' => 'software',
    'author' => $authorid
 
);
 
array(
    'authorid' => $authorid,
    'author_name' => 'james',
    'author_description' => 'A software engineer'
);



In the above example....you would need...if your use case demanded at least an 
intersection between the two sets of data over the domain of these two tables...
to perform at least two quieries....that would at minimum be of operational cost
of 

	O(2)


We can speed up this read operation via denormalziation....


array(
    'title' => 'post title',
    'category' => 'software',
    'author' => array(
	'authorid' => $authorid,
        'author_name' => 'james',
        'author_description' => 'A software engineer'
     )
)


In the denormalized version....all the tposts containing th author should be updated to 
reflect the change.

If the consistentency is not imporant, denomralization is ok....like the author inofrmation, users would not complain if the author information 
outdated for a short time....


If te data rarely being written but frequently being read, denormalization is acceptble for
performance gain.

		
