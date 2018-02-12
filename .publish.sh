#!/bin/bash -e
# Setup login

if  [ "$TRAVIS_PULL_REQUEST" == "false" ]
then
    mkdir ${HOME}\/.docker
    openssl aes-256-cbc -K $encrypted_b6863b582c7b_key -iv $encrypted_b6863b582c7b_iv -in config.json.enc -out ${HOME}\/.docker/config.json -d

    if [ "$TRAVIS_BRANCH" == "$MAIN_BRANCH" ]
    then
        echo "Deploying image to docker hub for master (latest)"
        docker push "camptocamp/mapcache:latest"
    elif [ ! -z "$TRAVIS_TAG" ]
    then
        echo "Deploying image to docker hub for tag ${TRAVIS_TAG}"
        docker push "camptocamp/mapcache:${TRAVIS_TAG}"
    elif [ ! -z "$TRAVIS_BRANCH" ]
    then
        echo "Deploying image to docker hub for branch ${TRAVIS_BRANCH}"
        docker push "camptocamp/mapcache:${TRAVIS_BRANCH}"
    else
        echo "Not deploying image"
    fi
fi
