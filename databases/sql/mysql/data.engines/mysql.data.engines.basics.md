[source](https://www.sisense.com/blog/beginners-guide-to-mysql-storage-engines/)

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













