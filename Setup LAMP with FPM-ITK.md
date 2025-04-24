```bash
apt install ca-certificates apt-transport-https software-properties-common
add-apt-repository ppa:ondrej/php
apt update
apt install apache2 libapache2-mpm-itk
apt install mariadb-server
mysql_secure_installation
sudo apt install php8.1 php8.1-{fpm,cli,mysql,pgsql,zip,yaml,xml,gd,curl,json,snmp}
a2enconf php8.1-fpm
a2enmod rewrite
a2enmod mpm_itk
a2enmod proxy_wstunnel
a2enmod proxy_fcgi
```

Apache2 Sites Configuration
```ini
<VirtualHost *:80>
    ServerName ventustium.com
    ServerAdmin support@ventustium.com

    ErrorLog ${APACHE_LOG_DIR}/ventustium.com.error.log
    CustomLog ${APACHE_LOG_DIR}/ventustium.com.access.log combined

    DocumentRoot /home/kevin/public_html/Ventustium/public
    <IfModule mpm_itk_module>
        AssignUserId kevin kevin
    </IfModule>
    <FilesMatch \.php$>
    SetHandler "proxy:unix:/run/php/php8.1-kevin-fpm.sock|fcgi://localhost"
    </FilesMatch>
    #RewriteEngine on
    #RewriteCond %{SERVER_NAME} =ventustium.com
    #RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
</VirtualHost>

<VirtualHost *:443>
    ServerName ventustium.com
    ServerAdmin support@ventustium.com

    ErrorLog ${APACHE_LOG_DIR}/ventustium.com.error.log
    CustomLog ${APACHE_LOG_DIR}/ventustium.com.access.log combined

    DocumentRoot /home/kevin/public_html/Ventustium/public
    <IfModule mpm_itk_module>
        AssignUserId kevin kevin
    </IfModule>
    <FilesMatch \.php$>
        SetHandler "proxy:unix:/run/php/php8.1-kevin-fpm.sock|fcgi://localhost"
    </FilesMatch>

    #Include /etc/letsencrypt/options-ssl-apache.conf
    SSLCertificateFile /etc/letsencrypt/live/ventustium.com-0001/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/ventustium.com-0001/privkey.pem
    #Include /etc/letsencrypt/options-ssl-apache.conf
</VirtualHost>
```

Pool location
```bash
cd /etc/php/8.1/fpm/pool.d
vim kevin.conf
```

Pool Example configuration
```ini
[kevin]

user = kevin
group = kevin

listen = /run/php/php8.1-kevin-fpm.sock

listen.owner = kevin
listen.group = kevin

pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
```
