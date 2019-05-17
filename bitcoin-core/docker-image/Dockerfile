# Bitcoin Node

FROM debian:latest

# ENV
ENV localbtcdir=./btc/
ENV localscriptdir=scripts
ENV btcdir=/root/.bitcoin/

# Copy Bitcoin files
COPY ${localbtcdir}/bitcoind ${localbtcdir}/bitcoin-cli /usr/local/bin/
RUN chmod a+x /usr/local/bin/bitcoind /usr/local/bin/bitcoin-cli
COPY ${localbtcdir}/bitcoin.conf ${btcdir}/bitcoin.conf
COPY ${localscriptdir} ./
RUN chmod a+x ./*.sh

# Expose Bitcoin ports
EXPOSE 8333 8332 18333 18332 18443 18444

# Run 'init' script
ENTRYPOINT ["./init.sh"]
CMD [""]