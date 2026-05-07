DOCKER_FILE=${DOCKER_FILE:-Dockerfile.home}
docker build -f "$DOCKER_FILE" -t dockergenesis:latest .
