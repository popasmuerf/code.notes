# Introduction to NoSQL




Today, every "new-generation" application 
must be designed to grow based on these pillars:

- Cloud Computing
- Big Data/Analytics
- Mobile
- Social networking



### ALERT!!!!
- Software engineers must know ho to work with may more technologies than before
- The years of basically not having to worry about which data persistence 
technology you would use on a new project are long gone.
- The choices were just about what programminglanguages or relational database vendors you would 
use.  Today, for modern applications, data persistence is absolutley crucial 



- Relational DB should be used when ACID(Atomicity,Consistency, Isolation, and Durability) is a requirement
- ACID is a performance hit.  If you don't need ACID then don't go with RDBS
- RDBs were not designed with clustering in mind initially, however this feature of RDBs is a common thing now...however again....ACID effects performance and linear scalability
- Even when clustered, the underlying storage engine of the RDB will continue to be a relative bottle neck
- 


Speculative Retailers Web Application
-------------------------------------------

User Sessions          Financial Data           Shopping Cart            Recommendations
----------------       ----------------         ------------------       ---------------------
Redis                  RDBMS                    Riak                     Neo4j


Product                Reporting              Analytics                 User activity logs
----------------       ----------------       -------------------       -----------------------
Mongo DB               RDBMS                   Cassandra                Cassandra




- The majority of NoSQL databases are designed with horizontal scaliability in mind
- NoSQL databases were designed from the start to work as a cluster

## NoSQL categories 
- Key/Value
    * Redis
    * Riak
- Document
    * Mongo DB
    * Elastic Search
    * CouchDB
- Column based
    * HBase
    * Cassandra
    * PostGRE is capable of being configured to be column based
    * MySQL is capable of being configured to be column based 
- Graph
    * HyperGraphDB
    * Neo4J


## Modeling in NoSQL

- NoSQL databases are Schemaless
- Denormalization is our friend as we are conscerned with performance(the complete avoidance of joins)
    * Are views of associative tables just a facade over a join, or is it actually an in-memory table ?
- Storage is cheap, CPU cycles and memory.
- In Cassandra, you would cerate one column family (similar to a table in relational databases)
- In Cassandra joins and foreign keys don't exist



## Cassandra Overview
- Casandra producton cluser is used by Apple
- The cluster has more than 75,000 nodes storing more than 10PB of data.
- Second place goes to Netflix with 2,500 nodes storing 420TB with more than 1 trillion rquests per da.
- Can you imagine a RDB with more than 75000 machines owrking together?
- Cassandra is based on Google's Bigtable and Amazon's DynamoDB and was primarily created by Facebook.
- Cassandra is an Apache project and comes in community and enterprise editions
- It is able to handle a massive number of writes and reads per second while keeping linear scalability
- Cassandra provides automatic reliable replication across geographically distributed data centers
- Cassandra implements a peer-to peer architecture
- Cassandra uses a gossip protocol to perform internal communication so there is no master node that serves as a single point of failure like in a RDBS cluster 
- Cassandr's partitioning strategy is base on partion keys that you specify when you are modeling the primary key for your column
families.
- Cassandra is an excellent choice when dealing with a a huge amount of taime-series data, which is comon in  IoT computing  
    * logs
    * metrics 
- It is a good choice if consistency isn't a requirement, however this is configurable


NOTE:  Read consistency is when every node returns the same result
for the same query for a given point in time.  Remember that a
distributed system runs over a networ that has latency, so when you write data to a 
specific node, replciation will start taking plae and will take some milliseconds to happen on other nodes.  During this time, if a read rquest is iussed to the other nodes, then they will return stake data.  The consistency level
for both reads and writes is completely tunable in Cassandra


    NOTE:  Eventual Consistency is a consistency model that asures that at some point in the near future the system (in this case, Cassandra) wo;; become consistent.


NOTE: The CAP theorem states that when a total partition (a network failure, for example) or temporary partition (the latency between data replication after a write request, a full GC in the JVM, etc) happens in a distributed system, it has to choose
between consistency or availability.  If the distributed system picks consistency over 
availability, it will unavailable until the partition is fixed.  On the other hand, if it picks availabiity over consistency, it will return a response for a request bu thi
may not contain the most up to date data.




## Cassandara Concepts

### Keyspace
- analogus to the rdb concept of a database
- a key space groups a set of column families
- Column families are analogus to RDB tables 
- Column families form a domain
- You will set up a replication factor for Column families
- Replication factors are the number of replicas that this keyspace will have 
in different nodes.



    CREATE KEYSPACE ebook_chat WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };


    NOTE:  These keyspace settings are not suitable for a production enviroment.  In production, 
    you will want to set NetworkTopologyStrategy and a replication factor of at least 3.


### Column Family

