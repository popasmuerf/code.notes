## OLTP and OLAP

### Online transaction processing(OLTP)

    - typically short activities:
        - booking tickets
        - crediting accounts
        - booking a sale
        - Buying something off of Amazon
     
     - Implies voluminous low-latency query processing
       and high data integrity.
     - Although OLTP may involve only a small number
       of records per  transaction, systems process many
       taransactons concurrently.
       
   
### Online analisys processing(OLAP)

    - faciliates more complex queries and analysis over historical
      data.
    - these analyses may include multiple data sources, formats, and types
      Deteting trends, conducting "what-if" scenarios, making predictions and
      uncovering structural patterns are typical OLAP use cases:
        - Detecting trends
        - Conducting "what-if" scenarios
        - Making predictions
        - Uncovering structural patterns
        - Inclusion of multiple data sources, formats and types

     
     - Implies voluminous low-latency query processing
       and high data integrity.
     - Although OLTP may involve only a small number
       of records per  transaction, systems process many
       taransactons concurrently.
       
     
### Quick Summary
    - Online Transaction Processing (OLTP)
        - Many Short lived transactions 
        - Run concurrently
        - Do not involve analysis
        - High degree of transactional integrity
            - Transactions are atomic
            
     - Online Analytica Processing (OLTP)
        - Relatively long lived transactions/quieries along with 
          analysis over historical. 
        - Includes data of different types from multiple sources
        - Used for relatively complex decision making, categorization, etc
        - Biased towards faster reading as writes are not required 
          for analysis
        - Batch oriented processes are common
        
 
### As always, two different technologies/methodologies are used to solve problems

    -   Recently, however, the line between OLTP and OLAP has begun to blur.
        Modern data-intensive applications now combine real-time transactional
        oprations with analytics
       
    -   As data is gathered from:
        -   Point of sale(POS) machines
        -   Manufacturing systems
        -   IoT devices
        Analytics now support the ability  to make
        real time recomendations and decisions while processing.
        This trend was observed several years ago and terms to describe this
        merging include:
            -   translytics
            -   hybrid transactional and analytical processing (HTAP)
            
            
    -    As OLTP and OLAP become more integreated and begin to support 
         functionality previously offered in only one silo, it is no longer
         necessary to use different data products or systems for these 
         workloads.  We can simplify our architecture by using the same
         platform for both.  Thgis means our analytical queries can take
         advantage of real-time data and we can streamline the iterative
         process of analysis
         
         
### Why Should we care about Graph Algorithms ?

    -   Graph algorithms help make sense of connected data
    -   Real world examples of relationships within real world systems:
        -   Protein interactions
        -   Social networks
        -   Communication systems
        -   power grids
        -   retail experiences
        -   Mars mission planning
        Understanding networks and the connections within them
        offers incredible potential for insight and innovation.
        
    -   As our data becomes more connected, it is increasingly important
        to understand its relationships and interdependencies.  Scientists
        that study the growth of networks have noted that connectivity increases
        over time, however not uniformly.  Prferential attachment is one theory
        on how the dynamics of growth impact structure.
        
### Power Law

A ***power law*** (also known as ***Scaling Law***) describes the relationship 
between two quantities where one quantity varies as a power of another
For example, the area of a cube is is related to the length of it's sides by
a power of 3.  

A well known example is the ***Pareto distribution*** or 
"80/20 rule", originally  used to describe the situation where 
20% of a population controlled 80% of the wealth(2^3 = 8) We see various power loaws
in the naturaal world and networks.

As such....trying to "average out"  a network generally won't work well for
investigating relationshps or forecasting, because real-world networks have
uneven distributions of nodes and relationshps.


Because highly connected data does not adhere to an average distribution,
network scientists use graph analytics to search for and 
interpret structures and relatiojsip distributions in real-world data.

```
"There is no network in nature that we know of that would be described by the
random network model" --Albert-László Barabási, Director, Center for Complex Network Research, North‐eastern University, and author of numerous network science books 
```
        
   The challenge for most users is that densely and unevenly connected data
   is trouble-some to analyze with traditional analytical tools.  There might
   be a structure there, but it is hard to find.  It's tempting to 
   take an averages approach tomessy datya, but doing so
   will conceal patterns and ensure our results are not representing any
   real groups.
   
   For instance, if you average the demographic information of all your customers
   and offer an experience based soley on averages, you will be guaranteed
   to miss most communities: communities tend to cluster around related factors like
   age and occupation or marital status and location.   
   
   
   Furthermore, dynamic behavior, particularly aro9und sudden events and bursts,
   can't be seen with a snapshot.  
   
   To illustrate, if you imagine a social group with increasing
   relationships, you would also expect more communications.  This could lead
   to a tipping point of coordination and subsequent coalition or, alternatively,
   subgroup formation and polarization in...for example elections.
   
   Sophisicticated methods are required to forecast a network's evolution over time, but
   we can infer behavior if we understand the structures and interactiosn within our
   data.  Graph analytics is used to preduct group resiliency because of the focus
   on relationships.
   


## Graph Analytics Use Cases


At the most abstract level, graph analytics is applied to forecasting
behavior and prescribed action for dynamic groups .
doing this requires understanding the relationships and structure within
the group.  Graph algorithms accomplish this by examining the 
overall nature of networks through their connections.  With this 
approach, you can understand the topology of connected systems and model their
processes.

There are three general buckets of questions that indicate whther graph
analytics and algorithms are waranted as

    -   Propagation Pathways
        *   How do things spread?
    -   Flow and Influence
        *   What are the capacities,
            costs, and control points ?
    -   interactions and Resiliency
        *   How do things interact and will that
            change ?
            
Here are a few types of challenges where graph algorithms are
employed:

    -   Investigate the route of a disease or a cascading transport failure
    -   Uncover the most vulnerable, or damaing, components of a network
        attack
    -   Indentify th eleast costly or fastest way to route information or
        resources
    -   Predict missing links in your data
    -   Locate direct and indirect influence in a complex system
    -   Discover unseen hierarchies and dependencies
    -   Forecast whether groups will merge or break apart
    -   Find bottlenecks or who has the power to deny/proivde more resources
    -   Reveal communities based on behaviro for personalized recommendations.
    -   Reduce false positivies in fraud and naomaly detection.
    -   Extract more predictive, features for machine learning.
   
   
   
   
   
   
       
        
 
 
