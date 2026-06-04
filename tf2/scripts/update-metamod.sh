#!/bin/sh

mkdir tmp

cd tmp
wget -O mms.tar.gz "https://www.metamodsource.net/latest.php?os=linux&version=1.12"
mkdir mm
cd mm
tar xvf ../mms.tar.gz
rsync -va * /home/tf2/tf2/tf/
cd ..
cd ..

rm -rf tmp
