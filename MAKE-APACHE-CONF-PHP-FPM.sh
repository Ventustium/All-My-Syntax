#!/bin/bash

# Check if name and domain are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <name> <domain>"
    exit 1
fi

name="$1"
domain="$2"

# Create PHP-FPM configuration file
config_file="/etc/php/8.2/fpm/pool.d/$name.conf"  # Update the path as needed
echo "[$name]" > "$config_file"
echo "user = $name" >> "$config_file"
echo "group = $name" >> "$config_file"
echo "listen = /run/php/php8.2-$name-fpm.sock" >> "$config_file"
echo "listen.owner = $name" >> "$config_file"
echo "listen.group = $name" >> "$config_file"
echo "pm = dynamic" >> "$config_file"
echo "pm.max_children = 5" >> "$config_file"
echo "pm.start_servers = 2" >> "$config_file"
echo "pm.min_spare_servers = 1" >> "$config_file"
echo "pm.max_spare_servers = 3" >> "$config_file"

echo "Configuration file $name.conf has been created."

service php8.2-fpm restart

# Apache configuration directory
config_dir="/etc/apache2/sites-available"  # Update the directory as needed

# Create Apache configuration file
config_file="$config_dir/$name.$domain.conf"
echo "<VirtualHost *:80>" >> "$config_file"
echo "    ServerName $name.$domain" >> "$config_file"
echo "    ServerAdmin kevin@ventustium.com" >> "$config_file"
echo "" >> "$config_file"
echo "    ErrorLog \${APACHE_LOG_DIR}/$name.$domain.error.log" >> "$config_file"
echo "    CustomLog \${APACHE_LOG_DIR}/$name.$domain.access.log combined" >> "$config_file"
echo "" >> "$config_file"
echo "    DocumentRoot /home/$name/public_html/public" >> "$config_file"
echo "    <IfModule mpm_itk_module>" >> "$config_file"
echo "        AssignUserId $name $name" >> "$config_file"
echo "    </IfModule>" >> "$config_file"
echo "    <FilesMatch \.php$>" >> "$config_file"
echo "        SetHandler \"proxy:unix:/run/php/php8.2-$name-fpm.sock|fcgi://localhost\"" >> "$config_file"
echo "    </FilesMatch>" >> "$config_file"
echo "</VirtualHost>" >> "$config_file"

echo "Apache configuration file $name.$domain.conf has been created in $config_dir."

# Enable the site
a2ensite "$name.$domain.conf"
echo "Enabled site $name.$domain"

# Reload Apache
systemctl reload apache2
echo "Apache reloaded."
