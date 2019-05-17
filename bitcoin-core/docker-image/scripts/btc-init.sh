#!/bin/bash

# Get Arguments
btcdir="./btc"
btcnet=$1

# Aliases
datadir=$HOME/.bitcoin
logdir=

# Bitcoin Networ Option
obtcnet=""
case "$btcnet" in
 "testnet")
    obtcnet="-testnet"
    logdir=$datadir/testnet3
    ;;
 "regtest")
    obtcnet="-regtest"
    logdir=$datadir/regtest
    ;;
  *)
    btccli="bitcoin-cli"
    logdir=$datadir

esac

btcd="bitcoind $obtcnet -onlynet=ipv4 -logips"
btccli="bitcoin-cli $obtcnet"

echo \
"alias bitcoind='btcd'
alias bitcoin-cli='$btccli'
alias getblockcount='$btccli getblockcount'
alias getpeers='$btccli getpeerinfo'
alias getpeersaddr=\"getpeers | grep --color=never -E '\\\"addr\\\": \\\"|inbound'\"
alias btcstart='$btcd'
alias btcstop='$btccli stop'
alias getlog='cat $logdir/debug.log'"\
 >> ~/.bashrc

echo \
"
function start_btc () {
 $btcd #-daemon
 sleep 15
}

function stop_btc () {
 $btccli stop
 sleep 15
}

function check_btc () {
 $btccli getblockcount &> /dev/null
}
"\
>> ~/.bash_aliases

source ~/.bashrc
source ~/.bash_aliases
start_btc