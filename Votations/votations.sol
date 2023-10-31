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

    //Show candidates names
    function showCandidates() external view returns(string[] memory){
        return candidates;
    }

    //Get candidate votes
    function getVotes(string memory _candidate) external view returns(uint){
        return candidate_Votes[_candidate];
    }


}

