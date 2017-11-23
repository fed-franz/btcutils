# btc-utils
Scripts and tools for Bitcoin

# start-bitcoind
Script for the Bitcoin-Core client. It starts the bitcoind daemon and wait until it is fully initialized.
(I wrote it because bitcoind gives no feedback of its status so the way to know if it's done with loading is to manually probe it via RCP or bitcoin-cli)
This automatically probe bitcoind and prints the status feedback until the initiazlization phase is finished.
(Init phase consists of: Loading block index, rewinding blocks, verifying, and downloading missing blocks).
The script terminates when all the blocks have been downloaded.

Requirements:
- Bitcoin-Core: https://bitcoin.org/en/download
- 'jq' software

___ USAGE ___

Parameters:
- NET = {main,test} | Default: main
- BCPATH = Bitcoin-Core folder | Default: /opt/bitcoin

Example: start-bitcoind test /path/to/bitoin-folder

# btc-addr-utils
Requirements:
- 'bitcore-lib': npm install bitcore-lib

Library for Bitcoin addresses management.
It provides the following functions:
- createBTCKey: create a new Bitcoin private key
- getBTCNetwork(privKey, net): it returns the Mainnet/Testnet address corresponding to a private key
- getBTCAddr(addr): determine if the address belongs to the Mainnet or the Testnet network
- isValidAddr(addr): check if the address is a valid Bitcoin address
- isValidMainnetAddr(addr): check if the address is a valid Mainnet address
- isValidTestnetAddr(addr): check if the address is a valid Testnet address

