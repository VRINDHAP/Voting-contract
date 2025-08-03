// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This block is for creating the Voting contract
contract Voting {
    address public owner; // This block is for storing contract creator
    mapping(string => uint) public votesReceived; // This block is for vote counts
    string[] public candidates; // This block is for storing candidate list
    mapping(address => bool) public hasVoted; // This block is to prevent double voting

    // This block is for initializing the contract with candidate names
    constructor(string[] memory candidateNames) {
        owner = msg.sender;
        candidates = candidateNames;
    }

    // This block is for checking if the candidate is valid
    function validCandidate(string memory name) public view returns (bool) {
        for (uint i = 0; i < candidates.length; i++) {
            if (keccak256(abi.encodePacked(candidates[i])) == keccak256(abi.encodePacked(name))) {
                return true;
            }
        }
        return false;
    }

    // This block is for voting by users
    function vote(string memory candidate) public {
        require(validCandidate(candidate), "Invalid candidate");
        require(!hasVoted[msg.sender], "You have already voted");

        votesReceived[candidate]++;
        hasVoted[msg.sender] = true;
    }

    // This block is for getting total votes of a candidate
    function totalVotes(string memory candidate) public view returns (uint) {
        require(validCandidate(candidate), "Invalid candidate");
        return votesReceived[candidate];
    }
}

