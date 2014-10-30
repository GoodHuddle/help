#!/bin/sh

cp *.less ./resources/bower_components/bootstrap/less/ && \
  cd ./resources/bower_components/bootstrap/ && \
  grunt dist --force

