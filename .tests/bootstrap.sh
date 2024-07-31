#!/bin/bash

base_folder=_data/

mkdir -p ${base_folder} ${base_folder}/pb_gpg ${base_folder}/pb_jwt
curl --silent -X GET https://raw.githubusercontent.com/urbanmedia/passbolt-operator/main/docker-compose.yaml -o docker-compose.yaml
curl --silent -X GET https://raw.githubusercontent.com/urbanmedia/passbolt-operator/main/_data/passbolt_db.sql -o  ${base_folder}/passbolt_db.sql
curl --silent -X GET https://raw.githubusercontent.com/urbanmedia/passbolt-operator/main/_data/passbolt_gpg.key -o ${base_folder}/passbolt_gpg.key
curl --silent -X GET https://raw.githubusercontent.com/urbanmedia/passbolt-operator/main/_data/pb_jwt/jwt.key -o ${base_folder}/pb_jwt/jwt.key
curl --silent -X GET https://raw.githubusercontent.com/urbanmedia/passbolt-operator/main/_data/pb_jwt/jwt.pem -o ${base_folder}/pb_jwt/jwt.pem
curl --silent -X GET https://raw.githubusercontent.com/urbanmedia/passbolt-operator/main/_data/pb_gpg/serverkey.asc -o ${base_folder}/pb_gpg/serverkey.asc
curl --silent -X GET https://raw.githubusercontent.com/urbanmedia/passbolt-operator/main/_data/pb_gpg/serverkey_private.asc -o ${base_folder}/pb_gpg/serverkey_private.asc

chmod -R a+r ${base_folder}

# start database and restore database dump
docker-compose up -d db

# we need to give the database some time to start up
sleep 5

mysql \
    --host=127.0.0.1 \
    --port=13306 \
    --database=passbolt \
    --user=passbolt \
    --password=P4ssb0lt < ${base_folder}/passbolt_db.sql

# start all other services
docker-compose up -d

# we need to give the services some time to start up
sleep 10

# wait for passbolt to be ready
timeout 1m bash -c 'until [[ "$(curl -l -s -o /dev/null -w ''%{http_code}'' http://localhost:8088/auth/login?)" == "200" ]]; do sleep 5; done'
passbolt_hostname=$(hostname -I | awk '{print $1}')

kubectl create namespace "$NAMESPACE"
# create secret to authenticate with passbolt
kubectl create secret generic controller-passbolt-secret \
            --from-file=gpg_key=${base_folder}/passbolt_gpg.key \
            --from-literal=password='TestTest123!' \
            --from-literal=url=http://${passbolt_hostname}:8088 \
            --namespace ${NAMESPACE}
