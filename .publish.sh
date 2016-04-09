#!/bin/bash -e
# Setup login
openssl aes-256-cbc -K $encrypted_b6863b582c7b_key -iv $encrypted_b6863b582c7b_iv -in config.json.enc -out ~\/.docker/config.json -d
if [ "$TRAVIS_BRANCH" == "master" ]; then
  echo "Deploying image to docker hub for master (latest)"
  docker push "yjacolin/docker-mapcache:latest"
elif [ ! -z "$TRAVIS_TAG" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo "Deploying image to docker hub for tag ${TRAVIS_TAG}"
  docker push "yjacolin/docker-mapcache:${TRAVIS_TAG}"
elif [ ! -z "$TRAVIS_BRANCH" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo "Deploying image to docker hub for branch ${TRAVIS_BRANCH}"
  docker push "yjacolin/docker-mapcache:${TRAVIS_BRANCH}"
else
  echo "Not deploying image"
fi
