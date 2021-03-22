"The major difference between a thing that might go wrong
and a thing that cannot possibly go wrong is taht when a thing
that cannot possibly go wrong goes wrong it usually turns
out to be impossible to get at or repair."
 --- Douglas Adams, Mostly Harmless (1992)

Replication means keeping a copy of the same data on multile machines
that are connected via a network.  As discussed in the introduction to 
to PartII, there are several reasons why you might want to replicate
data:

-   To keep data geographically close to your users (and thus reduce latency)

-   To allow the system to continue working even if some of its parts
    have failed (and thus increasing availability)
    
-   To scale out the number of machines that can serve read queries
    and thus increase erad throughput)

There are various reasons why you might want to distribute a database
across multple machines:

***Scalability***
    If your data volume, read load, or write load grows bigger than
    a single machine can handle, you can potentially sprad the load
    across mutilple machines.
    
***Fault tolerance/high availability***
    If your appliation needs to continue working even if one machine
    (or several machines , or the netowrk, or an entire datacenter) goes
    down, you can use multiple machines to give you redundancy.  When one 
    fails, another one can take over.
    
***Latency***
    If you have users around the world, you might want to have servers at
    various loations worldwide so that each user can be served from a 
    datacenter that is geographically close to them.  That avoids
    the users having to wait for network packets to travel
    halfway around the world.
    
    
***Drawbacks***

While distributed shared-nothing architecture has many advantages,
it usually also incurs additional complexity for application and
sometimes limits the expressiveness of the data models you can use.

In many cases, a simple single-threaded program can peform significantly better thaqn
a cluster with oover 100 CPU cores.  On the other hand, shared-nothing systems can
be very powerful...
    
 
 
 In this chapter we will assume that our dataset is so small that each machine
 can hold a copy of the entire dta   
    
##Replication Versus Partitioning
There are two common ways data is distributed across multiple nodes:

    -   Replication
        Keeping a copy of the same data on several differnet nodes,
        pontentially in different locations.  Replication provides
        redundancy:  If some nodes are unavailable, th edata can still
        be served from the remaining nodes.
        Replication can also help improve peformance.  
        
    -   Partitioning
        Splitting a big database into smaller subsets called partitions
        so that different partitions can be assigned to different nodes
        AKA as **sharding**.
        

┌──────────────────────────────────────────────┐
│Partion 1, Replica 1                          │
│                                              │
│136-->            211-->           377-->     │
│Four score        Johanes          Whereas    │
│and seven         Dei gracia       recognition│
│years ago         Rex Anglie,      of the     │
│our fathers       Dominus          inherent   │
└──────────────────────────────────┬────▲──────┘   copy of the
                                   │    │          same data
                                   │    │
┌──────────────────────────────────▼────┴────────┐
│Partion 1, Replica 2                            │
│                                                │
│136-->            211-->            377-->      │
│Four score        Johanes           Whereas     │
│and seven         Dei gracia        recongnition│
│years ago         Rex Anglie,       of the      │
│our fathers       Dominus           inherent    │
└────────────────────────────────────────────────┘






 ┌──────────────────────────────────────────────┐
 │Partion 2, Replica 1                          │
 │                                              │
 │629-->            696-->           858-->     │
 │DierWurdee        Whereas          Weehold    │
 │des Menschen      the Lordsa       thesentruth│
 │schen ist         Spirituale,      to beeself │
 │unamtastbar       andiTempo        evidentt   │
 └──────────────────────────────────┬────▲──────┘   copy of the
                                    │    │          same data
                                    │    │
 ┌──────────────────────────────────▼────┴────────┐
 │Partion 2, Replica 2                            │
 │                                                │
 │629-->            696-->            858-->      │
 │DierWurdee        Whereas           Whereas     │
 │des Menschen      the Lordsa        recongnition│
 │schen ist         Spirituale,       of the      │
 │unamtastbar       andiTempo         inherent    │
 └────────────────────────────────────────────────┘

    
    
In a large macine, although any CPU can access any part of
memory, some bansk of memory are closer to one CPU than others
(this is called nonuniform memory access, or NUMA). To make
efficient use of this architecture, the processing needs
to be broken down so that each CPU mmostly accesses memory that
is nearby, meaning that pasrtitioning is still required, even when
ostensibly running on one machine
    
        



