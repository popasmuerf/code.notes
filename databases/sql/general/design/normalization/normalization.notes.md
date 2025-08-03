[source](https://medium.com/analytics-vidhya/database-normalization-vs-denormalization-a42d211dd891)




# Database Normalization vs. Denormalization


Data base normalization is the process of structuring a relational database in 
accordance with a serices of so-called normal forms to reduce data reduendancy and improve
data integrity.


In the database design scope, NOrmalization is a database design technique that organizes tables in a manner that 
reduces redundancy and dependency of data by minimizing the insertion, deletion  and update anomalies through 
eliminating the redundant data.


Using the Normalization technique to design databases causes divide larger tables into smaller tables and lings
them using relationships.  The entire purpose of Normalization is to eliminate redundant (useless) data and 
ensure data is stored logically.


## Key Differences Between Normalization and Denormalization 

Both Normalized and Denormalized techniques have their own benefits and drawbacks.  The
following table compared these two techniques in a short but understandble way 

                                                        Normalization                                   Denormalization
            ---------------------------------------------------------------------------------------------------------
            Basic                                       Normalization                                   Denormalization 
                                                        is the process creating                         is the process 
                                                        a schema to store non-redudant                  of combining the data 
                                                        consistent data                                 so it can be queired speedily 
            ---------------------------------------------------------------------------------------------------------

            Purpose                                     To reduce the data redundancy                   To achieve the faster execution 
                                                        and inconsistency                               of queries through introducting
                                                                                                        redundancy
            ---------------------------------------------------------------------------------------------------------

            Used In                                     OLTP systems                                    OLAP systems. emphasis
                                                        emphasis on                                     on making search and 
                                                        insert, delete,                                 Analysis fasster 
                                                        update operations faster 
                                                        and storing quality data

            ---------------------------------------------------------------------------------------------------------
            Data                                        Maintained                                      Not maintained
            Integrity
            ---------------------------------------------------------------------------------------------------------

            Redundancy                                  Eliminated                                      Added
            ---------------------------------------------------------------------------------------------------------

            Number                                      Increases based                                 Decreases
            of                                          on ERD of objects
            Tables                                      and verbs 

            ---------------------------------------------------------------------------------------------------------

            Disk space                                  Optimized usage                                 Uses Disk Space like crazy                                                                                  Thanks to data 
                                                                                                        redundancy

            ---------------------------------------------------------------------------------------------------------