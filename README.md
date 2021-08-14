# SWARM

![GitHub release (latest by date)](https://img.shields.io/github/v/release/TangleBay/swarm?style=for-the-badge) [![Support Server](https://img.shields.io/discord/591914197219016707.svg?label=Discord&logo=Discord&colorB=7289da&style=for-the-badge)](https://discord.tanglebay.com)

**Please note that you use this script at your own risk and that I will not be liable for any damages that may occur**

## Requirements
- RPi 4 (min 4GB / 40GB SSD) or VPS (2Core/4GB/40GB)
- Ubuntu 20.04 LTS (64Bit)
- (Sub-) Domain

## Installation

**Download the latest release version of SWARM and run it. Do the following steps:**

1. Install SWARM with the Installer
```shell
curl -sL https://raw.githubusercontent.com/tanglebay/swarm/master/installer.sh | sudo bash -
```
2. After installting SWARM you can execute it with typing `swarm`

**Notice**: Please make sure that your node is properly secured (e.g. firewall, SSH KeyAuth, regular system updates).

## Ports
- Gossip: `15600/tcp`
- Autopeering: `14626/udp`
- API (HTTPS): `443/tcp`
- HTTP (letsencrypt): `80/tcp`


## Backup SWARM
If you ever want to reinstall your server or SWARM, you can backup your SWARM configuration first.

You can find the configuration files under the following path:
```shell
cd /var/lib/swarm/configs
```

After the reinstallation, simply replace the configurations with your backup, run a SWARM update to update the configuration files (if necessary) and then you can reinstall Hornet and the proxy and have all settings imported directly.


# Tips

**IOTA Address:**
```
iota1qq2zpclw655gaxun5ruzlnpmpqccem5v47xvc8ptkms260csz2m5ymuesea
```