If all you need is to scale to higher load, the simplest approach is to 
buy a more powerful machine(AKA as vertical scaling up).  Many CPUs,
many RAM chips, and many disks can be joined together under one operating
system, and a fast interconnect allows any CPU to access any part of the memory
or disk.


The problem with shared-memory approach is that the cost grows faster than
linearly:  a machine with twice as many CPUs, twice as much
RAM, and twice as much disk capacity asanother typically costs
significantly more than twice tas much.....also due to bottlnecks, a
machine twice the size cannot necersarily handle twice the load.


##Shared-Nothing Architectures
Another approache is the shared-disk architecture, which uses several machines
with indepenent CPUs and RAM, but stores data on an array of
disks that is shared between the machines, which are connected via a 
fast network.   This architecture is used for some data warehousing workloads,
but contention and the overhead of locking limit the scalability of the
shared-disk approach.

##Shared-Nothing Architectures
....have gained a lot of popularityh....
This approach has each machine or virtual machine running the database sofware
on a **node**.  Eeach node uses it's CPUs, RAM , and disks indempendently.
Any coordination between nodes is done at the sofware level, using a 
convential network.

    -   No special hardware is required by a shared-nothing system so 
        So whatever manchines have the best price/performance ration will do
        -   x86
        -   ARM
        -   Apple Silicon
        -   RISC
        -   laptop
        -   It don't matter
        
You can potentialy distribute data across multiple geographic
regions,and thus reduce latency for users and potentialy be ale to 
survive the loss of an entire datacenter.


While a distributed shared-nothing architecutre has many advantages, it 
usually also incurs additional complexity
























In most cases a change to an application's features
alos requires a change to data that it stores: perhaps
a new field or record type needs to be cauptured, or
perhaps existing data needs to be presented in a new way.


-Relational databases generally assume that all data in the
database conforms to one schema
    --  Shcemas can be changed
    --  Only one schema may be in force at any given time
-Schema on Read(schemaless) databaes don't enforce
a schema so the databse can contain a mixture of older 
and newer data formats written at different times


Changes in data format or schema often brings with it a change
in the business logic associated with this data.


-   Server-side applications
    --  Rolling upgrades(also known as staged roll-outs)
        ; deploying the new version to a few nodes
        at a time, checking whether the new version is
        running smoothly, and gradually working
        your way through all the nodes.
    --  Reduces or elminates system downtme, and thus
        encourages more frequent releases and better
        evolvability
        
-   Client-side applications
    --  method of updating is up to what is acceptable to the particular
        user experience, meaning that the upgrade must accure to the user
        as if it never happened in the first place.
    --  users may not install the update for some time.....
    



##Formats for Encoding Data
Programs usually work with data in (at least) two different
representations:

1.  In memory
    -   data is kept in
        --  objects
        --  structs
        --  lists
        --  arrays
        --  hash tables
        --  trees
        --  etc
2.  When weiting data to a file or sedning it
    over the network you have to encode it
    as some kind of self-contained sequence of bytes
    ...for example...these sequence of bytes can take
    the form of JSON.  If there is no agreed upon format..
    a popular option is to transmit the sequene of bytes
    encoded as Base64.
    
3. Since pointers wouldn't make much sense to any other process, the
   sequence-of-bytes to any other process, this
   sequence-of-bytes representations(obj, stuct, array, etc) looks
   quite different from the data structures that are normally
   used in memory.
    -   We need some kind of translation between
        the two represetnations.
    -   The translation from memory representation to byte sequence
        is called encoding(also know as serialization or marshalling)
    -   Marshalling is the reverse of decoding(parsing, deseraializaing,
        unmarshalling)
        
 
    
    
##Language-Specific Formats

Many programming languages come with built in support
for encoding in-memory objects into byte sequences.

-   Java
    --  java.io.Serializable
-   Ruby
    --  Marshal
-   Python
    -- Pickle
    
-   3rd Party
    --  Kyro
    
    
    
These built in encoding support is convienient as they
reduce the amount of logic written on the programmer's behalf
to achieve the encoding of in memory data....
However there are some drawbacks...

-   The encoding is often propritary to that particular 
    programming language, and reading this encoded data 
    in another programming language is difficult.  Progamming
    languages often tend to be their own platform in a sense.
    Commiting yourself to a language specific progr
    
