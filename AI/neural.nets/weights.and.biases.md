


Begining notes...
====================================================================
"The history of AI research, which can be traced back 58 years
to a conference at Dartmouth College in New Hampshire where the 
phrase was coined, has been littered with false dawns.  If the latest
hopes also fall short, it won't be because of a lack of ambition or
effort"
--Richard Waters


Weights and Biases
=========================================================================
Weights are a value representation of how strong the 
connection between one node is with another.  They establish
a score based on relevance.  

How relevant is is information "A, " to information "B" ?

Their degree of relevance is the weighted value.
This is graphically portrayed as a line connecting two nodes.
In more detailed illustrations, you will see these lines represented
by different shades in the grayscale specture or even shades of color.


How are weights represented ?
==============================================================================
As with the layers of a neural network, we will aalso express
our weighted values in a matrix.  At this point since we know that
weighted values are multiplied by activation values, we begin to see
just why a neural network is only a matter of solving a detailed matrices
is only a matter of solving a detailed matrices 
multiplication operation.


Value of weights will change over the course of the training process.
=========================================================================
    *   This is an adjustment that the network makes to itself
    *   One parameter that is left to manual adjustment is the "Learning Rate"
        -   Learning rate defines a speed at which we
            would like the network to learn.
        -   However it is more of a threashold indicating
            how much the network is allowed to adjust it's
            weights each time it is exposed to information or training data.
        -   The higher the LR is set, the more information get's lost
            concerning how to work out the problem.
            It is a loss of the finer details.
        -   It is possible that setting the learning rate high
            will render your network useless altogeter.
        -   Setting a high learning rate is analogus to attempting to learn Mandarin
            or Software Engineering in a few days or months.....
        -   Missing the finer details matter....as they give a broader scope of
            understanding.
        -   Smaller learning rate values increases the resoluteion of the learning process.
        -   High resolution means longer processing times.  Many hyperparamerters are
            a matter of fine-tunning.


A quick and easy to digest example of weights and learning
===============================================================================
Say the outuput of some net is peforming well at your job.
Initially setting your alarm so you could get up ealier and thus be 
at least on time for your shift are the inputs of your input layer for this net....
and as such the weights in these nodes are configured to prioritize to be 
pretty high....as when weights are given relatively low values,  that means the
region of the net these weights are located are rate as having relatively low
relevance....in other words..the connected inforation in this region of the net
are not particularly important to the outcome as others might be...but after the 20th
time being late with no reprimand....the weight difference shifted from the area of the 
net concerned with getting up earlier and over to "settling in", getting caught up
with non-work-related matters, and getting a good cup of coffee...

BTW...this is also an example of Reinforced Learning(RL).

Biases....What are they ?
====================================================================

    *   A bias in a n-network is an additional device used to 
        help prioritize data being passed along.
    *   As with the other components, biases are a number
    *   They can be any number of the variables a network adjusts as it trains itself.
    *   A bias for a net that determines who is and isn't a suitable caller for a woman
        might be "Must be tall....must have a beard"....so lets think about this....
        Input-A could run through the net and produce a output-layer node with a score of
        70% but garners a terrible bias score and Input-B could produce a node with the score
        of 40% but still win out during training due to to ba
    *   Biases are added to data before it leaves as output from a node.

   
    

Summary
===========================================================================
    *   Neural networks sums the weight value and the bias value to 
        formulate the activation value of the recieving ndoe.
           
    *   A Node's activation value is multipled with the node's weight in a
        nerual network to determine the information being sent to the next layer of
        recieving nodes.  Right before it leaves as output, a value called "bias" is
        added. 
        
        
        
        
Q/A
================================================================================
    *   How is the weighted value for two nodes determined ?
        -   Weighted values between nodes is determined via the 
            relevance of data between nodes.  the heavier the weight
            the more relevant is the data in that region of the net.
            
    *   The speed at which we would like the ntework to learn is 
        called what ?
        -   The speed at which we would like the network to learn is reffered to
            as "The Learnin Rate"
        
    *   At what point do biases come into play ?
        -   Biases determine the minimum threshold for some input data must meet...
            in other words, no matter what the input data is...or what weights are 
            in play...if the biase isn't met, then the data cold be summarilly dismissed or 
            the output for characterization or number of outcumes could be set to 0/100.
        -   Biases are added to the activation value of any node before it is provided as
            input for the next node.

