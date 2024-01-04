mkdir prometheus
cd prometheus/
git clone https://github.com/gmm42/tinyproxy_exporter.git
cd tinyproxy_exporter/
apt install python3-pip -y
pip install -r requirements.txt




sudo nano /etc/systemd/system/tiny-exporter.service

[Unit]
Description=tiny-exporter daemon
[Service]
User=ubuntu
#Code to execute
#Can be the path to an executable or code itself
WorkingDirectory=/home/ubuntu/prometheus/tinyproxy_exporter/
ExecStart=/home/ubuntu/prometheus/tinyproxy_exporter/tiny-exporter
Type=simple
TimeoutStopSec=10
Restart=on-failure
RestartSec=5
[Install]
WantedBy=multi-user.target

nano /home/ubuntu/prometheus/tinyproxy_exporter/tiny-exporter

#!/bin/sh
python3 tinyproxy_exporter -l 0.0.0.0:9240 -t ibc:123445@127.0.0.1:8888


chmod 005 /home/ubuntu/prometheus/tinyproxy_exporter/tiny-exporter

systemctl daemon-reload
systemctl start tiny-exporter
systemctl enable tiny-exporter
