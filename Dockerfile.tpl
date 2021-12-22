# Dockerfile.tpl
# for making a Docker image which gives you WINE in Ubuntu
# edit the .tpl file and not the derived Dockerfile file.

from dorowu/ubuntu-desktop-lxde-vnc

# add packages here
#RUN apt-get -y install wine64
RUN dpkg --add-architecture i386
RUN wget -qO- https://dl.winehq.org/wine-builds/Release.key | sudo apt-key add -
RUN apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
RUN apt-get update
RUN apt-get install --install-recommends winehq-stable


RUN groupadd -g 1000 MYUSERNAME
RUN useradd -g 1000 -u 1000 MYUSERNAME

CMD su - MYUSERNAME

# end Dockerfile
