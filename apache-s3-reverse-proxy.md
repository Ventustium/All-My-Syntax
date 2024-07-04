```
<VirtualHost *:80>
        ServerName <domain>
        ServerAdmin kevin@ventustium.com

        ErrorLog ${APACHE_LOG_DIR}/<domain>.error.log
        CustomLog ${APACHE_LOG_DIR}/<domain>.access.log combined

        <IfModule mod_security2.c>
                SecRuleEngine On
                SecAuditEngine On
                SecAuditLog ${APACHE_LOG_DIR}/<domain>.modsec_audit.log
                # Add any additional logging settings or customization here
        </IfModule>

</VirtualHost>

<VirtualHost *:443>
        ServerName <domain>
        ServerAdmin kevin@ventustium.com

        ErrorLog ${APACHE_LOG_DIR}/<domain>.error.log
        CustomLog ${APACHE_LOG_DIR}/<domain>.access.log combined

        ProxyPreserveHost On
        ProxyPass / http://localhost:<port>/
        ProxyPassReverse / http://localhost:<port>/
        RequestHeader set X-Forwarded-Proto "https"
        RequestHeader set X-Forwarded-SSL "on"

        <IfModule mod_rewrite.c>
                RewriteEngine on
                RewriteCond %{HTTP:UPGRADE} WebSocket [NC]
                RewriteCond %{HTTP:CONNECTION} Upgrade [NC]
                RewriteRule .* ws://localhost:<port>%{REQUEST_URI} [P,L]
        </IfModule>

        SSLCertificateFile /etc/letsencrypt/live/ventustium.com-0001/fullchain.pem
        SSLCertificateKeyFile /etc/letsencrypt/live/ventustium.com-0001/privkey.pem
        Include /etc/letsencrypt/options-ssl-apache.conf
</VirtualHost>
```
