Contract Lab
=====================================
//declaring our contract...
contract MyContract{
	
	/*
	The variable amount will hold the accumulated money sent by the contract
	executors to the contract creator.   The value field will hold the contract
	value.  As the executors execute the contract, the value field will be modified to
	reflect the balanced contract value....

	*/
	uint amount ;
	uint value ;

	
	/*
	In the contract constructor, we set the values of these two variables ;
	*/

	constructor (uinit initalAmount, uint initalValue) public {
		amount = 0 ;
		value = 1000 ;
	}


	/**
	As initially, the amount collected on the contract is zero we set the amount field
	to 0. We set the contract value to soem arbitrary number, in this cas it is 1000.
	The contract creator decides this value....
	To examine the collected amount at any given point of time, we provide a public
	contract method called getAmount() definted as follows -----

	*/

	function getAmount() public view returns(unit){
		return amount ;B
	}


	/**
	To get the balanced contract value at any given point of time, we define
	getBalance method as follows--
	*/

	function getBalance() pblic view returns(unit){
		return value ;
	}


	/**
	Finally, we write a ontract method (Send). It enables the clients to send
	some money to the contract creator...
	*/

	function send(uint newDeposit) public{
		value = value - newDeposit ;
		amount = amount + newDeposit ;
	}
		
}
