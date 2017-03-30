#!/bin/sh
#Parameters:
# NET = {main,test} | Default: main
# BCPATH = Bitcoin-Core folder

#Check 'jq' is installed
#This script currently makes use of jq to parse the JSON object return by bitcoin-cli
hash jq
if [ $? -ne 0 ]; then
  echo "ERROR: jq is not installed. Exiting..."
  exit 5
fi

#Handle Ctrl-C Exiting
trap ctrl_c INT
function ctrl_c() {
  echo "\nExiting program..."
  if [ ! -z ${BCD+x} ]; then
    echo "Stopping bitcoind (PID $BCD)"
    kill $BCD
  fi
  exit 0
}

#Parse NET
if [[ $# -gt 0 ]] ; then
  case $1 in
    main)
    NET='mainnet'
    ;;
    test)
    NET='testnet'
    NETPAR='-testnet'
    ;;
    *)
    echo "WARNING: Unknown network option. Selecting default network (Mainnet)"
    NET='mainnet'
  esac
fi

#Parse BCPATH
if [[ $# -gt 1 ]]; then
  if [ ! -d "$2" ]; then
    echo "ERROR: Bitcoin-Core path does not exist. Exiting..."
    exit 1
  fi
  if [ ! -f "$2/bin/bitcoind" ]; then
    echo "ERROR: Bitcoin-Core path is incorrect. Exiting..."
    exit 1
  fi
  BCPATH="$2"
else BCPATH=/opt/bitcoin/
fi

echo "Running '$BCPATH/bin/bitcoind $NETPAR &'"

#Start Bitcoin-Core
$BCPATH/bin/bitcoind $NETPAR &
BCD=$!

echo -n "Loading..."
sleep 5
$BCPATH/bin/bitcoin-cli $NETPAR getblockchaininfo > /dev/null 2>&1
while [ $? = 28 ]; do
  echo -n "."
  sleep 3 && \
  $BCPATH/bin/bitcoin-cli $NETPAR getblockchaininfo > /dev/null 2>&1
done
echo "."
BC_STATUS=$($BCPATH/bin/bitcoin-cli $NETPAR getblockchaininfo)
if [ $? -gt 0 ]; then
  echo "ERROR: bitcoind seems not to be running. Exiting..."
  kill $BCD
  exit 2
fi
BC_CURRENT=$(echo $BC_STATUS | jq '.blocks')
BC_TOTAL=$(echo $BC_STATUS | jq '.headers')

# if [ $BC_CURRENT -lt $BC_TOTAL ]; then echo "Downloading blocks..."; fi
while [ $BC_CURRENT -lt $BC_TOTAL ]; do
  echo "Downloading blocks... ($BC_CURRENT/$BC_TOTAL)"
  sleep 5
  BC_STATUS=$($BCPATH/bin/bitcoin-cli $NETPAR getblockchaininfo)
  BC_CURRENT=$(echo $BC_STATUS | jq '.blocks')
  BC_TOTAL=$(echo $BC_STATUS | jq '.headers')
done

echo "Done. Bitcoind is running and up-to-date (PID $BCD)"
