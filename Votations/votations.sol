// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract votation{

    //Owner address
    address public owner;

    //Constructor
    constructor (){
        owner = msg.sender;
    }

    //Associate string with hash
    mapping (string => bytes32) id_Candidate;

    //Associate string with vote count
    mapping (string => uint) candidate_Votes;

    //Dinamic array with candidate names
    string[] candidates;

    //Dinamic array with voters hash
    bytes32[] voters;

    //Any person can postulate as a candidate
    function Postulate(string memory _name, uint _age, string memory _id) external{
        id_Candidate[_name] = keccak256(abi.encodePacked(_name,_age,_id));
        candidates.push(_name);
    }

    //Checks if person has voted
    function hasVoted(bytes32 voter_Hash) private view returns (bool){
        uint i = 0;
        bool flag = false;
        while(i<voters.length && flag == false){
            if(voter_Hash == voters[i])
                flag = true;
            i++;
        }
        return flag;
    }

    //Any person can vote a candidate
    function Vote(string memory _candidate) external{
        bytes32 voter_Hash = keccak256(abi.encodePacked(msg.sender));
        require(!hasVoted(voter_Hash),"Already voted!");
        voters.push(voter_Hash);
        candidate_Votes[_candidate]++;
    }

    //Show candidates names
    function showCandidates() external view returns(string[] memory){
        return candidates;
    }

    //Get candidate votes
    function getVotes(string memory _candidate) external view returns(uint){
        return candidate_Votes[_candidate];
    }

    //Get winner candidate
    function getWinner() external view returns(string memory){
        bool tie = false;
        string memory maxVotesCandidate = candidates[0];
        for(uint i=1; i<candidates.length; i++){
            if(candidate_Votes[candidates[i]] > candidate_Votes[maxVotesCandidate]){
                maxVotesCandidate = candidates[i];
                tie = false;
            }
            else
                if(candidate_Votes[candidates[i]] == candidate_Votes[maxVotesCandidate])
                    tie = true;
        }
        if(!tie)
            return maxVotesCandidate;
        else
            return "TIE";
    }

}

