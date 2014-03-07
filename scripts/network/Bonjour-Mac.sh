#!/bin/sh
## MAC Version
## Bonjour test script. It will start 3 differients services with associated ports on the local domain.
## This script is for test/debug use only.

dns-sd -R test1 _http._tcp local 7081 &
dns-sd -R test2 _http._tcp local 7082 &
dns-sd -R test3 _http._tcp local 7083 &

sleep 3

read -p "Press any key to kill all the test services"

pkill -f dns-sd