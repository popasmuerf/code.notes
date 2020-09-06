


Begining notes...
============================================
    *
    
    
    
    
Layers 
====================================================================
"One reason I am not worried about th epossiblity that
we will soon make mahcines that are smarter than us is that
we haven't managed to make machines until now that are smart at 
all.  AI isn't synthetic intelligence: It is pseudo-intellignece"
--Alva Noe


Training and Back Propagation
=========================================================================
The ability for a network to train is the distinguishing mark
between convential computer programming and computer programs capable of
machine learning.


Currently, networks require a lot of time to train their connections in 
order to successfully solve the problems we feed them.  Does the human mind
process information faster  modern-day hardware or do training models
and net structures need to fundamentally change ?

As you discover how neural netowrks rewrite themselves in order to 
supply us with a high volume of crrect answers, begin to consider the way
learning happens inside your mind.




Popular training methods... "Backwards propagation"
====================================================================

    *   The calculation and adjusting of derivative values.
    *   When a network misclassifies an input, it is a measure of
        numerically how wrong the network was generated.
    *   With this number, we can do something interestin to simulate learning.
    *   If we have a simple layer with 3 nodes possession activation values of
        2,7 and -3, we would just stack these values vertically and werap them in 
        brackets to convert the layer into a matrix vector
        
    *   Typically neural networks laid out in a left to right format
    *   Leftmost node columns are designated as the "input layer".  Data enters
        a n-network via the input layer(Note...this is mainly true for Convolutional networks
        , but there are other types of networks such a Recursive Neural Tensor Networks(RNTN)
        which are actual hiearchal in structure....Convolutional networks feature a graphical
        reprsentation resembling  a cob-web where as RNTN's resemble a tree)
    *   The initial data provided to any node is known as it's "activation" value.
    *   Think of the n-network's input layer as sensors of a machine or a the sensory
        organs of some life form.
    *   Input layers breaks input data up to be processed by the hidden layers
    
    *   Backwards propagation is basically summing the number of errors made with each
        calculation and then finding new ways of trying to significantly reduce the total
        sum of errors known as "The Cost Score"
        
    *   Backwards propagation invovles linear regression.
    
    *   Linear regression is the process of locating the best model for classifying our
        data using gradient decent.
    

What does the Network do with the Cost Score ?
===========================================================================
    *   Networks take their cost score and refeed it through the network
    *   Internal adjustments to its own rules on how to handle input.
        coherent system.
    *   One such internal adjustments itself is to apply and assign weights
        with each iteration of the network proccessing the same or similar inputs.
    *   With each iteration comes an adjustment....this is how the network gets smarter
        with each passing iteration.
  
Reinforcement learning
===================================
    *   Changes the equation to favor a high scoring value.
    *   Layers do not create one result,but many possible pattern arrangements and
        configurations.
        
    *   The score value in this training structure is called a "reward signal"
        
    *  These networks pursue the action that will greatly improve the current state.
    
    *  Reinforcement learning takes place through the interaction of the agent within the 
       enviroment.  Networks using this method, build their connections rather than going back
       and modifying them.
       
     *  In many cases,  R-Learning is superior to BP-Learning....dempending on the situation of
        course and has supposedly breathed new life into the study and implementation of 
        A.I. and machine learning.
    
    *   Output layers contain as many nodes as there are classification labels.
        -   If thier are 10 possible outcomes, then the output layer will
            have 10 corresponding nodes.
    *   By time the network has process a response to it's input, it will be 
        the output node with the highest activation number....and thus what the n-net
        has decided what the answer shall be.  This is where probability comes into play.
        -   If there exists 20 responses available to a n-net, then the output layer will contain
            20 nodes.
        -   The n-net will then conscider all the output layer node scores
        
        

