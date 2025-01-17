// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.7;

// A simple contract to demonstrate shared storage and basic operations
contract SimpleStorage {
    // A state variable to store a single unsigned integer
    uint storedData;

    // Function to set the value of the storedData variable
    // Accepts an unsigned integer `x` and updates the state variable
    function set(uint x) public {
        storedData = x;
    }

    // Function to get the current value of storedData
    // Returns the unsigned integer stored in the variable
    function get() public view returns (uint) {
        return storedData;
    }
    
    // Function to increment the stored value by a given amount
    // Accepts an unsigned integer `n` and adds it to storedData
    function increment(uint n) public {
        storedData = storedData + n;
        return;
    }
    
    // Function to decrement the stored value by a given amount
    // Accepts an unsigned integer `n` and subtracts it from storedData
    function decrement(uint n) public {
        storedData = storedData - n;
        return;
    }
}
