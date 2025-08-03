[source](https://www.sisense.com/blog/beginners-guide-to-mysql-storage-engines/)


# Why should I have a good index strategy ?

Indexing data is so braod that it is hard to know what to do wand what to do when 
developing your indexing strategies.

## What you should index
- Create a primary keys
- Predict secondary keys with unique inices to speed up 
join queries
- As a rule, the most commonly queried data should be indexed (LOL...you don't say?)
	* usernames
	* passwords
	* email addresses
	* etc 
- Predict columns that will most often be queried with clauses
	* WHERE 
	* GROUP BY
	* HAVING
	* ORDER BY
- You should have an index on he columns that will be used with 
functions such as 
	* SUM()
	* COUNT()
	* MIN()
	* MAX()
	* AVG()

- Incides should only breated on a small proportion of a table's columns
	* Large incides of composite types can be excessively large in comparison to their table.
	* It is always important to consider index-table size ration
		- The larger the ratio, the less useful the index will be to you 
		- The larger the ratio gets, the more memory and cpu cycles it eats

		


## What you should not index
- Tables with relatively few column if a large percentge of 
its records will extracted
- Indexing will not help you here (it will but not by much and what you gain here may be outweighed by index memory consumption)
- Tables that experience frequent deletion of primary and foreign keys
- Static data tables of relatively small size
- Static dat   

- Only INDEX what you really need to index.  A multitude of indecies will have a deliritous effect on 
your database performance
- 


# MySQL Table Types 

### Basic table formats :  
	- ISAM 
	- HEAP
	- MyISAM
	- InnoDB
	- BDB


### Useful commands related to storage engines

	mysql > SHOW ENGINES\G


### So some things...
- Default : MyISAM
- Using any table type that is not compiled-in or activated MySQL will instead create a table of type 
	* MyISAM
- Defaulting to MyISAM when you need to copy tables between different SQL servers that support differnte table types 
	* So basically MyISAM is the default table type for MySQL.  It's like using the base Object type in Java when in doubt...sorta
	* Comes in handy in scernarios when copying tables to a slave tyhat is optimised for speed by not having transactional tables. 
	* Auto table changing can be very cofusing to those new to MySQL


### MySQL supports two different kinds of tables: 
- transaction-safe tables
	* InnoDB
	* BDB
- non-transaction-safe tables 
	* HEAP
	* ISAM
	* MERGE
	* MyISAM

- Advantages of transation-sfe tables 
	* Safer
	* journaling 
	* You can combine many statements and accept these all in one go with the COMMIT command.
	* You can execute ROLLBAcK to ignore your changes (if you are not running in auto commit mode)
	* If an update fails, all your changes will be restored. (With NTST tables all changes that have taken place are permanent)


- Advantages of non-transaction-safe tables(NTST):
	* Much faster
	* No transaction overhead
	* Wil use less disk spae, as there is no overhead of transactions
	* Willuse less memory to do updates
	* lack of atomicity(?)

- You can combine TST and NTST tables in the same statements to get the best of both worlds 


### Default storage types for MySQL
	- MyISAM
		* MySQL 3.0
	- InnoDB
		* MySQL 8.0
		* MySQL 5.0  

### MyISAM Tables

- MyISAM is the default table type in MySQL Version 3.23




# Storage Engine Capabilities 

### InnoDB 
The default opotion in MySQL 5.7, InnoDB is a robst strage engine that offers:
	- Full ACID compliance
	- Commit, rollback and crach-recovery
	- Row-level locking 
	- Foriegn Key refernetial-integrity constraints
	- Increase multi-user concurrency (via on-locking reads)




### MyISAM
The functionality that sets MyISAM apart is its capaolity for :
	- full text search indexes 
	- table-level locking 
	- lack of suppor for transactions 





Reemployment Opportunity Workshop


1863294848 
031176110 