-   In order to restore data in the same object types,
    the decoding process needs to be able to instantiate
    arbitrary classes.  This is frequently the soures
    of security problems.  If an attacker can get your 
    application to decode an arbitrary byte sequence, they can 
    instantiate aribtrary classes, which in turn allows them to
    do terrible things such as remotely execute arbitrary code.
    
-   Versioning data is often an afterthought for these libraries

-   Efficiency (CPU time taken to encode or decode, and the 
    size of the encoded structure) is also often an afterthought.
    Java's built-in serialization is notorious for its bad performance
    and bloated encoded
    
    
    
###Text based alternatives
-   JSON
    - Popularity is mainly due to it's built-in support
        in wb browsers via virture of being a subset of
        JavaScript.
-   XML
    -   Critisized for being too verbose and needlessly
        complicated.
-   CSV
    -   another popular platform independent format, 
        though less powerful than either JSON or XML
        
All of these text formats are somewhat human readable....but also
posess some subtle problems

-   Ambiguity around the encoding of numbers.
-   In XML and CSV, there is no distinguishment between
    what is meant to be a number or a string that happens
    to be composed of digits...save for referring to an external
    schema.
-   JSON natively distinguishes between strings and numbers, but
    not between integers and floating-point numbers, nor percision.
    This is a problem when dealing with numbers with a large amount
    of digits.  For example, integers greter than 2^53 cannot
    be exactly represented in an IEEE 754 double-precision 
    floating-point number, so wuch numbers become inaccurate when
    parsed in a language that uses floating point numbers suha as JavScript
    
    
    
    An example of numbers larger than 2^253 occurs on Twitter, which
    uses a 64-bit number to identify each tweet.  The JSON returned
    by Twitter's API indluces tweet IDs twice, one as a 
    JSON number and once as a decimal string, to work around
    the fact that numbers are not correctly parsed by JavaScript 
    applicatons.
    
    
 -  JSON and XML have good support for Unicode character strings
    i.e., human -readable text), but 
    they don't support binary strings sequences of bytes without
    character encoding). Binary strings are a useful feature,
    so people get around this limitation by encoding the binary
    data as text using Base64.  The chema is then used to indicate
    the value should be interpreted as Base64-encoded.  This works, but
    it is somewhat of a hack and crases the data size by 33%...thus
    enacting both a storage and performance hit.
    
    
 -  Schema support for both JSON and XML are optional; schemas are
    powerful in this context and are diffilute to learn and implement.
    Use of XML schemas is fairly widespread, but many SJON-based tools do't
    bother using schemas.
    
 -  Since the correct interpretation of data depends on information in 
    the schema, applications that don't use XML/JSON schemas need to 
    potentially hardcode the appropiate encoding/decoding logic
    instad.
    
 -  CSV does not have any schema, so it is up tothe application to 
    define the meaning of each row and cloumn.  If an application
    change addes a new row or column, you have to handle that change manually.
    CSV is also a quite vauge format(what happens if a value contains a comma or
    a newline character?).  Although its escaping rules have
    been formally specified, not all parsers implement them correctly.
 
 
 -  All their issues aside...text formats of data exchange are usually good enough.
    for most purposes....
    
    
    
    
##Binary Encoding

For data that is used only internally..within your organization, there is less pressure to use lowest common-denominator encoding format.  For example, you 
could choose a format that is more compact or faster to parse.

For a small dataset, the gains are negligible, but once you get into the
terabtyes; the choice of data format can have big impact.

JSON is less verbose than XML, but both still use a lot
of space compared to binary formats.  This observation led
to the development of profusino of binary encoding for JSON:
    -   BSON
    -   MessagePack,
    -   BJSON
    -   UBJSON
    -   BISON
    -   Smile
    -   etc.
    
Binary encoding for  XML
    -   WBXL
    -   Fast Infoset
    
Binary encoding of XML and JSON definitely have their niches....but
are no where near as popular as text version of JSON and XML

Some of these formats extend the set of of datatypes distinguishing
    -   integers
    -   floating-point numbers
    -   adding support for binary strings 
    
    
    
Snce they don't prescribe a schema, they need to include all the object field
names within the encoded data.

