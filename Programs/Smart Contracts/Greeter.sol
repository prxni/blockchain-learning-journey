// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.7;

// A simple contract to set and greet a name
contract Greeter  {
    // A public variable to store the name
    string public yourName;  
    
    /* Constructor: This runs when the contract is deployed 
       and sets the initial value of yourName to "world" */
    constructor() {
        yourName = "world";
    }
    
    // Function to update the value of yourName
    // Accepts a string input and updates the yourName variable
    function set(string memory name) public {
        yourName = name;
    }
    
    // Function to return a greeting message
    // Concatenates the string "hello " with the value of yourName
    function hello() public view returns (string memory) {
        return string(abi.encodePacked("hello ", yourName));
    }
}
