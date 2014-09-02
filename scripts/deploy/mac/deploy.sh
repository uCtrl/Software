#!/bin/sh
# You need to be at the root of this repo (Software)
rm -rf build/
scripts/build.sh

QTPATH=$(otool -L build/release/uCtrlDesktop/uCtrlDesktop.app/Contents/MacOS/uCtrlDesktop | grep qt5 | head -n 1 | grep -o '\S*/qt5')

macdeployqt build/release/uCtrlDesktop/uCtrlDesktop.app

# Copy QML libs
cp -r $QTPATH/qml/QtQuick build/release/uCtrlDesktop/uCtrlDesktop.app/Contents/Resources/qml
cp -r $QTPATH/qml/QtQuick.2 build/release/uCtrlDesktop/uCtrlDesktop.app/Contents/Resources/qml

# Change paths of every .dylib
find build/release/uCtrlDesktop/uCtrlDesktop.app/Contents/Resources/qml -name "*.dylib" | while read LIB; do \
	otool -L $LIB | grep qt5 | grep -o '\S*/\S*' | while read LN; do \
		NEWQTPATH=$(echo $LN | sed 's/^\(.*\)lib/@executable_path\/..\/Frameworks/'); \
		echo "Changing $LIB \n Reference: $LN\n To: $NEWQTPATH \n"; \
		install_name_tool -change $LN $NEWQTPATH $LIB; \
	done
done

# Create .dmg
cd build/release
mkdir dmg
cp -r uCtrlDesktop/uCtrlDesktop.app dmg/uCtrl.app
cd dmg

../../../scripts/deploy/mac/create-dmg \
--volname "µCtrl Installer" \
--volicon "uCtrl.app/Contents/Resources/uctrl.icns" \
--window-size 500 300 \
--icon-size 96 \
--icon "uCtrl.app" 98 162 \
--hide-extension "uCtrl.app" \
--app-drop-link 402 162 \
--background ../../../scripts/deploy/mac/background.png \
µCtrl-Installer.dmg .