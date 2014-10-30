#!/bin/sh


# edit as required
# rename this to your theme's ID:
THEMENAME="mytheme"

( echo "BUILDING THEME ARCHIVE .." ; ./build.sh ) && \
  ( echo "UPLOADING TO SERVER .." ; rsync -avzP -e "ssh -p45613" ./release/ "me@aserver.goodhuddle.com:/huddles/goodhuddle/gh-theme-library/$THEMENAME/" )
