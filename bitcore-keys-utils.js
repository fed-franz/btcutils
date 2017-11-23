/* bitcore-addr-utils.js */
'use strict';

const bitcore = require('bitcore-lib')
const Mainnet = bitcore.Networks.mainnet
const Testnet = bitcore.Networks.testnet

module.exports = {
  createBTCKey: createBTCKey,
  getBTCNetwork: getBTCNetwork,
  getBTCAddr: getBTCAddr,
  isValidAddr: isValidAddr,
  isValidMainnetAddr: isValidMainnetAddr,
  isValidTestnetAddr: isValidTestnetAddr
};

/* Create new Bitcoin address */
function createBTCKey(){
  return new bitcore.PrivateKey().toWIF();
}

/* Get the public key from private key or public key hex-string */
function getPubKey(privKey){
  return new bitcore.PublicKey(privKey)
}

/* Returns the address for the key */
function getBTCAddr(privKey, BTCnet){
  var pk = new bitcore.PrivateKey(privKey)
  return pk.toAddress(BTCnet).toString()
}

/* Return the network for */
function getBTCNetwork(addr){
  var addrObj = new bitcore.Address(addr)
  return addrObj.network
}

/* Check if 'addr' is a valid Bitcoin address */
function isValidAddr(addr){
  var net = getBTCNetwork(addr)
  return bitcore.Address.isValid(addr, net)
}

/* Check if 'addr' is a valid Mainnet address for 'net' network*/
function isValidMainnetAddr(addr){
  return bitcore.Address.isValid(addr, Mainnet)

/* Check if 'addr' is a valid Testnet address for 'net' network*/
function isValidTestnetAddr(addr){
  return bitcore.Address.isValid(addr, Testnet)
}