Example 4-1.  example record which we ill encode in 
Severyal binary formats this chapter...


        {
            "userName": "Martin",
            "favoriteNumber": 1337,
            "interests":["daydreaming", "hacking"]

        }
    
    
###MessagePack(Binary encoding for JSON)

MessagePack binary encoding for JSON displying the byte
sequence that you get if you encode the JSON document

1. First byte, 0x83, indicates that what follows
is an object with three fields
    -   top four bits = 0x80 (this is an object)
    -   bottom four bits = 0x03 (this object has 3 fields if this
        object has 15 fields...then 0x15)
2.  The second byte, 0xa8, indicates that what follows is 
    a string (top four bits = 0xa0) that is eight bytes
    long (bottom four bits = 0x08).
    
3.  The next eight bytes are the field name userName in ASCII.
    Since the length was indicated preiously, there's no 
    no need for any marker to tell us where the string ends
    (or any escapting).
    
4.  The next seven bytes encode the six-letter string value **Martin** 
    with a prefix 0xa6, and so on.
    
    The binary encoding is 66 bytes long, which is only a little less than
    81 bytes taken by the textural JSOn encoding (with whitespace removed).
    All the binary encodings of JSON are similar in this regard.
    It's not clear whether such a small sapce (and perhaps a spedup in parsing)
    is worth human readability.
    
    In the following sections we wilol see  how we can do much better
    and encode the same record in just 32 bytes/
    
    
    

        {
            "userName": "Martin",
            "favoriteNumber": 1337,
            "interests":["daydreaming", "hacking"]

        }
    
    
    ###MessagePack serialization/encoding of the above JSON
    
    object entry
    83 
    
    length
    a8
    
    strlen      userName                    string(length 6)    Martin
    ae          75 73 65 72 4e 61 6d 65     a6                  4d 61 72 74 69 6e
    
    unint       favoriteNumber              number(lengh 4)     1337
    cd          66 61 76 6f 72 69 74 .....  ..............      .....
    
    ...         ....                ......  ..............      .......
    
    
    
    ##  Thrift and Protocol Buffers
    Apache Thrift and Protocol Buffers(protobuf) are binary encoding 
    libraries that are based on the same principle.  
    
    Protocol Buffers were originally developed at Google, Thrift was originally developed
    at Facbook, and bother were made open source in 2007-08.
    
    
    Both Thrift and Protocoal Buffers require a schema for any data that is encoded.
    To encode the data in Thrift, you would describe the schema in the 
    Thrfit interface definition language (IDL) like this:
    
    //Thrift example schema
    struct Person{
        1:  required string         userName,
        2:  optional i64            favoriteNumber,
        3:  optional list<string>   interests
    }
    
    //Protocol Buffer schema example
    message Person{
        required string user_name = 1 ;
        optional int64 favorite_number = 2 ;
        repeated string interests = 3 ;
    }
    
    
    
Thrift and Protocol Buffers each come with a code generation tool
that takes a schema definition like the ones shown here, and produces classes
that implement the schema in various programming languages.

Your application code acn call this generated code to encode or decode recordsf
of the schema.

What does data endoded with this schema look like ?  Confusingly, Thrift has
tow different binary encoding formats, called **BinaryProtocol** and 
**CompactProtocol**, respectively.  Let's look at Binary Protocol first.  


##Thrift BinaryProtocol

        //JSON Object
   
        {
            "userName": "Martin",
            "favoriteNumber": 1337,
            "interests":["daydreaming", "hacking"]

        }
    
    
        //Thrift example schema
        struct Person{
            1:  required string         userName,
            2:  optional i64            favoriteNumber,
            3:  optional list<string>   interests
        }


//Thrift Breakdown...


        
    object entry
    83 
    
    length
    a8
    
type 11(str)    field tag =1                 string(length 6)    Martin
    ae          00 01                        00 00 00 a6         4d 61 72 74 69 6e
    
type 11(str)    field tag =2                 1337
    0a          00 02                        00 00 00 00 00 00 05 39  
           
type 11(str)    field tag =2                 item type 11(str)   2 list items
    0f          00 023                       0b                  00 00 00 02
    
                length 11                    daydreaming
                00 00 00 0b                  64 61 79 64 72 65 61 6d 69 6e 67
                length 7                     daydreaming
                00 00 00 0b                  68 61 63 6b 69 6e 67
             
 
