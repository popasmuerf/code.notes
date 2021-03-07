#Simple Guid to Connection Pooling in Java
==========================================

url: Spring Guide to Connection Pooling in Java



#Overview
Connnection pooling is well-known data access pattern, 
whose main purpose is to reduce the overhead involved in 
performing data connections and read/write database operations.

In a nutshell, a connection pools is at the most basic level, a database
connection cache implemention, which can be configured to suit specific 
requirements.

In this tutorial, we will make a quick round ou of a few popular conection
pooling frameworks, and we will learn how to implement from scratch our own 
connection pool.



##Why Connection Pooling ?


The question is rhetorical of course...right ?



If we analyze the sequence of steps involved in a typical database
connection life cycle, we will understand the sequence of steps involved
in a typical database connection ife cycle, we will undertand why

1. Opening a connection tot hethe database using the database driver
2. Opening a TCP socket for reading/writing data
3. Reading / writing data over the socket
4. Closing the connection 
5. Closing the socket



Database connections are fairly expensive operations, and as such,
should be reduced to a minimum in every possible use case (in edge cases, 
just avoided)


Here's where connection pooling implemenations come into play.

By just simply implementin a database connection container, which allows
us to reuse a number of existing conections we can effectively save
the cost of performing a huge number of expenisve
database trips, hence boosing the overall performance
of our  database-driven applications.




##3. JDBC Connection Pooling Frameworks
----------------------------------------------------
Froma pramatic perspective, implementing a connection pool from a the 
groud up is just pointless, considering the number of "enterprise-ready"
connection  pooling frame works avalable out there.


####3.1 JDBC Connection Pooling Frameworks
----------------------------------------------------
Let's start this quick roundup with Apache Commons DBCP Component, a full-featured
connection pooling JDBC framework

        public class DBCPDataSource {
            
            private static BasicDataSource ds = new BasicDataSource();
            
            static {
                ds.setUrl("jdbc:h2:mem:test");
                ds.setUsername("user");
                ds.setPassword("password");
                ds.setMinIdle(5);
                ds.setMaxIdle(10);
                ds.setMaxOpenPreparedStatements(100);
            }
            
            public static Connection getConnection() throws SQLException {
                return ds.getConnection();
            }
            
            private DBCPDataSource(){ }
        }



In this case, we've used a wrapper class with a static block to easily configure DBCP's properties.

Here's how to get a pooled connection with the DBCPDataSource class:

        Connection con = DBCPDataSource.getConnection() ;


####3.2 HikariCP
----------------------------------------------------
Moving on, let's look at HikariCP, a lighting fast JDBC connection
pooling framework created by BrettWooldridge(for the full details on how to configure
and get th emost out of HikariCP, please check this article[https://www.baeldung.com/hikaricp]):

        public class HikariCPDataSource {
            
            private static HikariConfig config = new HikariConfig();
            private static HikariDataSource ds;
            
            static {
                config.setJdbcUrl("jdbc:h2:mem:test");
                config.setUsername("user");
                config.setPassword("password");
                config.addDataSourceProperty("cachePrepStmts", "true");
                config.addDataSourceProperty("prepStmtCacheSize", "250");
                config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
                ds = new HikariDataSource(config);
            }
            
            public static Connection getConnection() throws SQLException {
                return ds.getConnection();
            }
            
            private HikariCPDataSource(){}
        }


In this case, we've used a wrapper class with a static block to easily configure DBCP's properties.

Here's how to get a pooled connection with the DBCPDataSource class:

        Connection con = DBCPDataSource.getConnection() ;

####3.3  CP30
-----------------------------------------------------------
        public class C3poDataSource {

            private static ComboPooledDataSource cpds = new ComboPooledDataSource();

            static {
                try {
                    cpds.setDriverClass("org.h2.Driver");
                    cpds.setJdbcUrl("jdbc:h2:mem:test");
                    cpds.setUser("user");
                    cpds.setPassword("password");
                } catch (PropertyVetoException e) {
                    // handle the exception
                }
            }
            
            public static Connection getConnection() throws SQLException {
                return cpds.getConnection();
            }
            
            private C3poDataSource(){}
        }
        
As expected, getting a pooled connection with the C3PODatasource Class is 
similar to the previous examples:

Connection con = C3poDataSource.getConnection(); 
        

####4. A simple Implementation

To better understand the underlying logic of connection pooling, let's
create a simple implementation.

Let's start out with a loosely-coupled design, based on just one single interface:


        public interface ConnectionPool {
            Connection getConnection();
            boolean releaseConnection(Connection connection);
            String getUrl();
            String getUser();
            String getPassword();
        }


The ConnectionPool interface defines the public API of a basic connection pool.
Now, let's create an implemenation, which provides some basic functionality, including
getting and releasing apooled connection.


public class BasicConnectionPool implements ConnectionPool{

    private String url;
    private String user ;
    private String password ;
    private List<Connection> connectionPool ;
    private List<Connection> usedConnections = new ArrayList<>();
    
    public static BasicConnectionPool create(
        String url,
        String user,
        String password) throws SQLException{
                    List<Connection> pool = new ArrayList<>(INITIAL_POOL_SIZE);
                    for (int i = 0; i < INITIAL_POOL_SIZE; i++) {
                        pool.add(createConnection(url, user, password));
                    }
                    return new BasicConnectionPool(url, user, password, pool);   
        };


        // standard constructors
    
    @Override
    public Connection getConnection() {
        Connection connection = connectionPool
          .remove(connectionPool.size() - 1);
        usedConnections.add(connection);
        return connection;
    }
    
    @Override
    public boolean releaseConnection(Connection connection) {
        connectionPool.add(connection);
        return usedConnections.remove(connection);
    }
    
    private static Connection createConnection(
      String url, String user, String password) 
      throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }
    
    public int getSize() {
        return connectionPool.size() + usedConnections.size();
    }

    // standard getters

}
