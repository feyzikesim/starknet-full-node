# StarkNet Full Node Setup

StarkNet is a decentralized L2 rollup over Ethereum blockchain, powered by StarkWare. It aims to scale Ethereum network by using zk-STARK. Here's a quick way to run a full-node on StarkNet Alpha Mainnet with Docker.

## Requirements

If docker preinstalled in your system, just skip this phase.

```bash
sudo apt-get update
sudo apt-get install -y curl
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo usermod -aG docker $(whoami)
newgrp docker
sudo reboot
```

## Build Image

```bash
git clone https://github.com/feyzikesim/starknet-full-node/
cd starknet-full-node

VERSION=$(curl --silent "https://api.github.com/repos/eqlabs/pathfinder/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') docker build -t starknet-node:latest --build-arg VERSION .
```

## Run container

In this step, you gonna need an Ethereum mainnet url to run your own node. Check [Infura](https://www.infura.io/) or [Alchemy](https://www.alchemy.com/) to obtain one. Set *MAINNET_URL* env variable with yours. *--ethereum.password* flag is not necessary if you don't set a password at Infura/Alchemy.

```bash
export MAINNET_URL=https://mainnet.infura.io/v3/XXXXXXXXXX
export MAINNET_PASSWD=XXXXXXXXXX

docker run -d --restart on-failure --name starknet-node starknet-node:latest $MAINNET_URL --ethereum.password $MAINNET_PASSWD
```
## License

[MIT](https://choosealicense.com/licenses/mit/)
