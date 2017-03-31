# blockchain-code
Scripts and tools for Bitcoin, Colored Coins and other Bitcoin-based blockchains

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
