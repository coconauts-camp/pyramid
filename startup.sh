
vncserver -kill :1
vncserver :1
export DISPLAY=:1

wget --spider --quiet http://google.com
if [ "$?" -eq 0 ]; then
  echo "Internet: updating" >> ~/pyramid.log
  cd ~/pyramid
  git pull >> ~/pyramid.log 2>&1
else
  echo "No internet: not updating" >> ~/pyramid.log
fi

~/fadecandy/bin/fcserver-rpi ~/pyramid/fcserver-config.json >> ~/fcserver.log 2>&1 &

processing-java --sketch=/home/pi/pyramid --output=/home/pi/pyramid/out --force --run >> ~/pyramid.log 2>&1 &
