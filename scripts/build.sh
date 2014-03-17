#!/bin/sh
# You need to be at the root of this repo (Software)
mkdir -p build/release/
cd build/release 
qmake ../../src/uCtrl.pro -r CONFIG+=x86_64
make