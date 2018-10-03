FROM jackkitte/development-environment-japanese
LABEL maintainer="tamash"

WORKDIR /home/tamash
ENV DEBIAN_FRONTEND noninteractive

# JUMAN KNP Version
ENV JUMANPP_VERSION 1.02
ENV JUMAN_VERSION 7.01
ENV KNP_VERSION 4.19

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install libboost-dev google-perftools libgoogle-perftools-dev
RUN apt-get -y install gcc g++ make bzip2

# install JUMANPP
RUN wget http://lotus.kuee.kyoto-u.ac.jp/nl-resource/jumanpp/jumanpp-${JUMANPP_VERSION}.tar.xz -O /tmp/jumanpp.tar.xz
RUN tar xJvf /tmp/jumanpp.tar.xz -C /tmp
WORKDIR /tmp/jumanpp-${JUMANPP_VERSION}
RUN ./configure --prefix=/usr/local/ && make && make install
RUN rm -rf /tmp/*
RUN rm -rf /var/cache/apk/*

# workディレクトリへzshでattach
RUN mkdir /home/tamash/work
WORKDIR /home/tamash/work
ENTRYPOINT [ "/bin/zsh" ]