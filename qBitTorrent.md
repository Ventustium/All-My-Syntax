# Install qBitTorrent
```BASH
apt install qbittorrent
apt install qbittorrent-nox
sudo nano /etc/systemd/system/qbittorrent.service
```
qbittorrent.service (service running on port 9000)
```
[Unit]
Description=qBittorrent
After=network.target

[Service]
Type=forking
#User=qbittorrent
#Group=qbittorrent
UMask=002
ExecStart=/usr/bin/qbittorrent-nox -d --webui-port=9000
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

Run & Check qBitTorrent Status
```BASH
systemctl daemon-reload
systemctl start qbittorrent
systemctl status qbittorrent
```

Copy Webui
```
git clone https://github.com/qbittorrent/qBittorrent.git
cd qBittorrent/src/webui
```

Set Custom WebUI on qBitTorrent
