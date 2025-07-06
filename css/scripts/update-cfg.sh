#!/bin/sh

curl https://raw.githubusercontent.com/EricZhang456/tf2-server-scripts/refs/heads/master/css/cfg/server.cfg > /home/css/css/cstrike/cfg/server.cfg
curl https://raw.githubusercontent.com/EricZhang456/tf2-server-scripts/refs/heads/master/css/cfg/motd.txt > /home/css/css/cstrike/cfg/motd.txt
curl https://raw.githubusercontent.com/EricZhang456/tf2-server-scripts/refs/heads/master/css/cfg/mapcycle.txt > /home/css/css/cstrike/cfg/mapcycle.txt
curl https://raw.githubusercontent.com/EricZhang456/tf2-server-scripts/refs/heads/master/css/cfg/motd.txt > /home/css/css/cstrike/cfg/motd_text.txt
dos2unix /home/css/css/cstrike/cfg/mapcycle.txt
sed -i -e '$a\' /home/css/css/cstrike/cfg/mapcycle.txt
