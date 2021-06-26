## Consistency 


*   Strong consistency 
    *   Synchronous replication to all replica nodes
    *   Speed of convergence is effected by number of nodes

*   Eventual consistency 
    *   Asynchronous replication to all replica nodes
    *   Consensus is fasters than synchronous but not consistency of data across all nodes is not guaranteed within any particular time frame
    *   Is more scalable 
    *   Examples: Not everyone will see your status update at the same stime on social media.....

*   Read-after-Write Consistency 
    *   Inserts are immediately available
        *   However, updates would have eventual consistency