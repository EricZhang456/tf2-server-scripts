#!/bin/sh

curl https://raw.githubusercontent.com/EricZhang456/tf2-server-scripts/refs/heads/master/tf2/cfg/replay.cfg > /home/tf2/tf2/tf/cfg/replay.cfg
curl https://raw.githubusercontent.com/EricZhang456/tf2-server-scripts/refs/heads/master/tf2/cfg/server.cfg > /home/tf2/tf2/tf/cfg/server.cfg
curl https://raw.githubusercontent.com/EricZhang456/tf2-server-scripts/refs/heads/master/tf2/cfg/motd.txt > /home/tf2/tf2/tf/cfg/motd.txt
curl https://raw.githubusercontent.com/EricZhang456/tf2-server-scripts/refs/heads/master/tf2/cfg/mapcycle.txt > /home/tf2/tf2/tf/cfg/mapcycle.txt
curl https://raw.githubusercontent.com/EricZhang456/tf2-server-scripts/refs/heads/master/tf2/cfg/motd.txt > /home/tf2/tf2/tf/cfg/motd_text.txt
dos2unix /home/tf2/tf2/tf/cfg/mapcycle.txt
sed -i -e '$a\' /home/tf2/tf2/tf/cfg/mapcycle.txt
#/home/tf2/scripts/make-workshop-cfg-map-motd.py /home/tf2/tf2/tf/cfg/mapcycle.txt 2 > /home/tf2/tf2/tf/cfg/workshop_update.cfg
#/home/tf2/scripts/make-workshop-cfg-map-motd.py /home/tf2/tf2/tf/cfg/mapcycle.txt 1 >> /home/tf2/tf2/tf/cfg/motd.txt
#/home/tf2/scripts/make-workshop-cfg-map-motd.py /home/tf2/tf2/tf/cfg/mapcycle.txt 1 >> /home/tf2/tf2/tf/cfg/motd_text.txt
#/home/tf2/scripts/make-motd.sh /home/tf2/tf2/tf/cfg/mapcycle.txt >> /home/tf2/tf2/tf/cfg/motd.txt
#/home/tf2/scripts/make-motd.sh /home/tf2/tf2/tf/cfg/mapcycle.txt >> /home/tf2/tf2/tf/cfg/motd_text.txt
