/* bitcore-addr-utils.js */
'use strict';

const bitcore = require('bitcore-lib')

module.exports = {
  getBTCNetwork: getBTCNetwork,
  createBTCKey: createBTCKey,
  getBTCAddr: getBTCAddr,
  isValidAddr: isValidAddr,
};

/* Create new Bitcoin address */
function createBTCKey(){
  return new bitcore.PrivateKey().toWIF();
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
  return bitcore.Address.isValid(addr, bitcore.Networks.mainnet)

/* Check if 'addr' is a valid Testnet address for 'net' network*/
function isValidTestnetAddr(addr){
  return bitcore.Address.isValid(addr, bitcore.Networks.testnet)

}
