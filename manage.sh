#!/bin/bash
set -e

touch .env

dev() {
    ENV=${ENV:-'dev'}
}

preprd() {
    ENV=${ENV:-'preprd'}
}

clean() {
    rm -rf server/dist/ server/node_modules/ ui/node_modules
}

setup() {
    clean
    docker-compose run --rm server npm install
}

compile-server() {
    docker-compose run --rm server npm run build
}

start-server() {
    compile-server
    docker-compose run --service-ports --rm server npm run preview
}

$@