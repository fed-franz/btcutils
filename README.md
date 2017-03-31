# blockchain-code
Scripts and tools for Bitcoin, Colored Coins and other Bitcoin-based blockchains

# start-bitcoind
Script for the Bitcoin-Core client.
It starts the bitcoind daemon and wait until it is fully functional.
It gives status feedback until the daemon is upo.
(Loading block index, rewinding blocks, verifying, and downloading missing blocks). It terminates when the blocks are up-to-date

Requirements:
- Bitcoin-Core: https://bitcoin.org/en/download
- 'jq' software

___ USAGE ___
Parameters:
- NET = {main,test} | Default: main
- BCPATH = Bitcoin-Core folder | Default: /opt/bitcoin

Example: start-bitcoind test /path/to/bitoin-folder
