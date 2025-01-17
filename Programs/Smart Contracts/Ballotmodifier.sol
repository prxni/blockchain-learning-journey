// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.7;

/// @title A Ballot Contract with Voting Stages
/// @dev Implements a voting system with stages: Registration, Voting, and Completion.
contract Ballot {

    /// @notice Represents a voter with a weight, voting status, and delegate information.
    struct Voter {
        uint weight;      // Voting weight, typically 1 (chairperson has higher weight)
        bool voted;       // Whether the voter has cast a vote
        uint8 vote;       // Index of the voted proposal
        address delegate; // Address of the delegate, if any
    }

    /// @notice Represents a proposal with a vote count.
    struct Proposal {
        uint voteCount;   // Number of votes this proposal has received
    }

    /// @notice Enum representing the stages of the voting process.
    enum Stage {Init, Reg, Vote, Done}
    Stage public stage = Stage.Init;        // Tracks the current stage of the voting process

    address chairperson;                    // Address of the chairperson who initializes the contract
    mapping(address => Voter) voters;       // Mapping of voter addresses to voter details
    Proposal[] proposals;                   // Array of proposals to be voted on

    uint startTime;                         // Timestamp when the contract was initialized

    /// @notice Event emitted when voting is completed.
    event votingCompleted();

    /// @dev Modifier to ensure a function is called at the correct stage.
    /// @param reqStage The stage required for the function to execute.
    modifier validStage(Stage reqStage) {
        require(stage == reqStage, "Invalid stage for this operation");
        _;
    }

    /// @notice Constructor to initialize the contract with a specified number of proposals.
    /// @param _numProposals The number of proposals to include in the ballot.
    constructor(uint8 _numProposals) {
        chairperson = msg.sender;           // Chairperson is the contract deployer
        voters[chairperson].weight = 2;     // Chairperson has a voting weight of 2
        for (uint8 i = 0; i < _numProposals; i++) {
            proposals.push(Proposal(0));    // Initialize proposals with a vote count of 0
        }
        stage = Stage.Reg;                  // Set the stage to Registration
        startTime = block.timestamp;        // Record the start time
    }

    /// @notice Registers a voter for the ballot.
    /// @dev Only callable by the chairperson during the Registration stage.
    /// @param toVoter The address of the voter to register.
    function register(address toVoter) public validStage(Stage.Reg) {
        require(msg.sender == chairperson, "Only the chairperson can register voters");
        require(!voters[toVoter].voted, "Voter already registered");
        voters[toVoter].weight = 1;         // Assign a voting weight of 1
        voters[toVoter].voted = false;      // Ensure the voter hasn't voted

        // Transition to Voting stage after 30 seconds
        if (block.timestamp > startTime + 30 seconds) {
            stage = Stage.Vote;
        }
    }

    /// @notice Allows a voter to cast their vote for a proposal.
    /// @dev Callable during the Voting stage.
    /// @param toProposal The index of the proposal to vote for.
    function vote(uint8 toProposal) public validStage(Stage.Vote) {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "You have already voted");
        require(toProposal < proposals.length, "Invalid proposal");

        sender.voted = true;                // Mark the voter as having voted
        sender.vote = toProposal;           // Record the voted proposal
        proposals[toProposal].voteCount += sender.weight; // Increment the vote count

        // Transition to Done stage after 30 seconds
        if (block.timestamp > startTime + 30 seconds) {
            stage = Stage.Done;
            emit votingCompleted();         // Emit an event indicating voting completion
        }
    }

    /// @notice Determines the winning proposal.
    /// @dev Callable only during the Done stage.
    /// @return _winningProposal The index of the proposal with the highest votes.
    function winningProposal() public view validStage(Stage.Done) returns (uint8 _winningProposal) {
        uint256 winningVoteCount = 0;
        for (uint8 prop = 0; prop < proposals.length; prop++) {
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                _winningProposal = prop;
            }
        }
        require(winningVoteCount > 0, "No votes cast"); // Ensure at least one vote was cast
    }
}
