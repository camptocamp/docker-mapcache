#!/bin/bash -e

if [ "$TRAVIS_BRANCH" == "$MAIN_BRANCH" ]
then
    echo "Building image with tag latest"
    docker build --tag=camptocamp/mapcache:latest .
elif [ ! -z "$TRAVIS_TAG" ]
then
    echo "Building image with tag ${TRAVIS_TAG}"
    docker build --tag=camptocamp/mapcache:$TRAVIS_TAG .
elif [ ! -z "$TRAVIS_BRANCH" ]
then
    echo "Building image with tag ${TRAVIS_BRANCH}"
    docker build --tag=camptocamp/mapcache:$TRAVIS_BRANCH .
else
    echo "Don't know how to build image"
    exit 1
fi
