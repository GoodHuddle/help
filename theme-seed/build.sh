#!/bin/sh

rm -rf release/* && \
  mkdir -p release && \
  cp src/thumbnail.png release && \
  cp src/site.xml release && \
  cd src && \
  ./rebuild_bootstrap.sh && \
  zip -x 'resources/bower_components/bootstrap/node_modules/*' -r ../release/theme.zip .
