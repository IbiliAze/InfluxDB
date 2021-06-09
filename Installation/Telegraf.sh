#!/bin/bash

echo step 1
wget https://dl.influxdata.com/telegraf/releases/telegraf_1.19.0~rc0-1_amd64.deb
sudo dpkg -i telegraf_1.19.0~rc0-1_amd64.deb
rm telegraf_1.19.0~rc0-1_amd64.deb
sudo apt install -y telegraf

echo step 2
sudo systemctl start telegraf
sudo systemctl enable telegraf
sudo systemctl status telegraf

