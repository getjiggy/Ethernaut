import json
import time
from itertools import permutations, combinations
from pprint import pprint
import asyncio
from web3 import Web3, HTTPProvider
import os

provider = Web3.HTTPProvider('https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161')
w3 = Web3(provider)
vic = Web3.toChecksumAddress("0xffffffffffffffffffffffffffffffffffffffff")
store = w3.eth.getStorageAt(vic, 5)
print(Web3.toHex(store))

#no such thing as privacy on the block chain. use this script to query the storage variables of the contract, then use metamask or a contract to unlock using the private key retreived. 
