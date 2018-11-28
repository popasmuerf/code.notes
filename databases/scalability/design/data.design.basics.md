Thinking about data systems
================================
We typically think of dtabases, queues,
casches, etc, as being very different categories 
of tools.  Although a database and a message 
ueue hae some superfficial simoliarity -- both
store data for some time -- they have very difffernt 
access patterns, which means different performance characteristics,
and thus very diffent implementations.


Many new tools for data storage and processing have emerged
in recent years.
===========================================================

	*	They all of course are optimized for a variety of different
		use cases

	*	As they are optimized for a variety of differnet purposes...
		they no longer fit neatly into taraditonal categories...

	*	For example, there are datastores that are also used as 
		message queues:
			-	Redis

	*	There are message queues with dtabase-like durability guarantees
			-	Apache kafka

	*	Boundaries between data store / data queue / data caching / etc
		are blurring....


	*	Using a single data managing tool is no longer sufficient
		w/r to large scale, high use, distributed systems....


	*	Data storage, read/writing is instead broken down into tasks that
		can be peformed efficiently on a single tool, and those different
		tools are stitched toghether using application code ...

	*	For example, if you have an application-managed caching layer
		(memcached or something similar), or a full-text search server
		(such as Elasticsearch or Solr) seperate from you main database...
		it is normally the application code's responsibility to keep those chaches and
		indexes in sysnc ith the main database.


	*	Quick Note...why Caching and Full Text Search ?
		-	We already know the importance of caching...
		-	Full Text Search...why?
			*	




