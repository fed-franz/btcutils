#!/bin/bash

# Local Variables
datadir=$HOME/.bitcoin

# Check Bitcoin Network Option and setup paths and aliases
logdir=$datadir
for i in "$@"
do
   case "$i" in
   "-h")
      print_help=true
      ;;
   "-testnet")
      obtcnet="-testnet"
      logdir=$datadir/testnet3
      ;;
   "-regtest")
      obtcnet="-regtest"
      logdir=$datadir/regtest
      ;;
   *) btcdopts+="$i "
   esac
done
btcdopts="$obtcnet $btcdopts"

# Local variables
btcstart="bitcoind $btcdopts"
btcd="bitcoind $obtcnet"
btccli="bitcoin-cli $obtcnet"

# Set container aliases
echo \
"
btcdopts=\"$btcdopts\"

alias btcd='$btcd'
alias btccli='$btccli'
alias getblockcount='$btccli getblockcount'
alias getpeers='$btccli getpeerinfo'
alias getpeersaddr=\"getpeers | grep --color=never -E '\\\"addr\\\": \\\"|inbound'\"
alias btcstart='$btcstart'
alias btcstop='$btccli stop'
alias getlog='cat $logdir/debug.log'"\
 > ~/.bashrc

# Set container functions
echo \
"
function start_btc () {
   echo $btcstart
   $btcstart
}

function stop_btc () {
   echo $btccli stop
   $btccli stop
}

function check_btc () {
   echo $btccli getblockcount &> /dev/null
   $btccli getblockcount &> /dev/null
}
"\
> ~/.bash_aliases

# Print aliases to screen
if [ "$print_help" = true ]; then
   echo "
   bashrc:"
   cat ~/.bashrc
   echo "
   bash_aliases:"
   cat ~/.bash_aliases
fi

# Load aliases
source ~/.bashrc
source ~/.bash_aliases

# Start Bitcoin Core
start_btc