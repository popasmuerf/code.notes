[source](https://www.tutorialspoint.com/neo4j/neo4j_data_model.htm)



## Neo4j Property Graph Data Model ?
Neo4j Graph Database follows the Property Graph Model
to store and manage its data.

- The model represents data in 
    *   Nodes
    *   Relationships
    *   Properties
    
- Properties are key-value pairs
- Nodes are represented using circles and Relationships
  are represented using arrow keys
- Relationships have directions
    *   Uni-directional
    *   Bi-directional
- Each Relationship conatins 
    *   Start Node
    *   From Node
    *   To Node 
    *   End Node
    
- Both Nodes and Relationsships contain properties
- Relationships connects nodes


In The Property Graph Data Model, relationships should be
directional.  If we try to create relationships without 
direction, then it will throw an error message.


In Neo4j, relationshps should accordingling be directional.
All data is encapsulated by Nodes and their Relationships.  
We neither need any additional RRBMS Database nor any SQL
database to store Neo4j data; as it stores its data in terms of
Graphs in its native format.

Neo4j uses Native GPE(Graph Processing Engine) to work with
its Native graph storage format

The main building blocks of GRpah DB Model are --
* Nodes
* Relationships
* Properties 

Following is a simple example of a Property Graph 








Graph database is a database used to model the data in the 
form of a graph.  In here, the nodes of a graph depict the
entities while the relationships depict the association of 
these nodes.

## Popular Graph Databases

Neo4j is a popular Graph Database. Other Graph Databases are Oracle NoSQL Database, OrientDB, HypherGraphDB, GraphBase, InfiniteGraph, and AllegroGraph.



## Why Graph Databases ?
Nowadays, most of the data exists in the form of the 
relationship between different objects and more often, the
relationship between the data is more valuable than the
data itself.

Relational databases store highly structured data which have
several records storing the same type of data so they can be used to store structured data and, they do not store the relationships between the data

## Advantages of Neo4j

Following are the advantages of Neo4j

1.Flexible data model
2.Real-time insights
3.High availability
4.Connected and semi structures data
5.E$asy retrieval
6.Cypher query language4
7.No joins



<div>
    <style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-0pky">Sr. No<br></th>
    <th class="tg-0pky">RDBMS</th>
    <th class="tg-0pky">Graph Database<br></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0pky">1</td>
    <td class="tg-0pky">Tables<br></td>
    <td class="tg-0pky">Graphs</td>
  </tr>
  <tr>
    <td class="tg-0pky">2</td>
    <td class="tg-0pky">Rows<br></td>
    <td class="tg-0pky">Nodes<br><br></td>
  </tr>
  <tr>
    <td class="tg-0pky">3<br></td>
    <td class="tg-0pky">Columns and Data<br></td>
    <td class="tg-0pky">Properties and its values<br><br></td>
  </tr>
  <tr>
    <td class="tg-0pky">4</td>
    <td class="tg-0pky">Constraints<br></td>
    <td class="tg-0pky">Relationships</td>
  </tr>
  <tr>
    <td class="tg-0pky">5</td>
    <td class="tg-0pky">Joins</td>
    <td class="tg-0pky">Traversal</td>
  </tr>
</tbody>
</table>


</div>