In the example above....encoding allows us to squeeze this data into about 34 bytes.....
that is because we abstract away field tags with integer designations.....we can reconstitute 
the data using the already established schema.

-The field and it's value are placed into a single byte
-The field is given a numeric representation given the particular schema    








##Field tags and schema evolution
-------------------------------------------
We said previously that schemas inevitably need to change over time.  We call 
this schema **evolution** .  How do Thrift and Protocol Buffers handle schema changes
while keeping backwared and forward compaitbility?



    
    
    
    
##Protocol Buffers BinaryProtocol

Finally Protocol Buffers(PB) enfcodes the same data as shown belows.
It does the bit packing slightly differntly, but is 
otherwise very similar to Thrift's CompanctProtocol.  Protocol Buffers
fits the same record in 33 bytes


##The Merits of Schemas


As we saw, Protocol Buffers, Thrift, and Avro all use a schema to describe a
binary encoding format.  their scheam languages are much simpler than XML Schema
or JSON schema, which support much more detailed validation rules.
As  Protocol Buffers , Thrift  and Avro are simpler to implemente and simpler to 
use, they have grown to support a fairly wide range of programming languages.

The ideas on which these encodings are based are by no means new.

for example, they have a lot in common with ASN.1, a schema definition language
that was first standardized in 1984.  It was used to define various netework protocols,
and its binary encoding  (DER) is still used to encode SSL certificates (X.509), for
example, ASN.1 supports schema evolution using tag numbers, similar to 
Protocol Buffers and Thrift, However, it is also very complex an dbadly documented....
so you might want to forgo using ASN.1.


Many data systems also implement some kind of proprietary binary encoding for their data.
For example, most relational databases have a network protocol over which you can send 
queries to the database and get back respnses.  Those protocols
are generally specific to a particular database, and the database vendor provides
a driver(using teh ODBC o JDBC APIs) that decodes responses from the
database's network protocol into in memory data structures.


So, we can see that although textual data formats such as JSON, XML, and CSV
are weidespread, binary encodings based on schemas are also a viable option.
They have a number of nice properties:

-   can be much more compact than the vrious binary JSON variants, since they can
    omit field names fromt he encoded data
-   The schema is a valuable form of documentatio, and because the schema is required for
    decoding, you can be sure that it is up to date( whereas manually maintained 
    documentation may esily diverge from reality)
-   Keeping database of schemas allows you to check forward and backward compatibility
    of schema changes, before anything is deployed.
-   Statically typed programming languages, the ability to generate code from the 
    schema is sueful, since it enables type checking at compile time.












    





#Modes of Dataflow
==============================================
Whenever we want to send some data to another process with 
which we dont' share memory --- for example, whenver 
we want to send dta over the network or write it to a file...
we need to encode it as a sequence of bytes.  We then discussed a variety
of different encodings for doing this.




#Dataflow through databases
==================================================
In a datbase,  the process that writes to the database encodes the 
data, and the process that reads from the database decodes  it.

Thre may just be a single process accessing the database,
in which case the reader is simply a later version of the same 
process --- in that case you can think of storing someting in the 
database as sending a message to your future self.


