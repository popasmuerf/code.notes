#  The most important variables are full-scan indicators

To avoid performance issues, It is strongly suggeste4d that
any new features added to your application or website should be tested against the
amount of data you have in production, so that the indexes can be 
created in production before deployment.



Stress testing can help, but it is not a good idea to run them in 
a production enviroment.  In this case, we can use two important variables that
can come to your aid and are called

	select_scan

	select_full_join



Of course ,other MySQL counters could also give ou an idea of 
the number of quieries that will imnpact MySQL performance, 
which cold lead to performance degradation  as the load or 
pressure increases on your database.


	select_scan
	seelct_full_join




The **select_scan** variable in the MySQL report

	SHOW GLOBAL STATUS 

shows the number of full scans performed since th elast 
MySQL restart(because every time you restart MySQL, all variables are
reset to 0 )

The **select_full_join** variable is another important indicator that
we will look at in the optimization domain to help us see whether MySQL
is doing a lot of work with joins.  Of course, a small number means that 
you can ignore join optimization and focus on other variables.


A full sacan of small table is fast, so that missing indexes can be ignored
until the load increases or the amount of data increases as already 
mentioned in previous chapters.



To avoid performance issues, I strongly suggest that any new
features added to your applicaton or website  or website should be
tested against the amount of data you have in production, so that the
indexes can be created in production before deployment.


	mysql> show global status\g 


### Example-1
The following is our extraction only the variables the variables that we need:


	**************************************** 303. row ***********************************

	Variable_name: Select_full_join
		Value: 0 



	**************************************** 304. row ***********************************

	Variable_name: Select_full_range_join
		Value: 0 


	**************************************** 305. row ***********************************

	Variable_name: Select_range
		Value: 1


	**************************************** 306. row ***********************************

	Variable_name: Select_full_range_check
		Value: 0 


	**************************************** 307. row ***********************************

	Variable_name: Select_scan
		Value: 56 


In our previous example, the Select_scan tells that it has had 56
full scans in tables nxt to the SELECT statement.  So, this indicator will
help you with your attempted optimization in MySQL is overloaded.

The other variables we can ignore as they either listing very few or zero indicators




### Example-2
We can accomplish the same thing in Example-1 but this time have indicator status display every at an interval.
Here we choose an interval of 10 seconds 

	 > mysqladmin -r -i 10 extended-status | grep "Select_scan"

This command will display the same results we got manually, but this time the display will continuously live
every 10 seconds.

The indidcators that we have demonstrated in this setion will be useful before starting
to optimize your quieries to give you an idea of where to start.








