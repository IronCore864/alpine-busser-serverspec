FROM ruby:alpine

RUN apk add --no-cache ansible git nodejs nodejs-npm

COPY serverspec .
RUN ./serverspec

