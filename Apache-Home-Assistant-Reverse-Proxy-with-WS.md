<VirtualHost *:80>
        ServerName ventustium.com
        ServerAdmin kevin@ventustium.com

        ErrorLog ${APACHE_LOG_DIR}/ventustium.com.error.log
        CustomLog ${APACHE_LOG_DIR}/ventustium.com.access.log combined
</VirtualHost>

<VirtualHost *:443>
        ServerName ventustium.com
        ServerAdmin kevin@ventustium.com

        ErrorLog ${APACHE_LOG_DIR}/ventustium.com.error.log
        CustomLog ${APACHE_LOG_DIR}/ventustium.com.access.log combined

        ProxyPreserveHost On
        ProxyPass /api/websocket ws://localhost:8123/api/websocket
        ProxyPassReverse /api/websocket ws://localhost:8123/api/websocket
        ProxyPass / http://localhost:8123/
        ProxyPassReverse / http://localhost:8123/
        <IfModule mod_rewrite.c>
                RewriteEngine on
                RewriteCond %{HTTP:Upgrade} =websocket [NC]
                RewriteRule /(.*)  ws://localhost:8123/$1 [P,L]
                RewriteCond %{HTTP:Upgrade} !=websocket [NC]
                RewriteRule /(.*)  http://localhost:8123/$1 [P,L]
        </IfModule>
        SSLCertificateFile /etc/letsencrypt/live/ventustium.com-0001/fullchain.pem
        SSLCertificateKeyFile /etc/letsencrypt/live/ventustium.com-0001/privkey.pem
</VirtualHost>
