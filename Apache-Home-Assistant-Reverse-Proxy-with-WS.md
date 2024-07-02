```
<VirtualHost *:80>
        ServerName <domain>
        ServerAdmin kevin@ventustium.com

        ErrorLog ${APACHE_LOG_DIR}/<domain>.error.log
        CustomLog ${APACHE_LOG_DIR}/<domain>.access.log combined
</VirtualHost>

<VirtualHost *:443>
        ServerName <domain>
        ServerAdmin kevin@ventustium.com

        ErrorLog ${APACHE_LOG_DIR}/<domain>.error.log
        CustomLog ${APACHE_LOG_DIR}/<domain>.access.log combined

        ProxyPreserveHost On
        ProxyPass /api/websocket ws://localhost:<port>/api/websocket
        ProxyPassReverse /api/websocket ws://localhost:<port>/api/websocket
        ProxyPass / http://localhost:<port>/
        ProxyPassReverse / http://localhost:<port>/
        <IfModule mod_rewrite.c>
                RewriteEngine on
                RewriteCond %{HTTP:Upgrade} =websocket [NC]
                RewriteRule /(.*)  ws://localhost:<port>/$1 [P,L]
                RewriteCond %{HTTP:Upgrade} !=websocket [NC]
                RewriteRule /(.*)  http://localhost:<port>/$1 [P,L]
        </IfModule>
        SSLCertificateFile /etc/letsencrypt/live/<domain>-0001/fullchain.pem
        SSLCertificateKeyFile /etc/letsencrypt/live/<domain>-0001/privkey.pem
</VirtualHost>
```
