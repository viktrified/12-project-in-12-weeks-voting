// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;  

contract Voting {   // a contract of a regular dual voting system
    uint256 public yesVotes;  // tracks all yes votes
    uint256 public noVotes;   // tracks all no votes

    mapping(address => bool) public hasVoted; // telling if a user has voted or not
    mapping (address => bool) public voteChoice;  // telling you if a user voted yes or no

    function voteYes() public {   // declares the voteYes function with no parameter
        require(!hasVoted[msg.sender]);   // user can vote if only he hasn't voted before

        yesVotes++;   // the general "yes" count increases
        hasVoted[msg.sender] = true; // checks if the user has voted
        voteChoice[msg.sender] = true;  // checks wether the user voted either yes or no 
        getResult();    // returns the results in percentages 
    }

        function voteNo() public {  // declares the voteNo function with no parameter
        require(!hasVoted[msg.sender]);   // user can vote if only he hasn't voted before

        noVotes++;    // the general "no" count increases
        hasVoted[msg.sender] = true;  // checks if the user has voted
        voteChoice[msg.sender] = false;  // checks wether the user voted either yes or no
        getResult();    // returns the results in percentages
    }

    function changeVote(bool newVote) public {  // declares a function changeVote(), that has a bool parameter newVote
        require(hasVoted[msg.sender]);  // user can change vote only if he has voted before
        bool previousVote = voteChoice[msg.sender];  // declares a local variable previousVote and assigns voteChoice[msg.sender] as its value

        if (previousVote && !newVote) { // an if statement that will execute only if the user previous vote was yes and the his new vote is no
            yesVotes--;  // general yes decreases
            noVotes++;  // general no increases
        } else if (!previousVote && newVote){  // an else if statement that will execute only if the user previous vote was no and his new vote is yes
            yesVotes++; // general yes increases
            noVotes--;  // general no decreases
        }

        voteChoice[msg.sender] = newVote;   // assigns voteChoice[msg.sender] a value newVote at the end of the function to update the users latest vote 
        getResult();    // returns the results in percentages
    }

    function getResult() public view returns (uint256 yesPercentage, uint256 noPercentage) {   // declares a function getResult() that returns and displays two parameters, yesPercentage and noPercentage 
        uint256 totalVotes = yesVotes + noVotes;   // declares a local variable totalVotes that sums up the general yesVotes and noVotes

        if (totalVotes == 0) {  // an if statement that will executes only if the total vote is equal to zero
            return (0, 0);  // stop execution and returns the results as zero 
        }
        yesPercentage = (yesVotes/totalVotes) * 100; // assigns yesPercentage to a value that calculates the percentage of the total yes votes 
        noPercentage = (noVotes/totalVotes) * 100;   // assigns noPercentage to a value that calculates the percentage of the total no votes
    }
}   