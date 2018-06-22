# MapCache

[![Docker Pulls](https://img.shields.io/docker/pulls/camptocamp/mapcache.svg)](https://hub.docker.com/r/camptocamp/mapcache/)

[![Travis](https://travis-ci.org/camptocamp/docker-mapcache.svg)](https://travis-ci.org/camptocamp/docker-mapcache)

MapCache is a server that implements tile caching to speed up access to WMS
layers. The primary objectives are to be fast and easily deployable, while
offering the essential features (and more!) expected from a tile caching
solution.

For more information, see MapCache repository: 
https://github.com/mapserver/mapcache

## Run mapcache_seed

Seed google layer from config file:
```
docker run --rm -ti --volume=somewhere:/var/sig/tiles --volume=config.xml:/etc/mapcache/config.xml camptocamp/mapcache:1.6 mapcache_seed -c /etc/mapcache/config.xml -l google
```

## Run mapcache

```
docker run --publish=8080:80 --volume=somewhere:/var/sig/tiles --volume=config.xml:/etc/mapcache/config.xml camptocamp/mapcache:1.6
```

## Run mapcache as non root user

```
docker run --user=www-data --publish=8080:8080 --volume=somewhere:/var/sig/tiles --volume=config.xml:/etc/mapcache/config.xml camptocamp/mapcache:1.6
```
