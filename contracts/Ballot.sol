//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BallotContract{

    event giveAcessToVoteEvent(address x, address y);

    address public admin;

    struct Proposal {
        bytes32 name;
        uint256 voteCount;
    } 

    struct Voter{
        address delegate;//A person who represents others.
        uint256 weight;
        bool isVoted;
        uint256 votedTo;
    }

    mapping (address=>Voter) public voters;
    Proposal[] public proposals;

    

    constructor(bytes32[] memory c_proposal){

        admin = msg.sender;
        voters[msg.sender].weight =1;
        for(uint64 i=0;i<c_proposal.length;i++)
        {
            proposals.push(Proposal({ name: c_proposal[i],voteCount: 0 }));
        }

    }

    function giveAcessToVote(address voter_t)  public{

        emit giveAcessToVoteEvent(voter_t,msg.sender);

        require(msg.sender==admin,"you dont have access");
        require(voters[voter_t].isVoted == false,"Already voted");
        require(voters[voter_t].weight==0,"weight not zero wrong call");
        
        voters[voter_t].weight =1;

    }    

    function vote(uint256 proposalIndexId) public {

        require(voters[msg.sender].isVoted == false,"Already Voted");
        require(voters[msg.sender].weight!=0,"please get access");
        voters[msg.sender].isVoted=true;
        voters[msg.sender].votedTo=proposalIndexId;
        proposals[proposalIndexId].voteCount += voters[msg.sender].weight;
        
    }


    function winningProposal() public view returns(uint256)
    {
        uint256 winnerIndex=0;
        uint256 maxcount=0;

        for(uint64 i=0;i<proposals.length;i++)
        {
            if(proposals[i].voteCount > maxcount)
            {
                maxcount = proposals[i].voteCount;
                winnerIndex=i;
            }
        }

        return winnerIndex;
    }
    
    function winnerName() public view returns(bytes32)
    {
        return proposals[winningProposal()].name;
    }

    function deligateMyVoteTo(address to) public {

       Voter storage sender =voters[msg.sender];
       require(msg.sender !=  to, "self deligation error");
       require(sender.isVoted==false, "already voted");

       while(voters[to].delegate!=address(0))
       {
            to = voters[to].delegate;
            require(to != msg.sender,"loop in deligation" );
       }
       sender.isVoted=true;
       sender.delegate = to;

       Voter storage delegate_ = voters[to];

       if(delegate_.isVoted ){

            proposals[delegate_.votedTo].voteCount +=sender.weight ;

       }
       else{
            delegate_.weight += sender.weight;
       }
        
    }


}