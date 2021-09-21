# Winthrop CSCI 208 and CSCI 210 Ubuntu Dockerfile

# start from base
FROM ubuntu:latest

MAINTAINER R. Paul Wiegand <wiegandrp@winthrop.edu>

# Install relevant software
RUN apt-get -yqq update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get -yqq install python3-pip python3-dev curl gnupg
RUN apt-get -yqq install man less nano vim emacs git iputils-ping traceroute
#RUN apt-get -yqq install openjdk-14-jdk
RUN apt-get -yqq install default-jre
RUN apt-get -yqq install gdb
RUN apt-get -yqq install libncurses-dev
RUN apt-get -yqq install libgtk2.0-0 libcanberra-gtk-module

## Eclipse will have to be installed manually
##  Here's a link that may be useful, but I'm
##  leaving it out for now.
##  https://github.com/fgrehm/docker-eclipse/blob/master/Dockerfile


# Create a user called "student" and
# enter the container as that user
RUN useradd -ms /bin/bash student
WORKDIR /home/student
USER student

# Map the student-home directory in the local dir to
# the /home/student user directory in the container 
# when you start it, but starting it as follows:
#
#   ...run container  ...call it csci210  ...run interactively and map the volume                ... use this image
#   docker run        --name csci210      -it -v /full/path/to/persistent-homedir:/home/student  winthrop/csci210:v1
#

