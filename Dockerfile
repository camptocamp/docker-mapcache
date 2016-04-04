FROM debian:stable
MAINTAINER Yves Jacolin <yjacolin@free.fr>

ENV VERSION 2016-04-02
ARG MAPCACHE_VERSION=master

RUN apt-get update
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -qqy git cmake \
    build-essential \
    libfcgi-dev liblz-dev libpng-dev libgdal-dev libgeos-dev \
    libpixman-1-dev libsqlite0-dev libcurl4-openssl-dev \
    libaprutil1-dev libapr1-dev libjpeg-dev libdpkg-dev \
    libdb5.3-dev libtiff5-dev libpcre3-dev \ 
    apache2 apache2-threaded-dev apache2-mpm-worker apache2

RUN mkdir /build && mkdir -p /var/sig/tiles
RUN mkdir /mapcache

RUN cd /build && git clone https://github.com/mapserver/mapcache.git && \
    cd /build/mapcache && git checkout ${MAPCACHE_VERSION} && \
    mkdir /build/mapcache/build && cd /build/mapcache/build && \
    cmake \
      -DCMAKE_BUILD_TYPE=Release \
      .. && \
    make && make install && ldconfig && \
    cp /build/mapcache/mapcache.xml /mapcache/ && \
    rm -Rf /build/mapcache

ADD mapcache.conf /etc/apache2/sites-available/mapcache.conf
ADD mapcache.load /etc/apache2/mods-available/mapcache.load
RUN a2enmod mapcache
RUN a2dissite 000-default
RUN a2ensite mapcache

RUN  apt-get purge -y software-properties-common build-essential cmake ;\
 apt-get autoremove -y ; \
 apt-get clean ; \
 rm -rf /var/lib/apt/lists/partial/* /tmp/* /var/tmp/*

WORKDIR /mapcache
VOLUME ["/mapcache", "/var/sig/tiles"]

EXPOSE 80

CMD ["apache2ctl", "-DFOREGROUND"]
