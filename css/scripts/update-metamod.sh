#!/bin/sh

LATEST_METAMOD=$(curl https://mms.alliedmods.net/mmsdrop/1.11/mmsource-latest-linux)

mkdir tmp

cd tmp
wget https://mms.alliedmods.net/mmsdrop/1.11/$LATEST_METAMOD
mkdir mm
cd mm
tar xvf ../$LATEST_METAMOD
rsync -va * /home/css/css/cstrike/
cd ..
cd ..

rm -rf tmp
