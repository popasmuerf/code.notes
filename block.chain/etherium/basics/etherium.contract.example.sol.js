pragma solidity >=0.4.22 <0.6.0 ;  //Compiler directive


//contract class...actually called 'contract'

contract Ballot{

	struct Voter{
		unit weight ;
		bool voted ;
		unit8 vote ;
		address delegate ;
	}



	struct Proposal{
		unit voteCount ;
	}



	///create a new ballot with $(_numProposals) different proposals.
	constructor(uint8 _numProposals) public{
		chairperson = msg.sender ;
		voters[chairpers].weight = 1 ;
		proposals.length = _numProposals ;
	}


	/// Give $(toVoter) the right to vote on this ballot
	/// May only be called by $(chairperson)
	function giveRightToVote(address toVoter) public{
		if(msg.sender != chairperson || voters[toVoter].voted) return ;
		voters[toVoter].weight = 1 ;
	}



	/// Delegate your vote to the voter $(to)
	function delegate(address to) public{
		Voter storage sender = voters[msg.sender] ; //asssigns reference
		if(sender.voted) return ;
		while(voters[to].delegate != address(0) && voters[to].delegate != msg.sender)
		to = voters[to].delegate ;
		if(to == msg.sender) return ;
		sender.voted = true ;
		sender.delegate = to ;
		 Voter storage delegateTo = voters[to];
        if (delegateTo.voted)
            proposals[delegateTo.vote].voteCount += sender.weight;
        else
            delegateTo.weight += sender.weight;
    }

    /// Give a single vote to proposal $(toProposal).
    function vote(uint8 toProposal) public {
        Voter storage sender = voters[msg.sender];
        if (sender.voted || toProposal >= proposals.length) return;
        sender.voted = true;
        sender.vote = toProposal;
        proposals[toProposal].voteCount += sender.weight;
    }

    function winningProposal() public view returns (uint8 _winningProposal) {
        uint256 winningVoteCount = 0;
        for (uint8 prop = 0; prop < proposals.length; prop++)
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                _winningProposal = prop;
            }
    }
}

		
	}


}
