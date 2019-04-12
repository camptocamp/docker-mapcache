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

## Tunings

You can set a few environment variables to tune the container:

* `MAX_REQUESTS_PER_PROCESS`: Sets the limit on the number of connections
  that an individual child server process will handle. Can be used to work
  around leaks in mapcache. Defaults to 1000.
* `SERVER_LIMIT`: See https://httpd.apache.org/docs/2.4/mod/event.html (default=16)
* `MAX_REQUEST_WORKERS`: See https://httpd.apache.org/docs/2.4/mod/event.html (default=400)
* `THREADS_PER_CHILD`: See https://httpd.apache.org/docs/2.4/mod/event.html (default=25)
* `MIN_SPARE_THREADS`: See https://httpd.apache.org/docs/2.4/mod/event.html (default=75)
