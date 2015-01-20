#!/bin/bash
#simple script to build and install the latest version of veejay from git

#set pkg config path
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig

#set output Dir and make if it does not exsist
VPATH=~/src/git/vj
mkdir -p $VPATH
#change to vpath and clone vj from git
cd $VPATH
git clone http://code.dyne.org/veejay
#change to server source
cd veejay/veejay-current/veejay-server
#configure build and install veejay
./autogen.sh && ./configure && make && sudo make install


