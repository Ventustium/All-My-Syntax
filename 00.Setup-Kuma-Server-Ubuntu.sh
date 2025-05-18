Update first
```bash
sudo apt update && sudo apt upgrade -y
```
Install Docker
```bash
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Install Apache & PHP & MariaDB & Redis
```bash
sudo apt install ca-certificates apt-transport-https software-properties-common -y
add-apt-repository ppa:ondrej/php
sudo apt install apache2 libapache2-mpm-itk mariadb-server \
                php8.4 php8.4-{fpm,cli,mysql,pgsql,zip,yaml,xml,gd,curl,mbstring,snmp,intl,soap} \ 
                composer redis -y
a2enconf php8.4-fpm
a2enmod rewrite mpm_itk \
                proxy proxy_fcgi proxy_wstunnel proxy_fcgi proxy_http proxy_balancer lbmethod_byrequests \
                headers userdir ssl dav dav_fs dav_lock auth_digest 
systemctl restart apache2
```

Install FreeRadius
```
sudo apt install freeradius -y
```

Install Cloudflare
```bash
# Add cloudflare gpg key\
sudo mkdir -p --mode=0755 /usr/share/keyrings\
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null\\
# Add this repo to your apt repositories\
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main' | sudo tee /etc/apt/sources.list.d/cloudflared.list\
# install cloudflared\
sudo apt-get update && sudo apt-get install cloudflared -y
```

Install Samba, NFS, CUPS
```bash
sudo apt install cups samba nfs-kernel-server -y
```

Install NodeJS & NPM
```bash
sudo apt install nodejs npm
npm install pm2 -g
```
