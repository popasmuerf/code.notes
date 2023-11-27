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


