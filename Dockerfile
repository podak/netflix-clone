# Select Docker image from DockerHub
FROM node:20.4.0-alpine

# Install some dependencies
RUN apk --update add git zip curl dumb-init make g++ && \
    rm -rf /var/cache/apk/*

ENV PATH ./node_modules/.bin:$PATH

WORKDIR /app
COPY ./ ./

