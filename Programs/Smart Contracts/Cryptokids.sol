// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.7;

/**
 * @title CriptoKids
 * @dev A smart contract that allows parents (owner) to set up accounts for their kids,
 * deposit funds, and allow withdrawal by the kids after a specific release time.
 */
contract Criptokids{

    // owner address
    address owner;

    // Event to log deposits made to a kid's account
    event LogKidFundingReceived(address addr, uint amount, uint contractBalance);

    //Struct to represent a Kid's account
    struct Kid{
        address payable walletAddress;
        string firstName;
        string lastName;
        uint amount;
        uint releaseTime;
        bool canWithdraw;
    }

    // Array to store all kids' accounts
    Kid[] public kids;

    //the person which deploys the contract first will be the owner
    constructor()
    {
        owner=msg.sender;
    }

    // Modifier to restrict access to owner-only functions
    modifier onlyOwner()
    {
        require(msg.sender == owner,"Only the owner can perform this function");
        _;
    }

    //Function to add a kid to the contract.
    function addKid(address payable walletAddress, string memory firstName,string memory lastName,uint amount,uint releaseTime,bool canWithdraw) public onlyOwner{
        kids.push(Kid(walletAddress,
        firstName,
        lastName,
        amount,
        releaseTime,
        canWithdraw));
    }

    /**
     * @dev Internal helper function to find the index of a kid by their wallet address.
     * @param walletAddress The Ethereum address of the kid.
     * @return The index of the kid in the `kids` array, or 999 if not found.
     */
    function getIndex(address walletAddress) view private returns(uint) {
        for(uint i = 0; i < kids.length; i++) {
            if (kids[i].walletAddress == walletAddress) {
                return i;
            }
        }
        return 999;
    }

    //Public function to get the balance of the contract.
    function balanceOf() public view returns (uint) {
        return address(this).balance;
    }

    //Function to deposit Ether into the contract for a specific kid.
    function deposit(address walletAddress) payable public 
    {
        addToKidBalance(walletAddress);
    }
    
    //Internal function to add deposited Ether to a kid's balance.
    function addToKidBalance(address walletAddress) private{
        uint index=getIndex(walletAddress);
        require(index != 999,"Invalid address");
        kids[index].amount+=msg.value;
        emit LogKidFundingReceived(walletAddress, msg.value, balanceOf());
    }

    //Function to check if a kid is eligible to withdraw funds.
    function readyToWithdraw(address walletAddress) public returns (bool){
        uint index=getIndex(walletAddress);
        require(index != 999,"Invalid address");
        if (block.timestamp > kids[index].releaseTime) {
            kids[index].canWithdraw = true;
            return true;
        } else {
            return false;
        }
    }

    //Function for a kid to withdraw their funds.
    function withdraw() payable public {
        uint i = getIndex(msg.sender);
        require(i != 999,"Invalid address");
        readyToWithdraw(msg.sender);
        require(kids[i].canWithdraw == true, "You are not able to withdraw at this time");
        kids[i].walletAddress.transfer(kids[i].amount);
    }
}