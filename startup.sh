vncserver :1
export DISPLAY=:1

wget --spider --quiet http://google.com
if [ "$?" -eq 0 ]; then
  cd ~/pyramid
  git pull
fi

processing-java --sketch=/home/pi/pyramid --output=/home/pi/pyramid/out --force --run &
