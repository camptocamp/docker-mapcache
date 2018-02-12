# MapCache

[![Docker Pulls](https://img.shields.io/docker/pulls/camptocamp/mapcache.svg)](https://hub.docker.com/r/camptocamp/mapcache/)

[![Travis](https://travis-ci.org/camptocamp/docker-mapcache.svg)](https://travis-ci.org/camptocamp/docker-mapcache)

MapCache is a server that implements tile caching to speed up access to WMS
layers. The primary objectives are to be fast and easily deployable, while
offering the essential features (and more!) expected from a tile caching
solution.

For more information, see MapCache repository: 
https://github.com/mapserver/mapcache

## Install
```
$ git clone
$ docker build -t camptocamp/mapache .
```

## Run mapcache

Get help:
```
$ docker run -d -p 8281:80 -v somewhere:/var/sig/tiles -v config.xml:/mapcache/config.xml --name mapcache camptocamp/mapcache
$ docker start mapcache
$ docker stop mapcache
```

## Run mapcache_seed

Seed google layer from config file:
```
$ docker run --rm -ti -v somewhere:/var/sig/tiles -v config.xml:/mapcache/config.xml camptocamp/mapcache mapcache_seed -c /mapcache/config.xml -l google
```

## TODO

* fastcgi
* add optionnal parameter to mapcache build

