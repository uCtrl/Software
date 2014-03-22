#!/bin/sh
# You need to be at the root of this repo (Software)
mkdir -p tests/
cd tests
qmake ../src/uCtrlTest/uCtrlTest.pro -r CONFIG+=x86_64
cd ./testController && make && ./testcontroller -xml > ../controller.xml
cd ../testModel && make && ./testmodel -xml > ../model.xml
cd ../testView && make && ./testview -xml > ../view.xml