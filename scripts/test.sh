#!/bin/sh
# You need to be at the root of this repo (Software)
mkdir -p build/tests/
cd build/tests
mkdir results
qmake ../../src/uCtrlTest/uCtrlTest.pro -r CONFIG+=x86_64
cd ./testController && make && ./tst_testcontroller -xml > ../results/controller.xml
cd ../testModel && make && ./tst_testmodel -xml > ../results/model.xml
cd ../testView && make && ./tst_testview -xml > ../results/view.xml