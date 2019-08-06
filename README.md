# Local Jenkins
Run Jenkins with a single Ubuntu slave locally, useful when:
 - You don't have cloud Jenkins access
 - You want to work with Jenkins offline

## Prerequisites
 - [Docker Engine](https://docs.docker.com/docker-for-mac/install/)
 - [docker-compose](https://docs.docker.com/compose/install/)

## Running
```shell
./build.sh # docker-compose build with key generation 
docker-compose up
```
## Jenkins setup
This stuff hasn't been automated yet so:

1. Access Jenkins on http://localhost:8080
2. Continue as admin (temp password is in master logs when `docker-compose up` is run) and accept plugin installs
3. Credentials --> Add Credentials --> Enter creds with user: `jenkins`, pass: `jenkins`
4. Manage Jenkins --> Manage Nodes --> New Node
5. Configure like this: 
![Alt text](docs/agent-config.png?raw=true "agent-config")
6. Verify the connection is successful by checking the logs