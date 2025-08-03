[Getting Started with AWS Step Function](https://www.youtube.com/watch?v=RbnNDsXz3YA )



1. AWS Step Function is a  serverle3ss orchestration sevice by which we can combione AWS 
Lambda functions and other AWS services to build compolex buiness applications.


2. We can author  orchestration logic in a declarative style using a JSON-based format 
called the AWS States Language(ASL)

3. AWS Step functions also provides a Workflow Studio where we can define and run our workflows





## State Machone, State, and Transitions 


1. A state machine is a mathematical model of computation consisting of different states that are connected by transitions
2. AWS Step functions also implement a state machine to represent the orchestration logic
3. Each step of the orchestration is represented by a state in the state machine and connected to one or more states thorugh transitions
4. The are represented by a diagram to visualize the current state of a system as shown here


5. State machines contain at least one state




## Amazon State Language (ASL)
1. We define a state machine in JSON format in a structure known as the Amazon States Language (ASL)
2. States are constructed out of a JSON object
3. The fields of the State defines the 
	* Type
	* Next
	* InputPath
	* OutputPath
	* Comment



	//Example 

	{
		"Type": "Task",
		"Next": "My next state",
		"Input Path": "$",
		"Comment": "My State"
	}



	* States:
		- This field contains a set of state objects
		- Each element of the set is a key-value pair
		- The name of the state as key and an associated state object as the value 

	* StartAt: 
		- This field contains the name of one of the state objects in the States collection from 
		where the state machine will start execution

	* Comment
		- Description of state machine
	* TimeoutSeconds
		- The maximum number of seconds an execution of the state machine can run beyojnd which the execution fails with an error.
	* Version:
		- Version of the AWS States Language used to define the state machine whi is 1.0 by default


	//Another Example:


	{
		"Comment": "Example State Machien"
		"StartAt": "state1",
		"States": {
			"state1": {...},
			"state2": {...},
			"state3": {...}
		}

	}


## types of State 

States recieve input, peform actions to produce some ouput, and 

1. Task :
	- A state of type `task` represents a single unit of work performed by a state machine
	- All the work in a state machine is performed by tasks
	- The work is performed by using an activity or an AWS Lambda function, or by passing parameters 
	tothe API actions of other services
2. Parallel
	- State of type parallel is used to trigger multiple brances of exectuion 
3. Map
	- We can dynamically iterate steps with a state of type map
4. Choice
	- We use this type of state as decision points within a state machine to choose amount multiple brances of execution
5. Fail or Succeed: We can stop the execution with failure or success


- we can also have mechanisms for transforming the inputs and the outputs with JSONpath expressions.
- The statye machine executes one state after another till it has no more state 




## Types of State Machine: Standard vs Express 

We can create two types of state machine.  State machine ececutions differe based on 
the type.  The type of state machine cannot be changed after the state machine is created.

1. Standard:
	State machine of type: Standard should be used for long-running, durable, and auditable processes 

2. Express:
	State machine of type: Express is used for high-volume, event processiing
	workloads such as IoT data ingestion, streaming data processin and transformation,
	and mobile applicaton backends.  They can run for up to five minutes



## Introducing The Example : Checkout Process 

Let us take an example of a checkout process in an application.
This checkout process wil typically consist of the following steps:


functions			Input 				Output 					Description
--------------------------------------------------------------------------------------
fetch				customer			customer data:			Fetching Customer
customer			ID                  email, mobile			Customer information

--------------------------------------------------------------------------------------

fetch				cart.               Price of each           Fetching Price of each item
price				items               item                    in the cart

--------------------------------------------------------------------------------------

process             customer ID
payment             cart items, price   success/failure         Create order if paymentis successful

-------------------------------------------------------------------------------------- 




				exports.handler = async(event, context, callback) => {

					console.log(`input: ${event.customer_id}`)
					// TODO fetch from database 
					callback(null, 
							{
								customer_id: event.customer_id, 
								customer_name: "John Doe",
								payment_pref: "Credit Card",
								email: "john.doe@yahoo.com",
								mobile: "677896678"
							}

						)
				};



This lambda takes  

	customer_id 

as input and returns a customer record corresponding to the customer_id.  Since the lambda
function is not the focus of this post, we are returning a hardcoded value of customer data instead of fetching it
form the data-base


Similarly, our Lambda function for fetching price looks like this: 


			exports.handler = async (event, context, callback) => {
				const item_no - event.item_no
				console.log(`item:::${item_no}`)
				//TODO fetch price from database 

				const price = {item_no: item_no, price: "123.45, lastUpdated: "2022-06-12"}
				callback(null, price)
			} 



This Lambda takes item_no as input and returns a pricing reocrd corresponding to the item_no

We will use similar Lambda functions for the other steps of th `checkout` process.  All of them will have
skeletal code similar to the `fetch customer` and `fetch price`




## Defining the Checkout Process with a State Machine


1. Let us create the state machine fromteh AWS management console 
2. We can either choose to use the Workflow Studio which provides a visual workflow
editor or the Amazon States Langauge (ASL) for defining our state machine (we should go with ASL as it allows us to cast infrastructure as code)


### Getting things done 
1. name of our state machine :  `checkout`
2. Assign IAM role to this state machine to allow it to invoke Lambda Functions that allows for you to execute lambdas that 
have full access to all resources(S3, EC2, etc.....)

			{
			    "Version": "2012-10-17",
			    "Statement": [
			        {
			            "Effect": "Allow",
			            "Action": [
			                "lambda:InvokeFunction"
			            ],
			            "Resource": [
			                "*"
			            ]
			        }
			    ]
			}


3. The full state machien written out in ASL

		{
		  "Comment": "state machine for checkout process",
		  "StartAt": "Parallel",
		  "States": {
		    "Parallel": {
		      "Type": "Parallel",
		      "Branches": [
		        {
		          "StartAt": "fetch customer",
		          "States": {
		            "fetch customer": {
		              "Type": "Task",
		              "Resource": "arn:aws:states:::lambda:invoke",
		              "OutputPath": "$.Payload",
		              "Parameters": {
		                "Payload.$": "$",
		                "FunctionName": "arn:aws:lambda:us-east-1:926501103602:function:fetchCustomer:$LATEST"
		              },
		              "End": true
		            }
		          }
		        },
		        {
		          "StartAt": "Map",
		          "States": {
		            "Map": {
		              "Type": "Map",
		              "Iterator": {
		                "StartAt": "fetch price",
		                "States": {
		                  "fetch price": {
		                    "Type": "Task",
		                    "Resource": "arn:aws:states:::lambda:invoke",
		                    "OutputPath": "$.Payload",
		                    "Parameters": {
		                      "Payload.$": "$"
		                    },
		                    "End": true
		                  }
		                }
		              },
		              "End": true
		            }
		          }
		        }
		      ],
		      "Next": "Pass"
		    },
		    "Pass": {
		      "Type": "Pass",
		      "End": true
		    }
		  }
		}



## Processing Inputs and Outputs in a State Machine 


- The input to a Step Function(SF) is passed in JSON format 
- The input is then passed to the first state in the state macine 
- Eache state machin will recievve JSOn data as input and usually generates JSON as output
- We can associate different kinds of filters to maniulate data in each state both before and after the 
task processing.



# Input Filters: InputPath and Parameters 

We use the InputPath and Parameters fields to manipuate the data before task processing 











                    