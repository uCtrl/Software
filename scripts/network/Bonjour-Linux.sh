#!/bin/sh
## LINUX Version
## Bonjour test script. It will start 3 differients services with associated ports on the local domain.
## This script is for test/debug use only.

avahi-publish -s test1 _http._tcp 7081 &
avahi-publish -s test2 _http._tcp 7082 &
avahi-publish -s test3 _http._tcp 7083 &

sleep 3

echo Press any key to kill all the test services
read -r "" > /dev/null 2>&1

killall -9 avahi-publish