- A column family is similar to a table in a relational databases 
- It stores the data in the form of rows and columns

    CREATE TABLE messages (
        username text,
        chatRoomId text,
        date timestamp,
        fromUser text,
        toUser text,
        text text,
        PRIMARY KEY ((username,chatRoomId), date)
    ) WITH CLUSTERING ORDER BY (date ASC);

### Primary Key
- A row is uniquely identified by a primary key
- Every column family must define a 
    * primary key which is composed of
        - partition keys
        - clustering keys 

- When there is more than one column that comprises the primary key, then the 
primary key is a composite primary key.
- You may query a cassandra column family via using either primary keys or indexes  


### Secondary Index
- A secondary index allows you to query a colun that is not part of the primary key.
- Remember tha adding secondary indexes will penalize the write performance 

### Partition Key

- The partition key is the left most term in the primary key's definition
- If a primary key is not composite, then the partition key is the same as the primary key
- A partion key may be a single column or multiple columns.
- A partition key that consists of multiple columns, then it is a composite partition key
- Example 

- The messages primary key contains (username, chatRoomId) composite partition key, which
essentially means that every message froma specific user in a particular chat room will be in the same partition


-  Partitions are groups of rows that share the same partiton key.
- This is important for achieving high performance and linear scalability in Cassandra
- When you issue a read request to Cassandra, you may need to fetcyh data from diffrent machines.
- Network latency will make this query slow
- Even if the partitions you are querying live on the same machine  (which also happens), the performance will be slower because of the way rows are stored internally in Cassandra.

- When it comes to modeling, to have the most optimized cluster, you must evenly spread the data amoun the nodes. So huge clusters will not help, and having a lot of partitions will not help either.  The hwrd work here is to find out the right partition key to evenly spread
the data among the nodes.



- Remember when it was suggested that you model your column families (analogus to RDB tables according ot the domain ) ?   It's absolutely true, but now I will add an extra note regarding Cassandra.  You must model your column families according to the domain while also thinking about how your data will be spread amount the partitions. 

- For example, suppose we want to moel a column family to store sensor temperature measures
every five seconds for all cities in all states of the country

- If our partiontion key consists of country along...then every write will go to the same partiion... That partition will basically be the entire column family.   Having large partitions aint the way to go if you really want to benefit from a distributed architecture.

- What if we changed the partition key to something like 

    (country, state, city)

- Now every sensor temperature measure in a specific city for a particular state of the USA will be stored in a different partition.

- Teh data looks much more spread out now, but there are still some issues.
- The city of New York has roughy 9 million inhabitants, whereas Mountain View is a small city in California that has only about, 80,000 people.  The delta here is significant and will likely result in unbalanced partitions.  Modeling partition keys 
isn't as easy as one might initially beleive.


### Clustering Key 

The `clustering key` consists of the primary key columns that don't belong to the partition key.


    PRIMARY KEY ((username, chatRoomId), date)

The date is the cluster key.  Basically, a clustering key tells Cassandra how the dta withing a partion is ordered.  In teh messages column family the date clustering key will keep  the messagesordered in ascending order 



## Cassasndra Key summary

- primary key 
    * primary key of row

- partion key 
    * primary key in addition of another column value(s) in the row  

- clustering key 
    * any column values  that are not part  of the primary/partition key


        CREATE TABLE messages (
            username text,
            chatRoomId text,
            date timestamp,
            fromUser text,
            toUser text,
            text text,
            PRIMARY KEY ((username,chatRoomId), date)
        ) WITH CLUSTERING ORDER BY (date ASC);





## Redis Use Cases

Because of its rich data structures, Redis can be used
for a wide variety of cases

- Caching
- Implementing counters for a number of page views
- Implementing highly performant queues 
- Implementing publish/subscribe
- Compiling metrics and statistics
- Storing Hypertext Transfer Protocol (HTTP) sessions
- Building rankings using sorted sets (an ordered set of items by score)
such as the most accessed chat rooms
- Performing operations in sets, such as getting the intersection between two sets


## An aside about the power of Redis....

You can easily evolve that chate application to include an "add friend" freature 
and store a user's firends in a set.  then you could have another set holding all the online users adn use the command 

    SINTER

command to extract the intersection bwtween these two sets in `O(M*M)` complexity
time.  The intersection would be the user's online firends.   
Kinda Amaze-balls.


