### Please note that you use this script at your own risk and that I will not be liable for any damages that may occur ###


# SWARM #

**Download the latest release version of SWARM and run it. Do the following steps:**

1. First you should clone the repo
```shell
cd /var/lib && sudo git clone https://github.com/TangleBay/swarm.git && sudo chmod +x /var/lib/swarm/swarm
```
2. Set aliases for run SWARM from every source
```shell
echo "alias swarm='sudo /var/lib/swarm/swarm'" >> ~/.bashrc && . ~/.bashrc
```
3. Run the Manager (HLM): `swarm`
4. With the first start it is necessary to edit the hornet config (will opened automatically) !!!


# Install reverse proxy #

**Before you can run the installation of the reverse proxy it is necessary that you have defined your domain in script before.**
**Also you need to open following ports in your router configuration: `80/TCP` (Letsencrypt-Auth)**

1. Set your domain over SWARM in the nginx.cfg (Edit proxy menu -> nginx.cfg)
2. Choose the option "Deploy reverse proxy"

**Your Dashboard address will be `https://yourdomain.com` and your API (Trinity) will be `https://yourdomain.com/napi` (without API protection) or `https://yourdomain.com/auth`**


# Support TANGLE BAY#

IOTA Address: `KKEMSVOKRVEOARTKSYFM9ZNFEDDQUFGTFATYGRF9RXKBJGTUMGMDVPSLSZF9TRQXSASYAFTFEUNCQCHZYTDOQAUGDW`
