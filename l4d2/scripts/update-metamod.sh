#!/bin/sh

LATEST_METAMOD=$(curl https://mms.alliedmods.net/mmsdrop/1.11/mmsource-latest-linux)

mkdir tmp

cd tmp
wget https://mms.alliedmods.net/mmsdrop/1.11/$LATEST_METAMOD
mkdir mm
cd mm
tar xvf ../$LATEST_METAMOD
rm -rf addons/metamod/bin/linux64/
rsync -va * /home/l4d2/l4d2/left4dead2/
cd ..
cd ..

rm -rf tmp
