#!/bin/sh
# DOCKER_REGISTRY_URL used below is actually a hostname
mkdir -p /etc/docker/certs.d/${DOCKER_REGISTRY_URL}
rm -rf /etc/docker/certs.d/${DOCKER_REGISTRY_URL}/*

echo $DOCKER_REGISTRY_CERT \
    | base64 -d > /etc/docker/certs.d/${DOCKER_REGISTRY_URL}/cert.cert
echo $DOCKER_REGISTRY_CERT_KEY \
    | base64 -d > /etc/docker/certs.d/${DOCKER_REGISTRY_URL}/cert.key

openssl verify \
    -verbose \
    -CAfile /etc/ssl/certs/ca-certificates.crt \
    /etc/docker/certs.d/${DOCKER_REGISTRY_URL}/cert.cert \
    &>/dev/null

CA_CERT_EXISTS=$?

if [ $CA_CERT_EXISTS -ne 0 ]; then
    echo $DOCKER_REGISTRY_CERT_CA \
        | base64 -d \
        > /usr/local/share/ca-certificates/${DOCKER_REGISTRY_URL}.crt
    update-ca-certificates
fi