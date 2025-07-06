#!/bin/sh

LATEST_SOURCEMOD=$(curl https://sm.alliedmods.net/smdrop/1.12/sourcemod-latest-linux)

mkdir tmp

cd tmp
wget https://sm.alliedmods.net/smdrop/1.12/$LATEST_SOURCEMOD
mkdir mm
cd mm
tar xvf ../$LATEST_SOURCEMOD
rsync -va * /home/l4d2/l4d2/left4dead2/
cd ..
cd ..

rm -rf tmp

cp ~l4d2/l4d2/left4dead2/addons/sourcemod/configs/admins_simple.ini.bak ~l4d2/l4d2/left4dead2/addons/sourcemod/configs/admins_simple.ini
