Ubuntu :
```bash
$ sudo apt-get update
$ sudo apt-get upgrade
```

Apache 2: 
```bash
$ sudo apt install apache2
$ cd /etc/apache2/sites-available/
$ sudo nano /etc/apache2/sites-available/000-default.conf
$ sudo nano /etc/apache2/sites-available/default-ssl.conf
$ sudo nano /etc/apache2/apache2.conf
$ sudo apt install libapache2-mod-php
$ sudo ln -s ../sites-available/ven.conf <-- file tambahan virtual host
```

Install PHP :
```bash
$ sudo apt install php
```

Mysql :
```bash
$ sudo apt install mariaDB-server atau sudo apt install mysql-server
$ sudo apt install php-mysql
$ sudo mysql_secure_installation
$ mysql -u kevin -p
$ sudo mysql -u root
$ sudo mysqldump --databases db_form_kepuasan > /home/pi/Documents/db_form_kepuasan.sql
```

Check Service:
```bash
$ sudo service apache2 start
$ sudo service apache2 stop
$ sudo service apache2 status
$ sudo service mysql start
$ sudo service mysql status
$ sudo service mysql stop
```




