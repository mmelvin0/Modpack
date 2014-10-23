#!/bin/sh
exec java -jar -XX:MaxPermSize=256M -Xincgc -jar forge-1.7.10-10.13.2.1232-universal.jar nogui
