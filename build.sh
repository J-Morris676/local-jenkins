if [ ! -d ".ssh" ]; then
  mkdir .ssh & ssh-keygen -t rsa -N "" -f .ssh/id_rsa
fi

docker-compose build