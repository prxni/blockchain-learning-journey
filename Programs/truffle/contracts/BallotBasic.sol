// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.7;

/// @title A Simple Ballot Contract
/// @dev This contract implements a basic voting system.
contract Ballot {

    /// @notice Represents a voter with their weight and voting status.
    struct Voter {
        uint weight;      // Weight of the vote (typically 1, chairperson has higher weight)
        bool voted;       // Indicates if the voter has already voted
        uint8 vote;       // Index of the voted proposal
        // address delegate; // Placeholder for potential delegate functionality
    }

    /// @notice Represents a proposal with a vote count.
    struct Proposal {
        uint voteCount;   // Number of votes this proposal has received
        // Additional proposal data could be added here
    }

    address chairperson;                     // Address of the person who creates the ballot
    mapping(address => Voter) voters;       // Mapping of voter addresses to their information
    Proposal[] proposals;                   // Array of proposals to be voted on

    /// @notice Initializes the ballot with a specified number of proposals.
    /// @param _numProposals The number of proposals to include in the ballot.
    constructor(uint8 _numProposals) {
        chairperson = msg.sender;           // The creator of the contract becomes the chairperson
        voters[chairperson].weight = 2;     // Chairperson's vote has double weight
        for (uint8 i = 0; i < _numProposals; i++) {
            proposals.push(Proposal(0));    // Initialize each proposal with 0 votes
        }
    }

    /// @notice Gives the right to vote to a specified address.
    /// @dev Can only be called by the chairperson and for addresses that haven't voted yet.
    /// @param toVoter The address of the voter to register.
    function register(address toVoter) public {
        if (msg.sender != chairperson || voters[toVoter].voted) return;
        voters[toVoter].weight = 1;         // Assign a vote weight of 1
        voters[toVoter].voted = false;      // Ensure the voter hasn't voted yet
    }

    /// @notice Casts a vote for a specified proposal.
    /// @param toProposal The index of the proposal to vote for.
    function vote(uint8 toProposal) public {
        Voter storage sender = voters[msg.sender];
        if (sender.voted || toProposal >= proposals.length) return;
        sender.voted = true;                // Mark the voter as having voted
        sender.vote = toProposal;           // Record the proposal they voted for
        proposals[toProposal].voteCount += sender.weight; // Increment the vote count for the proposal
    }

    /// @notice Returns the index of the winning proposal.
    /// @return _winningProposal The index of the proposal with the highest vote count.
    function winningProposal() public view returns (uint8 _winningProposal) {
        uint256 winningVoteCount = 0;
        for (uint8 prop = 0; prop < proposals.length; prop++) {
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                _winningProposal = prop;
            }
        }
    }
}
