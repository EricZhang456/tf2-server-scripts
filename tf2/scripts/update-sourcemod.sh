#!/bin/sh

mkdir tmp

cd tmp
wget -O sourcemod.tar.gz "https://www.sourcemod.net/latest.php?os=linux&version=1.12"
mkdir mm
cd mm
tar xvf ../sourcemod.tar.gz
rsync -va * /home/tf2/tf2/tf/
cd ..
cd ..

rm -rf tmp

cp ~tf2/tf2/tf/addons/sourcemod/configs/admins_simple.ini.bak ~tf2/tf2/tf/addons/sourcemod/configs/admins_simple.ini
