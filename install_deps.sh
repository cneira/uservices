#!/bin/sh
set -ex
git clone https://github.com/oktal/pistache.git
cd pistache
git submodule update --init
mkdir build
cd build
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ..
make
sudo make install