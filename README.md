<h1 align="center">
  <br>
  <a href=""><img src="images/swarm_banner.png"></a>
</h1>

<h2 align="center">SWARM</h2>

<p align="center">
  <a href="https://discord.tanglebay.com" style="text-decoration:none;"><img src="https://img.shields.io/badge/Discord-9cf.svg?logo=discord" alt="Discord"></a>
  <a href="https://telegram.tanglebay.com" style="text-decoration:none;"><img src="https://img.shields.io/badge/Telegram-9cf.svg?logo=Telegram" alt="Telegram"></a>
  <a href="https://github.com/tanglebay/swarm/blob/main/LICENSE" style="text-decoration:none;"><img src="https://img.shields.io/badge/License-MIT-green.svg" alt="MIT license"></a>
</p>

<p align="center">
  <a href="#about">About</a> ◈
  <a href="#requirements">Requirements</a> ◈
  <a href="#installation">Installation</a> ◈
  <a href="#contributing">Contributing</a> ◈
  <a href="#disclaimer">Disclaimer</a>
</p>

---

## About

SWARM is a script that allows you to easily install and manage an IOTA node. The most important configuration options are given via simple and selectable menu items. About the additional feature "Watchdog", the status of the nodes can be monitored, as well as automatically install updates. A reverse proxy installation is also offered for secure access via HTTPS.

## Requirements

### VPS (Virtual Private Server)
-   2Core/4GB Memory/60GB disk space)
-   (Sub-) domain
-   Ubuntu 22.04 LTS (64Bit)

### Raspberry Pi
-   Version 4 B 8GB
-   SSD (min. 60GB)
-   DDNS or (Sub-) Domain
-   Ubuntu 22.04 LTS (64Bit)

## Installation

There are a few options to install SWAM:

-   Clone from source code (not recommended)
-   Download latest SWARM release via command

```bash
sudo ${SHELL:-sh} -c "$(curl -Ls https://cdn.tanglebay.com/swarm/installer/installer.sh)"
```

### Ports
-   (IOTA) Hornet
    -   Gossip: `15600/tcp`
    -   Autopeering (optional): `14626/udp`
-   (Shimmer) Hornet
    -   Gossip: `15601/tcp`
    -   Autopeering (optional): `14636/udp`
-   Proxy
    -   HTTP (LetsEncrypt): `80/tcp`
    -   HTTPS: `Your defined ports`

## Contributing

Help out the SWARM project by filing a [bug report](https://github.com/tanglebay/swarm/issues/new?assignees=&labels=bug), making a [feature request](https://github.com/tanglebay/swarm/issues/new?assignees=&labels=feat) or opening a [pull request](https://github.com/tanglebay/swarm/pulls/).

## Disclaimer

Use of the script is at your own risk. No warranty is given for the proper use of the script. The legal process is excluded.