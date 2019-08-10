#!/bin/sh

vncserver -kill :1
sleep 1

vncserver :1
sleep 1

export DISPLAY=:1

wget --spider --quiet http://google.com
if [ "$?" -eq 0 ]; then
  echo "Internet found: updating" >> ~/pyramid.log
  cd ~/pyramid
  git pull >> ~/pyramid.log 2>&1
else
  echo "No internet: not updating" >> ~/pyramid.log
fi

qjoypad &

# Make sure fcserver is running
sudo ~/fadecandy/bin/fcserver-rpi ~/pyramid/fcserver-config.json >> ~/fcserver.log 2>&1 &

echo "Starting Pyramid" >> ~/pyramid.log
processing-java --sketch=/home/pi/pyramid --output=/home/pi/pyramid/out --force --run >> ~/pyramid.log 2>&1
