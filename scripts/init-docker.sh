# Start docker service
if [ ! -z "$DOCKER_DAEMON_JSON" ]; then
    echo $DOCKER_DAEMON_JSON | base64 -d > /etc/docker/daemon.json
fi

rc-service docker start

timeout 5s bash /usr/local/scripts/bin/wait-for-docker