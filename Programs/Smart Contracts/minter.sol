// SPDX-License-Identifier: Unlicensed

/*
    Coin Contract
    A simple cryptocurrency contract where the contract owner (minter) has the ability to mint new coins and assign them to users.
    Users can transfer coins between each other as long as they have sufficient balance.

    Key Features:
    - The contract owner (minter) is the only address that can mint new coins.
    - Coins are tracked using a mapping of addresses to balances.
    - The contract allows users to send coins to other addresses, provided they have sufficient balance.
    - An event `Sent` is emitted whenever coins are successfully transferred, allowing external applications to track transfers.

    Functions:
    - mint(address receiver, uint amount): Allows the minter to mint new coins and assign them to a specific address.
    - send(address receiver, uint amount): Allows users to send coins to another address if they have enough balance.
    - Sent(address from, address to, uint amount): Event emitted when a transfer of coins is completed.
*/

// Declare the contract
pragma solidity ^0.8.7;

contract Coin {
    // The address of the contract's minter (creator)
    address public minter;

    // Mapping to track the balance of each address
    mapping (address => uint) public balances;

    // Event that gets emitted when a coin transfer occurs
    event Sent(address from, address to, uint amount);

    // Constructor that sets the minter to the contract creator's address
    constructor(){
        minter = msg.sender;
    }

    // Function to mint new coins and assign them to the specified receiver
    function mint(address receiver, uint amount) public {
        // Only the minter (contract creator) can mint coins
        if (msg.sender != minter) return;
        balances[receiver] += amount;
    }

    // Function to send coins from the sender to the receiver
    function send(address receiver, uint amount) public {
        // Ensure the sender has enough balance to complete the transfer
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        // Emit the Sent event to log the transaction
        Sent(msg.sender, receiver, amount);
    }
}