Recis can be clustered both for replication and for sharding, and its distributed architectured is based on a master-slave model (the inverse of the purely peer-to-peer 
clustering architecture of Cassandra and thus is not able to provide the same consistency guarantees as Redis.......I mean...what if the master node crashes ?  Replication is kind of fucked...now isn't it ?) 

Again here...your domain should give you a hint whether taking this risk in production 
is acceptable.  Remember that Redis clusters penalize consistency to achieve extroidnary performance.....there is no magic bullet and no free lunch.....for each feature that you are provided that is optimal for some use case....you are likely going to use a feature or have a feature degraded that might also be useful to you.....


With all that being said....Redis will allow a write to master....return the success 
signal back to the client, and then asynchronously write the changes to all all the slave nodes.  


Redis also supports :
    - Monitoring
    - automatic failover
    - notifications via Redis Sentinel 



## Spring Projects

- Spring Boot
- Spring Data
- Spring MVC
- Spring Security
- Spring WebSocket 


### Spring Data JPA Repositories 

- Interacting with your relational database should not throw you into a 
panic anymore.  Just by configuring a data source in the `application.yml`
configuration file and creating a Java interfae extending from JpaRepository (which is a
Spring Data Interface) you will get many ready-to-use methods to manipulate your database using the 
Java Persistence API (JPA).  For instance, in the chat application, you have the followng 

        # application.yml configuration
        spring:
            datasource:
                url: jdbc:mysql://localhost:3306/ebook_chat
                username: root
                password: root
                testWhileIdle: true
                valdiationQuer: SELECT 1
            jpa:
                show-sql: true
                hibernate:
                    ddl-auto: validate
                    naming-strategy: org.hibernate.cfg.ImprovedNamingStrategy
                        properties:
                            hibernate:
                        dialect: org.hibernate.dialect.MySQL5Dialect


        // UserRepository interface 

        public interface UserRepository extends JpaRepository <User,String>{

            //User findByEmail(String email);


            /* We can abstract away the details of any native SQL dialect via JPQL */
            @Query("select u from User where u.name like %?1")
            List <User> findByNameEndsWith(String name); 

            /* Or we can opt to go with the native dialect of the RDB we are using */
            @Query(value = "select * from user where email = ?1", nativeQuery = true)
            User findyByEmail(String email);

        }


        // Associated Annotated JPA entity 

        @Entity
        @Table(name = "user")
        public class User {
            @Id,
            private String username ;
            private String password ;
            private String name ;
            private String email ;
            
            public setUsername(String username){
                this.username = username ;
            }
            public String getUsername(){
                return this.username ;
            }

            public setPassword(String password){
                this.username = username ;
            }
            public String getPassword(){
                return this.password ;
            }

            public setName(String name){
                this.name = name ;
            }
            public String getName(){
                return this.name ;
            }

            public setEmail(String email){
                this.email = email ;
            }
            public String getEmail(){
                return this.email ;
            }

        }




## Spring Data and NoSQL

- Persistence is more often than not the root cuase of limited scalability,
so chooosing the appropiate presistence technologies is crucial.

- Spring Data provides great integration with many supported NoSQL tools such as 
    * Cassandra
    * Redis
    * Neo4J
    * MongoDB 


    // implementation of the InstantMessageRepository for Cassandra

    public interface InstantMessageRepository extends CassandraRepository<InstantMessage> {

        List<InstantMessage> findInstantMessagesByUserNameAndChatRoomId(String username, String chatRoomId);
        
    }




    import org.springframework.cassandra.core.Ordering; 
    import org.springframework.cassandra.core.PrimaryKeyType;
    import org.springframework.data.cassandra.mapping.PrimaryKeyColumn; 
    import org.springframework.data.cassandra.mapping.Table;

    @Table("messages")
    public class InstantMessage {

        @PrimaryKeyColumn (name = "username"), ordinal = 0, type = PrimaryKeyType.PARTITIONED)
        private String username ;

        @PrimaryKeyColumn (name = "username"), ordinal = 1, type = PrimaryKeyType.PARTITIONED)
        private String chatRoomId ;

        @PrimaryKeyColumn (name = "date"), ordinal = 2, type = PrimaryKeyType.CLUSTERED, ordering = Ordering.ASCENDING)
        private Date date ;

    }



...and for Redis....


        import org.springframework.data.annotation.Id; 
        import org.springframework.data.redis.core.RedisHash;

        @RedisHash("chatrooms")
        public class ChatRoom {
            @Id
            private String id ;
            private String name ;
            private String description ;
            private List<ChatRoomUser> connectedUsers = new ArrayList<>() ;

            public void setId(String id){
                this.id = id ;
            }
            public String getId(){
                return this.id ;
            }

            public void setName(String name){
                this.name = name ;
            }
            public String getName(){
                return this.name ;
            }

            public void setDescription(String description){
                this.description = description ;
            }
            public String geDescription(){
                return this.description  ;
            }

            public void setConnectedUsers(List<ChatRoomUser> connectedUsers){
                this.connectedUsers = connectedUsers ;
            }

            public String getConnectedUsers(){
                return this.connectedUsers ;
            }
        }


