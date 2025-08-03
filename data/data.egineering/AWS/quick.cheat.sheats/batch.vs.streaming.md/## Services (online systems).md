## Services (online systems)

- A service waits for a request or instruction from 
a client to arrive.  
- When one is recieved, the 
service tries to handle it as quickly as
possible and sends a response back.   
- Response time
is usually the priamry measure of performance of 
a service

- If the client can't reach the service, the 
user will probably get an error message


## Batch processing systems (offline systems)

- A batch processing system takes a large amount 
of input data, runs a job to process it,
and produces some output data.

- Jobs often take a while (from a few minute to sveral days)
so ther isnt' normally isn't a user waiting for the job to 
finish.

- Instead, batch jobs are often schedules to run 
peridically (for example, once a day).

- The primary performance measure of a batch job is usualy
`throughput`(the time it takes to curnch through an input
data set of a certain size )




## Stream processing systems (near-real-time systems)
- Stream processing is somewhere between oline and offline/batch processing (so it is sometimes called a near-real-time
or nearline processing).

- Like a batch processing system, a stream processor 
consumes inputs and produces outputs(rather than responsing to requests.)

- However a stream job operates on events shortly after 
they happen, whereas a batch job operates on a fixed set of 
input data.

- This difference allows stream processing systems to 
have lower latency than the equivilent batch systems.
As stream processing builds upon processing 



- Batch processing is an important building block 
in our quest to build:
    * reliable
    * scalable
    * Mainabable applications.

- Example : 
    * MapReduce, a batch procssing algorithm published 
    in 2004 was called "the algorithm that makes Goole 
    so massively scalable"
    * It was sbusequently implemented in  various 
    open source data systems, including 
        - Hadoop
        - CouchDB
        - MongoDB.

    * MapReduce is fairly a low-level  programming
    moel compared to parallel processing systems tha were developer for data warehouses many years previously
    but it was a major step forward in terms of the scale 
    of processing that coudl be achieved on commodity
    hardware.

    * The importance of MapReduce (as well as the hype)
    is declining, yet it is still worth understanding, 
    because it provides a clear picture of why and how
    batch processing is useful

    * Batch processing is old.  Older than digital computers.
    As old as the 1890 US Census when semi mechanized
    form batch processing to compute aggregate
    statistics from large inputs.  And MapReduce 
    bears an uncanny resemblance to electromechanical IBM
    card-sort machines that were widely used for business
    data processing in the 1940s and 1950s.


    