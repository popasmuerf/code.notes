##How to make a private blockcahin architecture
==================================================
url Creating a blockchain network :[https://medium.com/mobindustry/designing-a-blockchain-architecture-types-use-cases-and-challenges-9894fb7b58e]


What we need...

1.  A functional Specification....
2.  This Functional Specification requires a UI/UX design
3.  This Functional Specification rqures an architectual plan./



It's imperative that we defint eh application's
    -   Functionality
    -   establish user roles
    -   Consider the system flow and interactions between users.
    
    
    
To build your own blockchain architecture, you need to consider:

    -   The infrastructure of an application hosted in a defined
        enviroment within one or more organizations
        
    -   The tasks and purposes for which this blockchain solution is being
        designed.
        
        
        
        
There are several open-source solutions you can use to create a private
blockchain architecture.



##Creating a blockchain network
=================================================================
As soon as an organization or mutiple organizations decide to implement
a blockchain solution, they already creage a network.  The network can 
viewed as a company with its own staff, or in terms of the technical 
infrastructure within these companies.

Let's consider an example of a blockchain architecture for the 
production and sale of gold jewelry.
The parties invoved in this network include :

    -   Gold mining companies
    -   Government institutiones
    -   Gold transporters
    -   Gold sellers 
    -   Goldsmiths
    
    
A blockchain solution can bring together all tese parties in a P2P
network tha teliminates all risks and builds a transparent system.

All network participants will have access to synchronized data from the shared,
immutable ledger and will be able to  to tracke the movement of gold from its
extraction to its sale to the end consumer in the form of jewelry.  The 
blockchain ledger will contain the sequence of all activities taking place, for
example, mining, processing, and distribution.


Usually, each party in the network keeps its own copy of the blockchain, 
which is synchronized wit hthe smart protocols and technical layers of the
blockchain netwok.

For multiple users, there is a membership service provider (MSP) that allows
access to specific users on the network.


All transaactions along the way are stored in teh general ledger( for example , daimond images,
data on daimond's mining location, color, and serial number...etc




 


                             User Compoonser to create
                             Business Network Definition

+-----------------------+ +---------------------+ +---------------------+  +------------------------+
| Asserts Participants  | |Transaction          | |Access Control       |  |Query                   |
| Transformations       | |Functions            | |rules                |  |Definitions             |
| --------------------- | +---------------------+ +---------------------+  +---------------------   |
| Model File            | |Script File          | |Access Control       |  |Query File              |
| .cto                  | |.js                  | |.acl                 |  |.qry                    |
|                       | |                     | |                     |  |                        |
+---------+-------------+ +---------+-----------+ +---------+-----------+  ++-----------------------+
          |                         |                       |               |
          +-------------------------+-----+-----------------+-----------+---+Package up your
                                          |                                  Business Network Definition
                            +-------------+--------------+                  and export it as an archive
                            | Business Network Archive   |                  (.bna file) ready to deploy
                            | .bna                       |                  somewhere
                            +-------------+--------------+
                                          |
+-------------------+                     |              +--------------------+
| Hyperledger Fabric+---------------------+--------------+ Web Browser/Node.js|    Use ID Cards
| Cloud/Local       |                                    | Online             |    (which include
+-------------------+                                    +--------------------+    connection profiles and
                                                                                   credentials) to deploy
                                                                                   your Business Network
                                                                                   Definition to a
                                                                                   distributed ledger
                                         


##Business Network Definition
==========================================
   1. Data Model
   2. Business Logic
   3. Access Control Lists
   4. Query definitions 

##Business Network Archive
==========================================
   1. HyperLedger Fabric
   2. Cloud/Local



##Client
   1. Web Browser
   2. Node.js
        


###Creating blockchain code
==========================================
After the blockchain network is set up, the next
steep is to agree on the tyhpe of business
transactions happening inside the blockchain
architecture.


Typeically, these rules are written in legal argeements.  In the 
blockchain code, these agreements are written in the form of
smart contracts(also known as Chaincode or Busines Network Definition
in HyperLedger Composer).

Just like a tradtional contract, a blockcahin caontract contains
participants, assets, and transactions.

For every transactions, a transactional processor function is written (in JS)
that describes what happens after the transaction is created.


###Skills required to build a blockchain architecture
-   Computer science background
-   cryptography
-   Consensus Methds
-   Data Structures
-   Decentralized Ledgers
-   Data Security.


