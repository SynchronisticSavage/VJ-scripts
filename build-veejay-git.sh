#!/bin/bash
#simple script to build and install the latest version of veejay from git
#libmjpegtools-dev libsdl2-ttf-dev required
#set pkg config path
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/local/lib/pkgconfig
export SDL_TTF_LIBS=-lSDL_ttf
#set output Dir and make if it does not exsist
VPATH=~/src/git/vj
mkdir -p $VPATH
#change to vpath and clone vj from git
cd $VPATH
git clone http://code.dyne.org/veejay
#change to server source
cd veejay/veejay-current/veejay-server
#configure build and install veejay
#you may need to disable sdl to get recent version to compile
#./autogen.sh && ./configure --without-sdl && make && sudo make install
./autogen.sh && ./configure --prefix=/usr && make && sudo make install
cd ../veejay-client
./autogen.sh && ./configure --prefix=/usr && make && sudo make install
cd ../veejay-utils
./autogen.sh && ./configure --prefix=/usr && make && sudo make install
cd ../veejay-themes
sudo ./INSTALL.sh
#install sendVIMS
#cd ..
#./configure && make && sudo make install

