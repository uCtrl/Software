#!/bin/sh
# You need to be at the root of this repo (Software)
rm -rf build/
scripts/build.sh
# -dmg is commented for now. We will have to learn how to make a fancy DMG before it is any useful. macdeployQT is not specialized in dmg creation...
macdeployqt build/release/uCtrlDesktop/uCtrlDesktop.app -qmldir=src/uCtrlDesktop/qml #-dmg 

