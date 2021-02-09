##Designing a Blockchain Architecture: Types, Use Cases, Challenges

ref link : [https://medium.com/mobindustry/designing-a-blockchain-architecture-types-use-cases-and-challenges-9894fb7b58e]

Main advantages of blockchain technology
=======================================================

1. There is no central authority to ovesee operations, the
   blockchian is an ideal regisster for joint business ventures
   
2. The digital signature and verfication process used in blockchains
   helps prevent fraudulent activity
   
3. Inforamtion isn't centralized, priventing it from being lost



##How it works
=============================================================
(genesis block)
+----------------+    +---------------+  +----------------+
| Hash: 1z8f     |    |Hash: 6bq1     |  |Hash: 3h4q      |
| Prev Hash: 0000+--->+Prev Hash: 1z8f+->+Prev Hash: 6bq1 |
+----------------+    +---------------+  +----------------+



1. Each block has a has, which you can compare to a fingerprint.
2. A hash identifies the block and al of its contents and is always
   unique, just as a fingerprint is.
   
3. Once a block is created, its hash is calculated.
   Changing anything inside the block will cause the hash to change
   
4. In other words, hashes are very useful when you want to detect
   changes to blocks.
   
5. If the hash of a block changes, it's no longer the same block

6. The third element inside each block is the hash of the previous block.
   This effectively creates a chain of blocks, and it is this
   technique tyhat makes a blockchain so secure.
   
   
## What happens when we tamper with the second block ?
 ===============================================================
(genesis block)       (tampered block)   (all subsequent blocks are now invalid)
+----------------+    +---------------+  +----------------+
| Hash: 1z8f     |    |Hash: h62y     |  |Hash: 3h4q      |
| Prev Hash: 0000+--->+Prev Hash: 1z8f+->+Prev Hash: 6bq1 |
+----------------+    +---------------+  +----------------+


1. changing the hash(because the data is used in the generation ofthe hash..)
   effectively invalidates the following blocks as invalid.
2. Hashes alone are not enough to prevent taampering.  Modern computers
   can calculate hundreds of thousands of hashes per second.  This means you 
   can effectively tamper with a block and recalculate all the hashes
   of other blocks to make your blockchain valid again.
   
3. **Proof of work** (POW) 
    -   POW is a mechanism for slowing down the creation of new blocks.
    -   For BitCoin...it takes 10 minues to calculate the 
        required POW and add a new block to the chain. this mechanism
        makes it difficult to tamper with blocks because if you tamper
        with one block, you will need to recalculate the POW for all the 
        following blocks.
    -   The security of a BC comes from it's create use of hashing 
        and the proof of work mechanism.
 4. **Distributed management of BC**
    -   Another security mechanism...
    -   A BC uses a P2P network that anyone is allowdd to join(assuming the BC is public)
    -   When someone joins this BC network, they become a node and gete a full copy of 
        the blockchain.  This node can then use the copy of the blockchain to verify
        that everything is in order.


##What happens when a blockchain node create a new block.....
=====================================================================
1. New block is sent to all nodes on the network
2. Each node verifies the block to make sure it hans't been tampered with.
    - Check if the prev-hash field matches
3. If verification is affirmed, each node adds this block to its own blockchain.
4. Nodes in the network eventually arrive at a consensus: they agree on which blocks
   are valid and which ones are not.
5. Blocks that have been tampered with will be regjeted by other nodes in the network.
   So to successfully tamper with a blockchain, you need to tamper with all the blocks
   on the chain....and then redo the proof of work for each block floowoing
   the block that has been tampered with, and take control of more than 50% of
   the P2P network.  This is practically impossible to do.
   
##Key characteristics of the blockchain architecture
=========================================================================
The blockchain architecture has many business benefits.   Here are some
built in characteristics:


1. Cryptography
    -BC transactions are verfified and trustworthy because of
     complext computations and cryptographic proof between the parties
     
     

2. Immutability
    -Records in a blockchain can't be modified or deleted.
    
3. Provernance
    -It is possible to trace the origin of each transaction in the 
     blockchain ledger
     
4. Decentralization
    -Every member of the BC structure is able to access the entire
     distributed database.  Unlike in a centralized system, a 
     consensus algorithm is responsible for network management.
     
5. Anonymity
    -Every member of the blockchain network has generated an address,
     no userIds  are utilized.  This preserves teh anonymity of users,
     especially in a public blockchain
     
     
6. Transparency
    -The blockchain system is unlikey to be damaged as it takes an
     enormous effort w/r to computing power to completely rewrite the 
     blockchain network




##Blockchain architecture explained
=======================================================
A blockchain is an open financial ledger or record which every
transaction is authenticated and authorized.  A blockchain is
designed as a decentralized network of millins of computers, commonly
referred to as nodes.  It's a distributed database architectue in which each node
plays the role of a network administrator who volutarily joins the network.
Since there is no centralized information in a blockchain architecture, a
blockchain is literally impossble to hack

The block chain architecture supports a growing list of ordered records known as
**blocks**.  Each block maintains a timestamp and a link to
the previous block.




##Components of a blockchain architecture
====================================================
Here are the main components of a blockchain architecture:

1. Node
    -   A computer in the block chain architecture(each node has an independent
        copy of the entire blockchain ledger)
        
2. Transaction
    -   A data record verfified by blockchain participants that
        serves as an almost immutable confirmation of the the
        authenticity of a financial transaction or contract
        
3. Block
    -   A sealed data compartment that contains : 
        --  A native hash code that identifies the block
        --  The hash code from the previous block in the
            sequence of blocks
        --  A sete of timestamped transactions
        
4. Miners
    -   Nodes that validate blocks before adding them to the blockchain structure
    
5. Consensus(protocol) 
    -   A set of rules and greements for performing blockchain operations
    
    
    
    
##Types of blockchain architectures
====================================================
-   Public BlockChain architectures operate on teh 
    basis of proof of work (PoW) consensus algortithms
    and uses appropriate protocols.
      
-   A public blockchain doesn't need any permission, as it's open-source.
    You can define new blocks with their existing state, as this is open-source.
    You can also download a blockchain's code and check transactions on 
    the network.
    
##Private blockcahin architecture
=====================================================
-   A private blockchain architecture allows only a certain group of participants
    (organizations or people) to access information.  Such blockchain
    architectures are built by organizations with the aim of increasing
    the overall benefit or efficiency.
    
-   Their reliability is ensured by the common goals of the
    participants and **Proof of Stake** (pos) and Byzantine fault 
    tolerance (BFT) consensus algorithms.
    
-   A private BlockChain architecture decouples the main blockchain
    protocol from tech smart contract layer  Using a private blockchain, you
    can open up a programmable tranaction area commonly called a smart contract as well 
    as online markets.
    
 ##Consortium blockchain architecture
 =====================================================
 -  There's also a consortiu, or public permissioned, blockchain architecture.
 -  Anyone can connect to an view the blockchain
    but  aparticipant can add information or connect a node only 
    with the permission of other participants.
 -  Such blockchains are built by organizations in order to increase 
    trust among customers, consuemr or society as a whole
 -  Here, reliablility is also achieved by the presence of trust between
    participants and the same PoS  and BFT consensus algoriths

##Centralization and DeCentralization of BlockChains in reality is a bit more fuzzy than let on..
=========================================================================================
-   Depending on the type of blockchain structure and its context, a 
    blockchain system can be more centralized or decentralized.

-   This just referes to the design of the blockchain architecture and who controls the 
    ledger.
    
-   Private blockchains are considered centralized, as its controlled by
    a specific group with increased privacy.
    
-   Public blockchains are considered dectenralized by contrast.

-   From an efficiency standpoint, the time required to 
    confirm each transaction on a public blockchain is also not
    enviormentally friendly, as it requires huge processing power
    compared to a private blockchain architecture.
    
 


























