#!/usr/bin/env bash
# Mining options
ALGORITHM=x17
MINING_POOL_URL=stratum+tcp://yiimp.eu:3777
REVENUE_WALLET_ADDRESS=D5qHR7NsMnxTk3UcMuuwB1AppmcqA2cCt2
# Enable root
sudo -i
# Update & upgrade software
apt-get update && apt-get upgrade -y
# Installation of required software
apt-get install git automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++ zlib1g-dev -y
# Get the source code of cpuminer
git clone https://github.com/tpruvot/cpuminer-multi
# Build cpuminer
cd cpuminer-multi/
./build.sh
# Enable starts of mining on server startup
cat <<EOF >/etc/rc.local
#!/bin/sh -e
/home/vagrant/cpuminer-multi/cpuminer -a ${ALGORITHM} -o ${MINING_POOL_URL} -u ${REVENUE_WALLET_ADDRESS} -p c=XVG &
EOF
chmod +x /etc/rc.local
systemctl daemon-reload
systemctl start rc-local