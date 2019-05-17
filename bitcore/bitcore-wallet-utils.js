/* bitcore-wallet-utils.js */
'use strict';

const btcaddrutils = require('./bitcore-addr-utils')
const explorers = require('bitcore-explorers')

module.exports = {
  getBalance: getBTCAddrBalance,
};

/* Returns the total spendable satoshis for 'addr' */
function getBTCAddrBalance(addr, callback){
  var network = btcaddrutils.getBTCNetwork(addr)
  var insight = new explorers.Insight(network)

  insight.getUnspentUtxos(addr, function(err, utxos){
    if(err) return callback(err)

    var balance = 0
    for(var i in utxos)
      balance += utxos[i].satoshis

    return callback(null, balance)
  });
}
