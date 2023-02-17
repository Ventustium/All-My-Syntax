```
certbot certonly --agree-tos \
--manual \
--preferred-challenges dns \
--email kevinlinuhung@gmail.com \
--server https://acme-v02.api.letsencrypt.org/directory \
-d "ventustium.com" -d "*.ventustium.com"
```
