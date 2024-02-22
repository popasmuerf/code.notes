[source](https://medium.com/fintechexplained/neural-networks-bias-and-weights-10b53e6285da)



## Introduction 

We all know that an Artificial Neuron is a basic building block of a neural network.  Before we get into the topic,
"what is the role of weights and bias in a Neural Network", let us understand the skeleton of this artificial Neuron

```



                          Neuron........................................................
                           .        b(Bias)                                            .
                           .        |                                                  .
                           .        |                                                  .
                           .        |                                                  .
                x1-----w1-----|------------|                                           .
                x2-----w2-----|            |            ---------------------------    .
(Inputs)        x3-----w3-----|  summation |----------->| f (activation function) |------------> Y pred
                           .  |  function  |            ---------------------------    .
                           .  |            |                                           .
                xn----wn------|------------                                            .
                           .                                                           .
                           . ...........................................................

```                                                                                     

A neuron first computes the weighted sum of the inputs 



## Some things to keep in mind before we go any further.

- Neural Networks are fundamentally just complex matrices
- From what we understand so far, nodes will encapsulate some number that represents their 
respective node activation value
- The weight, activation strength are all multiplied together to produce a product
- Finally a bias is added to the product of the weight and activation value (wa) ->  b + (a * w)
before reaching the next layer of nodes where another round of multiplication and additon takes place
- Each layer of a network is mapped out on its own matrix-vector in this case.



## Components of the basic Artificial Neuron:

1. Inputs: 
Inputs are the set of values for which we need to predict a outupt value.
They can be viewed as features or attributes in a dataset

2. Weights:
Weights are the real values that are attached with each input/feature in predicting the final output.
They convey the importance of that corresponding feature in predictingthe final output

Weights are the co-efficients of the equation which which you are trying to resolve.  Negative weights 
reduce the value of an output

When a neural network is trained on the training set, it is initialised with a set of weights.  These
weights are then optimised during the training period and the optimum weights are produced.


3. Bias:
Bias is used for shifting the activation function towards left or right, you cna compar this to y-intercept in a linear equatoion.
4. Summation Function:
The work of the summation function is to bind the weights and inputs together and calculate their sum
5. Activation Function:
It is used to introduce non-linearity in the model 



## What if there are no weights ?

``` We will understand a thing's importance only during its absense ```

As the statment speaks, let us see wht if there is no concept of weights in a neural network.
Fro simplicity let us consider there are only two inputs/fetures in a dataset (input vector x [x1,x2]), and our task 
is to peform binary classification.


- Inputs is not processed by neurons 
- The human body employs nerve celss as the sensory interface between you and teh external world. 
- Nerons  are tasked with processing this information. 
When building your neural network, decideing on teh number of hidden layers will probasbly be 
much easier than deciding on how many nodes a hiden layer should have

- The number of h-layers a network has typically corresponded the number of evaluations needed to arrive at a result.
- Again, these layers measure one aspect of the overall problem then frmulate a ranking for how relevant each piece of information they were given
is to the overall question

A problem that is growing as conventional neural networks progress is that these networks require  a lot of processing
power to carryu out their functions.  This sould be no surprise to engineers as a neural network sequentially reviewes everything that has been taught when
evaluating any given input.

Imagine if your mind reviewed every classification type you have ever been introduced to if I showed you a coffee mug.


Deciding on a structure for your outupt layer will mostly likely be easiest.  The number of neurons in 
your output lyaer will be equal to th enumber of possible outputs you wish for your network to provide you.
We know if a network is designed to identify handwritten digit, we know that there are ten output neurons in that network.
If it recognizes handwritten letters of the alphabet, we could infer twenty-sixe output neurons.
Neural nets employing hierarchal structures differ from this, however, have you already been thinking of beetter possible ways a neural network could 
indicate a response ?


Assigning weight values between nodes can be done manually or set randomly in the inital creation of your network.  You may have a choice to 
You may have a choice to predefine or randomie these values, or your data may dictate randomization.  An example where pre-defining weights would be irrelevant is
in an unsupervised learning model


Plan Participants: 
Please reach our Participant Services Team at (877) 401-5100 (option 3) 
or by emailing support@employeefiduciary.com. Support hours are 8 AM - 5 PM Central Monday - Friday.


Justin Ganus
Client Relationship Manager
Employee Fiduciary, LLC
250 State Street
Mobile, AL 36603
(251) 380-7134 Direct
(877) 401-5100, ext. 7010 Toll-Free
(251) 436-0801 Fax





!{firehose:error-output-type}/!{timestamp:yyyy/MM/}