REM WINDOWS Version
REM Bonjour test script. It will start 3 differients services with associated ports on the local domain.
REM This script is for test/debug use only.

START /B dns-sd -R test1 _http._tcp local 7081
START /B dns-sd -R test2 _http._tcp local 7082
START /B dns-sd -R test3 _http._tcp local 7083

timeout /T 3 /NOBREAK > NUL
echo "Press any key to kill all the test services"
pause

Taskkill /IM dns-sd.exe /F
