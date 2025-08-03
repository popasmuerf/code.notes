[source](https://www.sisense.com/blog/beginners-guide-to-mysql-storage-engines/)


#Horizontally partitioning your data

Horizontal patitioning is used to divide your table records itno multiple partitions.

- All columns defined in a table are in each defined partition
- Teh whole partition can be organized individually or as a set
- For example, a table that contains a transaction as a subscription to your website
- 


## Managing partitions 

In this section we will cover options for managing partitions.
Some options that we will look into are th4e following :

* RANGE partitioning
* LIST partitioning
* HASH partitioning
* KEY partitioning 


# RANGE partitioning 

Partitioning of this type has an impact on partition
records based on the values of columns within a given scope


The RANGE partition is organized from an interval between two values
as long as these values do not overlap, and are set using operators :


	VALUES LESS THAN



- The basic syntax for creating a partition with RANGE is as follows:


		PARTITION BY RANGE (Column ID)
		(

			PARTITION p0 VALUES LESS THAN (Num1),
			PARTITION p1 VALUES LESS THAN (Num2),
			PARTITION p2 VALUES LESS THAN (Num3),
			PARTITION p3 VALUES LESS THAN (Num4)
		);



- In the following examples, suppose you create a table to 
sort employee records for a pizza chain of 
30 restaurants, numbered from 1 to 30.


This table can be partitioned by intervals in sveral ways, depending on your needs
for instance, by using the `resto_id` column as follows:


		CREATE TABLE employees
		(

			id INT NOT NULL,
			firstname VARCHAR(30),
			lastname VARCHAR(30),
			datehired DATE NOT NULL DEFAULT '1999-01-01',
			datefinished DATE NOT NULL DEFAULT '9999-12-31',
			job_id INT NOT NULL,
			resto_id INT NOT NULL
		)


		PARTITION BY RANGE (resto_id)
		(
			PARTITION p0 VALUES LESS THAN (6),
			PARTITION p1 VALUES LESS THAN (11),
			PARTITION p2 VALUES LESS THAN (16),
			PARTITION p3 VALUES LESS THAN (21),
			PARTITION p4 VALUES LESS THAN (31)
		);


- partitoning lines correspond to workers of restaurants 1 to 5  implicitly because we 
are partitioning on a range of restuarant IDs (resto_id) and resto_id is a foreign key 
in the employees table.


- The logic in the design here allows for easy determination that a new record containing example data:

	(53, 'Sia', 'lalonde', '1999-06-24', NULL, 14)

will be inserted into partition p2



- This record however will result in errors because the server doesn't know where to put it

	(54, 'parsons', 'rupert', '2003-08-18', NULL, 77)

The following will fix this problem :

		PARTITION BY RANGE (resto_id)
		(
			PARTITION p0 VALUES LESS THAN (6),
			PARTITION p1 VALUES LESS THAN (11),
			PARTITION p2 VALUES LESS THAN (16),
			PARTITION p3 VALUES LESS THAN (21),
			PARTITION p4 VALUES LESS THAN (31),
			PARTITiON p5 VALUES LESS THAN MAXVALUE);
		);



		# OR

		PARTITION BY RANGE (resto_id)
		(
			PARTITION p5 VALUES GREATER THAN (31)
		);



- We can also partion using the RANGE type according to the value of colunms dedicszated to 
to values such ast TIMSTAMP and UNIX_TIMESTAMP



























# An overview of partitioning in MySQL 8.0



- It is critical to find a partition key
- It is important to make usre that ht eseraches we are going to do in a table go to th ecorrect partition
- It is important to make sure that the searches we are going to do in a talbe go to the correct 
partition or group of partitions.
- This menas that all commands like SELeCt, UPDATE, DELeTE
must include this columin in the WHERE clasue to ensure efficiency in the use of these partions.

- Generally the best practis is to add the partition key to the primary key with auto incremetntation
	* Composite primary key
- TIf you do not have well-designed and small columns for this composite primary key, it coudl augment all your 
secondary indexes for no reason
- You can alwya parttion on 
	* Hashes
	* ranges



# Advanced Data Techniques for Large Queries

- The most important variables are full scan indicators
- Patitioning a table:
	- Partition types 
	- Horizontallly partitioning your data 
	- Managing partitions Options:
		* RANGE
		* LIST
		* HASH
		* KEY

- Using partitions:
	* Patition pruning

- Getting rid of unused and duplicate indexes
- Most important query optimizations
- Temporary tables




# Most important varibalbes are full scan indicators 

Scenario : High season is coming for your business, and 
youwonder how you will manage the load on your MySQL database 

Stress tests can help yo, but it is not a good idea
to run them in a production enviroment.  In this 
case, we can use two important variables tha can 
come to your aid and are as follows:

	- select_full_join
	- select_scan


## Server Status Variables

- MySQL servers maintain many status variables that provide information about it's operation
- You can view these variables and their values by using the statement 

	SHOW [GLOBAL | SESSION] STATUS

	SHOW VARIABLES LIKE 'max_join_size';
	SHOW SESSION VARIABLES LIKE 'max_join_size';


>

> SHOW VARIABLES LIKE 'select_scan'

	'Select_scan', '288163'

> 


> SHOW VARIABLES;

		# Variable_name, Value
		'activate_all_roles_on_login', 'OFF'
		'admin_address', ''
		'admin_port', '33062'
		'admin_ssl_ca', ''
		'admin_ssl_capath', ''
		'admin_ssl_cert', ''
		'admin_ssl_cipher', ''
		'admin_ssl_crl', ''
		'admin_ssl_crlpath', ''
		'admin_ssl_key', ''
		'admin_tls_ciphersuites', ''
		'admin_tls_version', 'TLSv1.2,TLSv1.3'
		'authentication_policy', '*'
		'auto_generate_certs', 'ON'
		'auto_increment_increment', '1'
		'auto_increment_offset', '1'
		'autocommit', 'ON'
		'automatic_sp_privileges', 'ON'
		'avoid_temporal_upgrade', 'OFF'
		'back_log', '60'

	> SHOW  GLOBAL VARIABLES;

		# Variable_name, Value
		'max_join_size', '18446744073709551615'



could also give you an idea of the number of queries that will 
impact MySQL performance degradation as the load or pressure increases
on your database ;





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



# What impact does an index on MySQL performance



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

