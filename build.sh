#!/bin/bash

if [ ! -d "master/.ssh" || ! -d "slave/.ssh" ]; then
  mkdir .ssh
  ssh-keygen -t rsa -N "" -f .ssh/id_rsa

  cp -r .ssh slave/.ssh
  cp -r .ssh master/.ssh
  rm -rf .ssh
fi

docker-compose build