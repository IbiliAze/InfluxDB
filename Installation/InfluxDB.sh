#!/bin/bash

echo Docker
echo step 1
#docker run -d -e INFLUXDB_ADMIN_USER:admin -e INFLUXDB_ADMIN_PASSWORD:admin --name influxdb influxdb

echo step 2
#docker exec -it influxdb bash

echo step 3
#influx -host localhost -port 8086 -username admin -password admin

echo Ubuntu
echo step 1
wget https://dl.influxdata.com/influxdb/releases/influxdb2-2.0.7-amd64.deb
sudo dpkg -i influxdb2-2.0.7-amd64.deb
sudo apt install -y influxdb influxdb-client
rm influxdb2-2.0.7-amd64.deb

echo step 2
sudo systemctl start influxdb
sudo systemctl enable influxdb

echo step 3
cp influxdb.conf  /etc/influxdb/influxdb.conf

echo step 4
echo Adding Admin user and Database
influx
 > CREATE USER "admin" WITH PASSWORD 'admin' WITH ALL PRIVILEGES
 > exit

systemctl restart influxdb

influx
 > show users
 > create database mydb

echo step 5
echo Measurements
 > use mydb
 > show measurements
 > insert cpu,host=node1 value=10
 > insert cpu,host=node2 value=40
 > show series
 > show measurements
 > select * from cpu
 > select * from cpu where host='node2'
 > select * from cpu time >= now() - 5m
 > drop measurement cpu
