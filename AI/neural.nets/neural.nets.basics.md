


Begining notes...
============================================
    *
    
    
    
    
Layers 
====================================================================
"People unserstand the linear algebra behind deep
learning otherwise known as neural networks.  But the models 
it produces are less human readable.  They are machine -readable.
They can retrieve very accurate results, but we can't always explain,
on an individual basis, wht led them to those accurate results"


What is a "Layer"
================================
    *   It's a stack of nodes.
    *   Layers are represneted mathematically using a matrix-vector
    *   Matrix vectors are well suited to this task due to the nature
        in which data is structured in a a network layer.  They are essentially
        identical.
    *   If we have a simple layer with 3 nodes possession activation values of
        2,7 and -3, we would just stack these values vertically and werap them in 
        brackets to convert the layer into a matrix vector
        
    *   Typically neural networks laid out in a left to right format
    *   Leftmost node columns are designated as the "input layer".  Data enters
        a n-network via the input layer(Note...this is mainly true for Convolutional networks
        , but there are other types of networks such a Recursive Neural Tensor Networks(RNTN)
        which are actual hiearchal in structure....Convolutional networks feature a graphical
        reprsentation resempling  a cob-web where as RNTN's resemble a tree)
    *   The initial data provided to any node is known as it's "activation" value.
    *   Think of the n-network's input layer as sensors of a machine or a the sensory
        organs of some life form.
    *   Input layers breaks input data up to be processed by the hidden layers
    

What is a "Hidden Layer"
=================================
    *   Input layers breaks input data up to be processed by the hidden layers
    *   Hidden layers go about the business of reassembling these parts into a 
        coherent system.
    *   The smarter a n-net is....the more hidden layers will be implemented
    *   N-networks that possess many hidden layers are said to be "Deep Networks"
    *   There are different kinds of H-Layers:
        -   Convolution Neural Networks
            *   Used for storing images
        -   Pooling Neural Networks
            *   Used to lower the resolution of 
                of images stored by Convolution Networks
        -   Pooling layers usually follow Convolution layers in
            a network.
            
   *    Multiple hidden layers feature in more intelligent networks
        are appropiate due to the nature in which hiddenlayers process
 
What is an "Output Layer"
===================================
    *   Each layer of a neural network works to pic up patterns
        recieved by the previuis layer reconstructing the 
        input piece by pice.
    *   Layers do not create one result,but many possible pattern arrangements and
        configurations.
        
    *   These reconstructions are what is being voted on as it is passed along the
        network.  This brins us to the final yaer type contatined in a neural netowrk
        
    *   Outpu layers are the final stop of both our input and hidden layers.
    
    *   Output layers contain as many nodes as there are classification labels.
        -   If thier are 10 possible outcomes, then the output layer will
            have 10 corresponding nodes.
    *   By time the network has process a response to it's input, it will be 
        the output node with the highest activation number....and thus what the n-net
        has decided what the answer shall be.  This is where probability comes into play.
        -   If there exists 20 responses available to a n-net, then the output layer will contain
            20 nodes.
        -   The n-net will then conscider all the output layer node scores
        
        

