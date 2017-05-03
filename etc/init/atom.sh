#!/bin/bash

if [ "$(uname)" != 'Darwin' ]; then
  exit 0
fi

if [ ! `which atom` ]; then
  pushd /tmp
  curl -o atom-mac.zip -L -O https://atom.io/download/ma
  unzip atom-mac.zip
  mv Atom.app/ /Applications/

  echo "please run atom"
  exit 0
fi

# apm stars --installed
