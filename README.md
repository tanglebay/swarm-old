### Please note that you use this script at your own risk and that I will not be liable for any damages that may occur ###


# SWARM #

**Download the latest release version of SWARM and run it. Do the following steps:**

1. First you should clone the repo
```shell
sudo git clone https://github.com/TangleBay/swarm.git /var/lib/swarm && sudo chmod +x /var/lib/swarm/swarm
```
2. Add an alias for the current user
```shell
echo "alias swarm='sudo /var/lib/swarm/swarm'" >> ~/.bashrc && . ~/.bashrc
```
3. Run one time SWARM this command and after first start/reboot you can use just `swarm`



# Install reverse proxy #

**Before you can run the installation of the reverse proxy it is necessary that you have defined your domain in the nginx.cfg before.**
**Also you need to open following ports in your router configuration: `80/TCP` (Letsencrypt-Auth)**

1. Set your domain over SWARM in the nginx.cfg (Edit proxy menu -> nginx.cfg)
2. Choose the option "Deploy reverse proxy"

**Your Dashboard address will be `https://yourdomain.com` and your API (Trinity) will be `https://yourdomain.com/access` (without API protection) or `https://yourdomain.com/auth`**


# Support

IOTA Address: `PBOHQZ9SZ9AZD9LDM9EHOSAENTEVIBAOUEYEYRZHIDXJVWLTKLSQJZZXFBKGXYTHFVGV9WSBPDGRILOX9SLKPOXRAA`
