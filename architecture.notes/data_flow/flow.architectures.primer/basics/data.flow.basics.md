#### Chapter 1
### Introduction to Flow 

The COVID-19 pandemic has disrupted just about all aspects
of our personal and professional lives. amd tjere are 
severe challenges in getting the pandemic contained. 

While we can take a number of personal actions, such as wearing masks and 
washing our hands, there is plenty of evidience that shows real containment requires real-time cooperation
among communities, countries, and humanity as a whole.


The crisis for the most part has passed, However the relative success in containing the 
virus in countries like Malaysia, an Douth Korea demonstrated that other nations who struggled
awith containmen could have been lessened dramaticaly if they had better tools and programs for 
activities like contact tracing and resource distribution.

Both of the activities mentioned previously (contact tracing and Resource distribution)
both are actitiviese that require real-time data coordinnation.


We coultn quickly crate tools to share data in real time in part because there are no consistent
mechanisms to do so.  Each software system involved in generating or processing the 
necessary data has its own way of making data available to other systems including 
how those systems requrest or recieve the data, and how the data is packaged.


For example, mobiled applications can use Bluetooth connections to capture
information on those we have had contact with.
HOwever, getting that captured data to agencies coordinating a response to positive
COVID-19 tests requires those agencies, celluar network companies, and phone manufactures 
to negotiate th emeans the terms for data sharing.  Even when everyone is pmotivated to solve the problem that can
take weeks or even months 


Resource coordination should be easier, but every manufarcturer, distributor, and hostpital
system has systems that are disparate and cannot share data easily.  IN the early
days of the pandemic, finding supplies was done by human beings; first by searching websites of distributors and manufactuerrs,
then by briefly resorting to personal contracts an dpprofessional networks when that wasn't frutiful.

There has been several cases of frauld realted to personal protective equipment sales as organizations have found themsleves more and more desperate for large amounts of highly contested resorces.

As more and more of our businesses and other organizations “go digital,” more and more of the economic interaction between them is digital. Financial transactions are executed in their entirety without human intervention. Inventory ordering is sized and timed by computers projecting production demand. The security of our food supply increasingly relies on producers, shippers, and wholesale and retail operators maintaining a digital “chain of evidence” that is difficult to spoof.
The groundwork is in place to fundamentally change how real-time data is exchanged across organization boundaries, whether in business, government, education, non‐ profits, or even our personal lives. Advances in event-driven architectures, stream flow control, and early attempts at standardizing event metadata are slowly converg‐ ing on establishing a well-defined mechanism to do so.
Custom examples of the value of this type of integration can already be seen in real- time inventory management in retail and machine automation systems in factories. However, because each interface is different, each protocol defined for a specific use, there is uncertainty and expense involved in executing event-driven integration across our economy.


### Activities that required real-time data coordination during COVID-19
- Contact tracing 
- Resource distribution





## What is Flow ?


- Flow is networked software integration that is:
    * event-driven
    * loosely coupled
    * highly adaptable
    * extensive

- Principally defined by 
    * standard interfaces 
    * protocols 
that enable integration with a minium of conflict and toil
However to this day we do not have standardized interfaces 
nor protocols.  Hopefully `Flow` will eventually change all of this. 

- Information theory
    * The study of the
        - Quantification of Information
        - Storage of Information
        - Communication of Information
    Uses terms like :
        - The sender of inforation is the :
            * producer
        - The reciever of information is the :
            * consumer 
- Flow is the th emovement of information between disparate software applications and services characterized by th efollowingl;
    * Consumers (or their agents)
        - Request streams from producers through self-service interfaces
    * Producers (or their agents)
        - Choose which rquests to accept or reject

    * Once a connection is established, conusmers do not need to actively request
    information --- it is automatically pushed to them as it is avaiable.
    * Producers (or their agents)
        - maintain control of the transmission of relevant information -- i.e., 
        what information to transmit when, and to whom 
    * Information is transmitted and recieved over standard network protocols
    including to-be determined protocols specifically aligned with flow mechancis.


Flow allows an information consumer to locate and request data from independently 
operated information producers without requiring those producers
or producer agents that manage flow on the producer's behalf such as :

    - Format
    - Protocols 
    - Policies


Without interaction....`Flow` is just a stream of data


## Flow and flow interaction

Flow and flow interation depend on the ability of consumers to recieve data passively and respond
only to pertient signals.  In th etechnical world, the signals 
we care about typically represent some sor of state change.  The creation or updating of 
some form of data somewhere in the system.  For example :

    - A sensor might signal tha a key temperature in a manufacturing process has increased
    - The stofk market migh tsignal htat th asking price for a given stock has changed
    - A truck indicating it has available cargo capcity
    - A business signalling its intent to file for an inital public offering


Before we go any further, We should define a couple of terms We already 
When we package the information about that state change with 
some additional context (sucha as the time the change took place, or an 
ID associated wiwhat changed), we call that an`event`

The producer that captures and packages that 
information will then publish the event for eventual consumption by consumers.
The transmission of a series of events between two parties (producer and concumer) 
is called an devent stream 

It is important to note therer are twoo different ways that data can bestreamed on 
a network 
    - Data Stream
    - Event Stream



###  Data Stream

- Producer sends data as it comedirectly on the network without 
any additional meta data added (no context is passed).   
- This raw data 
stream reuires the  consumer to add any context when it recieves the data.
The consumer needs to know some of the required context before hand :
    * source of the stream
    * category/type of data
    * Any extant meta-data that producer is sending


                                (publishing events to stream "A")              Stream A
                    Producer----------------------------------------------->   Stream B
                                            n,4,3,2,1                          (etc) 

                                (publishing events to stream "A")              Stream A
                    Consumer <----------------------------------------------   Stream B
                            ----------------------------------------------->  (etc)               
                                            n,4,3,2,1                                         


