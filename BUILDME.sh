#!/bin/bash

TAG="ubuntu-wine"


ARG1="$1"


# switch to the directory the script is being run from so it can find the files
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

cd $DIR


# http_proxy comes from the environment
# shellcheck disable=SC2154

PROXY_ARGS=( )

if [ "$http_proxy" != "" ] ; then
	echo "Info, proxy detected"
	PROXY_ARGS=( "--build-arg" "http_proxy=${http_proxy}" "--build-arg" "https_proxy=${https_proxy}" )
fi

echo -n "What username [$ARG1] ? "
read -r MYUSERNAME
if [ "$MYUSERNAME" == "" ] && [ "$ARG1" != "" ] ; then
	MYUSERNAME="$ARG1"
fi

[ "$MYUSERNAME" == "" ] && echo "Error, blank input" && exit 1


sed -e "s/MYUSERNAME/$MYUSERNAME/g" < Dockerfile.tpl > Dockerfile

docker build --network=host "${PROXY_ARGS[@]}" -t "${TAG}-${MYUSERNAME}" .

