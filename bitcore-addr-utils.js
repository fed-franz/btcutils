/* bitcore-utils.js */
'use strict';

const bitcore = require('bitcore-lib')
const explorers = require('bitcore-explorers')

module.exports = {
  getBTCNetwork: getBTCNetwork,
  createBTCKey: createBTCKey,
  getBTCAddr: getBTCAddr,
  isValidAddr: isValidAddr,
  getBTCAddrBalance: getBTCAddrBalance,
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

/* Check if 'addr' is a valid address for 'net' network*/
function isValidAddr(addr, net){
  return bitcore.Address.isValid(addr, net)
}

/* Check if 'addr' is a valid Bitcoin address */
function isValidBTCAddr(addr){
  var net = getBTCNetwork(addr)
  return bitcore.Address.isValid(addr, net)
}

/* Returns the total spendable satoshis for 'addr' */
function getBTCAddrBalance(addr, callback){
  var network = getBTCNetwork(addr)
  var insight = new explorers.Insight(network)

  insight.getUnspentUtxos(addr, function(err, utxos){
    if(err) return callback(err)

    var balance = 0
    for(var i in utxos)
      balance += utxos[i].satoshis

    return callback(null, balance)
  });
}
