FROM jackkitte/development-environment-japanese
LABEL maintainer="tamash"

WORKDIR /home/tamash
ENV DEBIAN_FRONTEND noninteractive

# JUMAN KNP Version
ENV JUMANPP_VERSION 1.02
ENV JUMAN_VERSION 7.01
ENV KNP_VERSION 4.19

# apt update and upgrade
RUN sudo apt-get update && sudo apt-get -y upgrade
RUN sudo apt-get -y install libboost-dev google-perftools libgoogle-perftools-dev
RUN sudo apt-get -y install gcc g++ make bzip2

# install JUMANPP
RUN wget http://lotus.kuee.kyoto-u.ac.jp/nl-resource/jumanpp/jumanpp-${JUMANPP_VERSION}.tar.xz -O /tmp/jumanpp.tar.xz
RUN tar xJvf /tmp/jumanpp.tar.xz -C /tmp
WORKDIR /tmp/jumanpp-${JUMANPP_VERSION}
RUN sudo ./configure --prefix=/usr/local/ && sudo make && sudo make install
RUN sudo rm -rf /tmp/*
RUN sudo rm -rf /var/cache/apk/*

# install JUMAN
RUN wget http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/juman/juman-${JUMAN_VERSION}.tar.bz2 -O /tmp/juman.tar.bz2
RUN tar xf /tmp/juman.tar.bz2 -C /tmp
WORKDIR /tmp/juman-${JUMAN_VERSION}
RUN sudo ./configure --prefix=/usr/local/ && sudo make && sudo make install
RUN sudo rm -rf /tmp/*
RUN sudo rm -rf /var/cache/apk/*
RUN sudo apt-get -y install libjuman4

# install KNP
RUN wget http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/knp/knp-${KNP_VERSION}.tar.bz2 -O /tmp/knp.tar.bz2
RUN tar xf /tmp/knp.tar.bz2 -C /tmp
WORKDIR /tmp/knp-${KNP_VERSION}
RUN sudo ./configure --prefix=/usr/local/ --with-juman-prefix=/usr/local/ && sudo make && sudo make install
RUN sudo rm -rf /tmp/*
RUN sudo rm -rf /var/cache/apk/*

# workディレクトリへzshでattach
WORKDIR /home/tamash/work
ENTRYPOINT [ "/bin/zsh" ]