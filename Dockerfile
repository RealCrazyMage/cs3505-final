# This image will be based on the ubuntu image.  Build it using the
# command in the comment below.  You may omit the ubuntu pull if you already
# did it.  Before running the build, change into the directory containing
# this Dockerfile.
#
# docker pull ubuntu
# docker build --tag myubuntu  .
# 
# (Don't forget the trailing . to specify that this directory is the context.)

FROM ubuntu

# Set a default shell.

SHELL ["/bin/bash", "-c"]

# The timezone library stops the docker build and waits for user input to
# select a timezone. This breaks the build. To get around this, 
# set up timezone information prior to installing that library. This
# Docker code does that. Composited from two sources:
# https://rtfm.co.ua/en/docker-configure-tzdata-and-timezone-during-build/
# https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="America/Salt Lake City"

# Install a handful of useful libraries.  Note that this is generally against
# best practices -- containers should be lean, and not include 'things you
# might use'.  In our case, we're using the containers for development, so
# this may be reasonable here.

RUN apt-get -y update && apt-get -y install \
   apt-utils \
   emacs-nox \
   g++
   autoconf \
   automake \
   build-essential \
   cmake \
   git-core \
   libass-dev \
   libfreetype6-dev \
   libgnutls28-dev \
   libsdl2-dev \
   libtool \
   libva-dev \
   libvdpau-dev \
   libvorbis-dev \
   libxcb1-dev \
   libxcb-shm0-dev \
   libxcb-xfixes0-dev \
   pkg-config \
   texinfo \
   wget \
   yasm \
   zlib1g-dev
   
RUN git clone git://source.ffmpeg.org/ffmpeg.git ffmpeg && ./ffmpeg && git reset --hard f7fd205f11d5299d6a16b0ff0ae85fddb32772f2 && ./configure --prefix=/ && make && make install
