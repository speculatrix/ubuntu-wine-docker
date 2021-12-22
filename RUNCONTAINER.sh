#!/bin/bash

# switch to the directory the script is being run from so it can find the files
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

cd $DIR


if [ ! -f Dockerfile ] ; then
	echo "Error, please run BUILDME.sh first"
	exit 1
fi

# detect the user chosen
MYUSERNAME=$( awk '/RUN useradd/ {print $7}' < Dockerfile )


echo "=== Please browse to http://127.0.0.1:6080/ to see the desktop ==="

docker run -p 6080:80 -v /dev/shm:/dev/shm dorowu/ubuntu-desktop-lxde-vnc
