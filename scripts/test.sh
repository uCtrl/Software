#!/bin/sh
# You need to be at the root of this repo (Software)
mkdir -p tests/
cd tests
qmake ../src/uCtrlTest.pro -r CONFIG+=x86_64
make
./uCtrlTest/testController/testcontroller -xml > controller.xml
./uCtrlTest/testModel/testmodel -xml > model.xml
./uCtrlTest/testView/testview -xml > view.xml
