


Begining notes...
====================================================================
"In the past, Google has used teams ofhumans to 'read' its street
address images - in essence, to render images into actionable data.
But using neural network technology, the company has trained computers
to extract that data automatically - and with a level of accuracy that that
meets or beats human operators"
--Jonh Battelle




Feedfoward Neural Network
=========================================================================
    *   Input is from left to right
    *   Inforamation in these networks pass information from
        layer to layer.
    *   Nodes don't form a cycle in this system.
    *   This sytem is tyically illustrated from left to right
    *   Feedforward networks are forward moving with no back propagation
    *   Feedforward nets can be applied in speech reconginition and 
        and image processing.
        

Recurrent Neural Network(RNN)
==============================================================================
    *   The principle distinction with a recurrent neural network
        is as the name implies, information recurs.
    *   Features a structure similar to Feedforward nets.
    
    *   Information travles one direction down direction down the network
        until it reaches the output layer.
        
    *   The data from the output layer is then re-fed into the sytem, aand teh
        cycle repeats.  Since each output is looped back around to the input
        layer, recurrent neural networks are helful in creating tools that can
        do things like predict the next word of a sentence.
        
    *   Smartphone keyboards/autocorrect are a great example of this.

    *   RNNs can also be used to analyze video, which lends them
        the ability to apply toward driverless car systems to NVidia emplys
        a convolutional net to power their self-driving system.

Convolutional Neural Network(CNN)
=========================================================================
    *   Introduced in 1998
    *   Similar to FFNs and as such they excel at tasks
        involving calssification.
    *   Convoluttional networks examine the elements of 
        their input in small portions.
        
    *   They are great at detecting edges and corners in imagers in order
        to distingush one classification fromanother.
        
    *   Convolutional netowerks contain the typical input, output,
        and fully connected hidden layers however...
        -   they additionally feature especially hidden layers known as pooling
            and convolution layers
    *   As indicated in the name, convolution layers wor by convlving
        an inmage.
        -   in each layer, our network examines portioned features of an image
            to create a map of data relating to the fetures contained in the
            image.
        -   These maps are called "feature maps"
        -   Pooling layers's roll is to compress the resoltion of feture maps
            created by the conconvolution layer.  this is analogus of
            an operation as a network creating an abbreviated version of the 
            feature map to allow it to be more easily processed along the rest
            of the network.
        -   If there was a CNN for months of the year, then it's pooling layer would 
            process incoming data such "January" as "Jan"...which would be much easier
            to process by sucessive layers yet still containing enough data to be
            processed as "January".
            
     *  CNNs are known for ahving what is referred to as sparse inerations.
        Since all layers are not necessarily fully connected layers, there tends to be less
        irrelvant neural activity generated.  Less needless activity 
        makes for a more efficient netowrk that is less costly to run.
        
     *  Often used in speech recognition software.


Restricted Boltzman Machine (RBM)
===============================================================================
    *   Invented by Geoffrey Hinton
    *   is best suited to feature detection and classification in machine learning
        
    *   These networks have a simple structure consisting of only two types:
        -   visible layer
        -   hiddenlayer
        -   both of these layers are fully connected such that every node from
            one layer is connected with every node in another.
        -   RBMs do not require lable data for training, and as such may be
            categoraized as a type of unsupervised learning.
        
    *   They are great at detecting edges and corners in imagers in order
        to distingush one classification fromanother.
        
    *   Convolutional netowerks contain the typical input, output,
        and fully connected hidden layers however...
        -   they additionally feature especially hidden layers known as pooling
            and convolution layers
    *   As indicated in the name, convolution layers wor by convlving
        an inmage.
        -   in each layer, our network examines portioned features of an image
            to create a map of data relating to the fetures contained in the
            image.
        -   These maps are called "feature maps"
        -   Pooling layers's roll is to compress the resoltion of feture maps
            created by the conconvolution layer.  this is analogus of
            an operation as a network creating an abbreviated version of the 
            feature map to allow it to be more easily processed along the rest
            of the network.
        -   If there was a CNN for months of the year, then it's pooling layer would 
            process incoming data such "January" as "Jan"...which would be much easier
            to process by sucessive layers yet still containing enough data to be
            processed as "January".
            


Recursive Neural Tensor Network (RNTN)
====================================================================

    *   Recursive Neural Tensor Netowrks are used to explore
        hierarchical structure in data.
        
    *   A popular application is stence sentiment analysis:
        -   determines whether or not words comprising sentences are 
            positive or negatie
        -   Examines the order in which words are encountered.
    *   RNTNs features a unique structure with its neuraons
        grouped into distinct structures:
            -   Parent group
            -   child group that extends from the parent group
            -   child groups are not connected to one another
            -   This structure is in the form of a binary tree
    *   The number of neurons featured in these groups correlates to the comolexity of the data
        we wish for out netowrk to solve.
    *   Data om tjese metwprls are processed in a recursive manner.
    *   In the case of sentence sentiment analysis:
        -   Each wor of the sentence is placed on a particular node in the 
            child group.  The Parent group is able to assign both a classifier
            and score each of the input workds
    *   Backwards propagation is used to train RNTNs.  Scores are derived
        fromt he contrast between the correct sentence structure and
        the structure of the sentence output by th enet.

   
    

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