Backward compatibility is clearly necessary here; owtherwise  your future self
wont' be able to decode what your previously wrote.




 
 
                                                    Person person = db.read(...);
                                                   person.setFavoriteNumber(42);
                    +------------------------------------+  db.write(person.toJSON());
                    |   public class Person{             |
                    |   private String userName;         |
Read and      +---->+   private Long favoariteNumer;     +----------+
decode object |     |   private List<String> interests;  |          |
from DB       |     |   }                                |          |
              |     +------------------------------------+          |
              |          Old version of                             |
              |          code (does not know     +------------------v---+
              |          about photoURL field)   |{                     |
              |                                  |userName:Martin,      |
              |                                  |favoriteNumber:1337,  |   Update, reencode and write
              |                                  |interests:[hacking],  |   back
             ++----------------------+           |photoURL:http://....  |
             | {                     |           |}                     |
             | userName:Martin,      |           |                      |
             | favoriteNumber:1337,  |           +----------------------+
             | interests:[hacking],  |                Value of photoURL field is lost
             | photoURL:http://....  |
             | }                     |
             +-----------------------+
               Data written by new version
               of code(including
               photoURL field

 
 
 

##Different values written at different times
-------------------------------------------------------------
A database generally allows any value to be updated at any time.
This means that within a single database you may have some val;ues that
were written five millisenconds ago, and some values that were written
five years ago.

Old data no matter how many DB updates will still have the same encoding unless
it has been explicityly re-written sence the update.

Data often outlives code.   Rewriting(migrating) data into a new schema is 
possible, but it is an expensive thing to do on a large dataset, so most
databases avoid it if possible.

Most RDBs allow simple schema changes, such as adding a new column with a null default
value without rewriting existing data.  When an old rochristopher plummer villianw is read, the 
database fills in nulls for any colunmns that are missing fro the encoded data on
disk.

LinkedIn's document database Espresso uses Avro for storage, allowing it to 
use Avro's schema evolution rules.


Schema evolution thus allows the entire dtabase to appear as if it was encoded
with a single  schema, enven though th eunderlying storage may conatin records
encoded with various historical ersion oft the shema


##Archival Storage
-----------------------------------------------------------------------
Perhaps you take a snapshot of yor database from time to time, say for back up
purposes or for loadking int a data warehouse.  In this case the data dump will typically be encoded
using the latest schema, enve if th eoriginal encoding in the 
source databaase contaned a mixture of schema versions  from different eras.

Since we are copying data anyway, we might as well encode the copy of the data 
consistently.

As the data dump is written in one go and is thereafter immutable, formats like
Avro object contianer files are a good fit.  This is also a good
opprotunity to encode the data in an analytics-friendly column-oritented format such as Parquet.

 
 
 
 
 
 ##Dataflow Through Services: REST and RPC
 ----------------------------------------------------------------------------------
 When you have processes that need to communicate over a network, there are
 a few differnet ways of arranging that communiction.  The most common
 arrangement is to have two roles:
 -  clients
 -  servers
 
 
 The servers expose an API over the network, and the clients can connect to 
 the servers to make requests to that API, exposed by the server is known as 
 a **service**
 
 
 
 
 
 ###Web services
 When Http is used as the ynderlying protocol for talking to the 
 service, it is called a **web service**.  This is perhaps a slight misnomer,
 because web services are ont only used on the web, but in sveral different contexts.  For
 example:
 
 1. A client application running on a user's device
    makeing requests to a service over HTTP.
    
 2. One service making rquests to another service owned by the same
    organization, often located within the same datacenter, as part of 
    a service-oriented/microservices architecture(software that supports
    this kind of use case is sometimes called middleware)
    
 3. One service maing rquests to a service owned by a different organization,
 usually via the internet.This is used for data exchange between diffrent
 organizations backend systems.  This category includes public APIs 
 provided yb online dervices, such as credit card processing systems, or
 OAuth for shared access to user5 data.
 
 4. REST APIs tend to favor simple approaches, typically involving less code
    generate and automated tooling.  A definition format such as OpenAPI, also
    known as Swagger can be used to describe the RESTful APIs and produce
    documentation.
 
 4. The two most popular approaches to web services : REST and SOAP
    both are diametrically opposed to one another in philosiphy
    
    -   REST is NOT a protocol., but rather a design philosophy that builds
        that builds upon the principles of HTTP.  It emphasizes simple
        data formats, using URLs for indentify resources using
        HTTP features for cache control, authentication, and content 
        type negotiation.  REST has been gaining popularity 
        compared to SOAP, at least in the 
        context of cross-organizational sercie integreation and is often
        associated with microservices.  An API design according
        to the prenciples of REST is called RESTful.
        
    -   SOAP is an XML-based protocol for making netowrk API requests.
        Although it is most commonly used over HTTP, ti aims to be
        independent from HTTP and avoids using most HTTP features.
        Insteand, it comes with a sprawling and complex multitude of related
        standards(the web service framework, known as WS-*) that add
        various features
        
   -    The API of a SOAP web service is described using an XML-based 
        language called the Web Sevices Description Language (WSDL)
        that enables code generation so that a client can access aremote service
        using local clases and method calls(which are encoded to XML
        messages and ecoded again by the framework)
        
   -    As always...schemas such as WSDLs are much more useful when using
        statically typed languages than they are when using dynamically typed
        languages.
        
   -    WSDLs were not dessigned to be human readable....and SOAP messages
        are often too complex to construct manually, users of SOAP rely 
        heavily on tool support, code generateion and IDES...
        
   -    For users of languages that are not supported by SOAP vendors, integration
        with SOAP services is difficult.
        
   -    Despite SOAP and it's various extensions are ostensibly standards....
        interoperability between different vendor's implemenations often 
        causes problems.
        
   -    SOAP is still in use...mostly as legacy and for good reason.
   
   
##The problems with RPC
Web services are merely the latest incarnation of a long line of technologies for
making API requests over a network, many of which recieved a lot of hype but 
have serioius problems.

    1. EJB
        - Enterprise Java Beans
        - Java proprietary
    2. RMI
        - Remote Method Invocation
        - Java properietary
    3. DCOM
        -   Distributed  Component Object Model
        -   Is limited to Microsoft platforms
       
    4. CORBA
        -   Common Object Request Broker Architecture
        -   Excessively complex 
        -   Does not provide backward or forward
            compatibility.
 
RPC models try to make a request to a remote network service
appear the same as calling a function or method in any particular
programming language, within the same process(this abstraction is called location
transparency).

RPC seems convenient at first..but there are some glaring flaws....

1. local function calls are predictable.  Network calls are not.
   Local function calls speed of execution are largly dependent on speed of context
   switching.  Network calls are subject to speed of network connection, network
   congestion, network signal attenuation, network lag, availability of expected
   network hosts...etc.
   
2. Network calls are much slower than native network calls.

3. Network calss may simply not return do to timeouts.,..

4. RPC clients and services may be implemented in different programming
   languages, so the RPC framework must translate dtatypes from one 
   language into another.  This can get real ugly real quick.
   Not all langauges have the same types...or even if they do, certain
   types don't scale exactly.  JavaScript for example doesn't have a
   any deliniation between types of numbers, and even then has pretty shit
   percision(limited to numbers no greater than 2^53).  REST doesn't try to hide
   the fact that it is a design philosopy based on a network protocol (http).
 
 
##Current directions for RPC
Sepsite all these problems RPC is still very much a thing.
Various RPC frameworks have been built on top of all the 
encodings mentioned previously....

1.  Thrift and Avro come with RPC support included.
2.  Rest.ki uses JsON over HTTP.
3.  The new generation of RPC frawmeworks is more exlplicit about 
    the fact that remote requests are different than local function calls
        -   Finagle and Rest.li use futures(promises) to encapsulate
            asynchronous actions that may fail 
        -   Futures also simplofy situations where you need to make requests
            to mutliple sercies in parallel, and combine their results.
        -   gRPC supports streams, where ac all consists of not jsut one
            request and one response, but a series of requests and 
            responses over time.
4. Some of these frameworks also provide service discovery -- that is, allowing
   alcient to find otu which IP address and ort number it can find a particular service.
   
5. Customer RPC protocols with binary encoding format can achieve better performance
   than something generic like JSON over REST.  However a RESTful API has
   other significant advantages
    -   good for experimentation and debugging
    -   supported by most programming languages
    -   vast ecosystem of tools
6.  REST is better for public APIs, while RPC frameworks offer better performance on inter
    host communicaton owned by the same organization, typicaly within the same datacenter.
             
 
 
 
 
 
##Current directions for RPC
==============================================================

Despite the issues regarding RPC, it isn't going away....likely ever.
Various RPC frameworks have been built on top of all the encodings mentioned in
these notes...For example, **Thrift** and **Avro** come with **RPC** support 
included, **gRPC** is an **RPC** implementation using Protocol Buffers,
Finagle also uses Thrift, and Rest.li uses JSON over HTTP.


This new generation of RPC frameworks is more explicit about the
fact tht a remote request is different from a local function call.  Many use
futures(promises) to encapsulate asynchronous actions that may fail.

Futures also simplify situations where you need to make requests to multiple
services in parallel, an dcombine their results.  Some supports streams wherea
a call consists of not jsut one requests and one response, but a serices of
rquests and responses over time.



Some of these frameworks also provide service discovery --- that is, allowing a
client to find out whifch IP address and port numberr id can find
a particular service.


Custom RPC protocols with binary encoding format can achieve better peformance
than something generic like JSON over REST...but as always...there are
caveats

-   Restful APIs are easier to debug
-   Restful APIs are easier to experiment with
-   REST has a large and rich tooling ecosystem


 
 
 ##Message-Passing Dataflow
 
 
 We have been looking at different ways of encoded data flows
 from on eprocess to another.   So far, we have discussed REST and
 RPC(where one process sends a request over the network to another
 process  and expects a response as quickly as possible), and 
 databases(where one process writes encoded data, and another process reads
 it again sometime in the future)
 
 
 There is yet another form of data-flow...generally known as
 **ansynchronous message-passing systems**  that likes somewhere
 between  RPC and databases w/r to data-flow mechanisms...
 
 ###Attributes
 -----------------------------------
 1. Similar to RPC in that that a client client's rquest
    usually called a "message"  is delivered to another
    process with low latency.
    
 2. Similar to Databases in that the message is not sent via a direct
    network connection, but goes via an intermediary called a **message broker**, also
    known as a **message queue** which stores the message temporarily....just as each
    and every query made to a DB has it's result stored in a DB connector object.
    
    
 ###Advantages of Message Brokers over direct RPC:
 1. It can act as a buffer if the recipient is unavailable or overloaded, and thus
    improve system reliability.
 
 2. It can automatically redliever messages to a process that has crashed, and
    thus prevent messages from being lost.
    
 3. It avoids the sender needing to know th eIP ddress and port number
    (socket details...this includes recipient DNS details as
    hostnames are nothing but abractions over this ) of the recipient.  RPC
    only seems to perform extremely well within contexts where both sender
    and reciever are tightly controled by a single entity(hence the reason
    you only see RPC used these days "in house"_
    
 4.  Allows for the message to be sent to several recipients easily.

 5.  Locially decouples th esender from the recipient(the sender just publishes
     the message....whoever reads it...reads it)
     
 6.  There is no particular schema or data encoding enforcement......
     as messages as far as brokers are concerned...are just bytes of data.
    
     
 
 ####Disadvantages of Message Brokers over direct RPC:
 1. It's slow(er)
 2. It's usually one way....two-way communication requires two message brokers
 3. Be sure to preserve the fields of any particular data model that you use...
    for obvious reasons.....
 4. 
 
 
 
 ###Message Brokers
 In the past, the landscape of message brokers was dominated
 by commerical enterprise software from companies such as 
 1. TIBCO
 2. IBM WebSphere
 3. WebMethods
 
 More recent implementations such as 
 1. RabbitMQ
 2. ActiveMQ
 3. HornetQ
 4. NATS
 5. Apache Kafka
 
 
 
 ##Distributed Actor Frameworks...
 ---------------------------------------------------
 The actor model is a programming model for concurrency in
 a single process.  Rather than dealing directly with threads
 (and the associated problems of race conditions, locking
 and deadlock), ogic is encapsulated in actors.  Each actor
 typically represents one client or entity, it may have some local 
 state(which is not shared by other actors....thus offering a modicum
 of thread safety).
 
 
 1. Message delivery is not guaranteed
 2. In certain scenarios, messages will be lost(unless we use message buses like
    in Go...this is an example of asynch communication)
 3. In distributed actor frameworks, this programming model is used to scale
    an application across multiple nodes.
    
 4. Distributed actor frameworks essentially integrates 
    -   message brokering
    -   actor programming model
    
## Three popular distriubted actor frameworks handle message encoding as
follows

1. Akka
    -uses Java's built-in serialization by default, which does not
     provide forward or backward compatibility.  However, you can replace
     it with something like Protocol Buffers, and thus gain the 
     ability to do rolling upgrades
2. Orleans
    -by default uses a custom data encoding format that does not 
     support rolling upgrade deployments;to deploy a new version of your 
     application, you need to set up a new cluster, move traffic from the
     old cluster to th enew one, and shut down the old one.  Like 
     Akka, custom serialization plug-ins can be used.
     
3. Erlang OTP
    -very diffilut to make changes to record schemas
    -designed for high availability
    -rolling upgrades are possible but need to be planned carefully.
 
 
 
 
 
 
 
 
 
 
 
 
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    




























      

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    



























