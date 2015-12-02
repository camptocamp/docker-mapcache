FROM tianon/apache2

ENV MAPCACHE_VERSION 1.4.0-1~bpo8+1

RUN echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list

RUN apt-get update \
  && apt-get install -y mapcache-cgi=$MAPCACHE_VERSION libmapcache1=$MAPCACHE_VERSION libapache2-mod-mapcache=$MAPCACHE_VERSION \
  && rm -rf /var/lib/apt/lists/*

COPY mapcache.conf /etc/apache2/conf-enabled/

RUN mkdir /etc/mapcache \
  && cp /usr/share/doc/libapache2-mod-mapcache/examples/mapcache.xml /etc/mapcache/mapcache.xml

ONBUILD COPY mapcache.xml /etc/mapcache/mapcache.xml
