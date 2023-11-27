# Building a Neural Network 

`"Artificial intelligence is complex, but creating it is  realitively
simple.  Plop it in a virtual enviroment, give it a goal, 
and let it fail and fail and fail until it figures out how to complete the task at hand"`
-- **Dan Seitz**



## Feed Forward Neural Networks(FFN)
- first known NN
- Acyclic
- No back propagation
- realtively simple to comprehend
- excels in the following applications 
    * speech recognition
    * image processng




## Recurrent Neural Network (RNN)
- Informaton recurrance 
- Similar in structure to FFN
- Differs from FFN in that the output layer
is re-fed into the system.
- excels in the following applications 
    * Predictive reasoning
        - predicting next words 
        - driverless systems 

## Convolutional Neural Network (CNN)
- Introduced in 1998
- Similar to FFN
- Examines the elements of their input in small portions
- Excels at detecting edges and corners in images
- Convolutional networks contain the typical input/ouput
- CNNs containe the typical fully connected hiden layers
- CNNs contain an additonal feature of especially hidden layers called pooling and 
convolution layers
- Convolution layers work via "convolving an image"
- Convlutionlayers examine portioned features of an image to crate a map of data realting to the ffeatures contained in teh image
    * These are known as "featuere maps"
    * pooling layer's role is to compress the resolution of feature maps 
- excels in the following applications for more nimple processng
for example, compressing "January" to "Jan"
    * Classfication
    * image processng
- CNNs typically have nodes that are sparsely interactived
    * avoids burning time and resources irrelevant neural activity
    * produces more efficient data processing 
- excels in the following applications 
    * Predictive reasoning
    * Classification
    * speech recognition


## Restricted Boltzmann Machine (RBM)
- Recognize patterns through a reconstruction of input data
- RBM networks have a simple structure consisting of only two layer types
    * visible layer
    * hidden layer
        - These layers are fully connected. Meanng every node
        from one layer is connected with every node in another.
    * Does not requre label data for training
    * Remember that non-label training is AKA " unsupervised learning"
- these layers are fully connnected
- excels in the following applications 
    * Feature Detection
    * Classification





## Recursive Neural Tensor Network (RNTN)
- Unique structure
    * Neurons are grouped into distinct structures (Binary tree)
        - parent group
        - child groups 
        - parent groups are connected to child groups
        - child groups are not connected
- excels in the following applications 
    * Explore hierarchical structure in data
    * Sentiment analysis
    * Analysis that require careful note of order of events
    * Involves Backwared propagation is used to train RNTNs 
    * Scores is derived from teh contrast between the correct sentence
    structure and the sturctdure of the sentence output by the net.



