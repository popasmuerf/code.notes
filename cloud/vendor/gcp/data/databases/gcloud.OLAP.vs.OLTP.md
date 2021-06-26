## Relational Databases - OLAP vs OLTP


*   OLAP and OLTP use similar data structures
*   But very different approaches in how data is stord
*   OLTP databases use row storage
    *   Each table row is stored together
    *   Efficient for processing small transasctions

*   OLAP databases use columnar storage
    *   Each table column is stored together
    *   High Compression stores petabyets of data efficiently