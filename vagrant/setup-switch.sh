#!/usr/bin/env bash

# installing thrift
curl http://archive.apache.org/dist/thrift/0.9.3/thrift-0.9.3.tar.gz | tar zx
pushd thrift-0.9.3 > /dev/null
./bootstrap.sh
./configure
make
sudo make install
cd lib/py/
sudo python setup.py install
popd > /dev/null

## Installing nanomsg
#curl http://download.nanomsg.org/nanomsg-0.5-beta.tar.gz | tar zx
curl -L https://github.com/nanomsg/nanomsg/archive/1.0.0.tar.gz -O
tar xvzf 1.0.0.tar.gz
rm -fr 1.0.0.tar.gz
pushd nanomsg-1.0.0 > /dev/null
./configure
make
sudo make install
popd

# cannot use sudo to redirect output
#sudo echo "/usr/local/lib/x86_64-linux-gnu" >> /etc/ld.so.conf.d/x86_64-linux-gnu.conf
cp /etc/ld.so.conf.d/x86_64-linux-gnu.conf /tmp/x86_64-linux-gnu.conf
echo "/usr/local/lib/x86_64-linux-gnu" >> /tmp/x86_64-linux-gnu.conf
sudo cp /tmp/x86_64-linux-gnu.conf /etc/ld.so.conf.d/x86_64-linux-gnu.conf
sudo ldconfig

# install p4c-bm, Generates the JSON configuration for the behavioral-model (bmv2).

# it seems that the tutorial uses p4c-bmv2
#git clone https://github.com/p4lang/p4c-bm.git
git clone https://github.com/chengyu/p4c-bm.git
pushd p4c-bm > /dev/null
#git checkout -b 1.5.0
sudo pip install -r requirements.txt
sudo python setup.py install
popd > /dev/null

# installing behavioral-model (second version of the P4 software switch)
#git clone https://github.com/p4lang/behavioral-model.git
git clone https://github.com/chengyu/behavioral-model.git
pushd behavioral-model > /dev/null
#git checkout -b 1.5.0
./autogen.sh
./configure
make
sudo make install
sudo ldconfig
make check
popd > /dev/null

git clone https://github.com/chengyu/tutorials.git
