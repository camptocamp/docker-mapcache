FROM debian:stretch
MAINTAINER Camptocamp "info@camptocamp.com"

ENV VERSION 2018-02-09
ENV MAPCACHE_VERSION=branch-1-6

RUN apt-get update
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -qqy git cmake \
        build-essential \
        libfcgi-dev liblz-dev libpng-dev libgdal-dev libgeos-dev \
        libpixman-1-dev libsqlite0-dev libcurl4-openssl-dev \
        libaprutil1-dev libapr1-dev libjpeg-dev libdpkg-dev \
        libdb5.3-dev libtiff5-dev libpcre3-dev \
        apache2 apache2-dev apache2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/partial/* /tmp/* /var/tmp/*

RUN mkdir /build
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

RUN a2enmod mapcache rewrite && \
    a2dissite 000-default && \
    a2ensite mapcache && \
    a2dismod -f auth_basic authn_file authn_core authz_host authz_user autoindex dir status && \
    rm /etc/apache2/mods-enabled/alias.conf && \
    find /etc/apache2 -type f -exec sed -ri ' \
       s!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g; \
       s!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g; \
       ' '{}' ';'

WORKDIR /mapcache
VOLUME ["/mapcache"]

EXPOSE 80

CMD ["apache2ctl", "-DFOREGROUND"]
