# Local Jenkins
Run Jenkins with a single Ubuntu slave locally, useful when:
 - You don't have cloud Jenkins access
 - You want to work with Jenkins offline

## Prerequisites
 - [Docker Engine](https://docs.docker.com/docker-for-mac/install/)
 - [docker-compose](https://docs.docker.com/compose/install/)

## Running
All you need to do is build and run, configuration will be setup for you:
```shell
./build.sh # docker-compose build with key generation 
docker-compose up
```

