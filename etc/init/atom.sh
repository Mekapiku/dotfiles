#!/bin/bash

if [ ! `which atom` ]; then
  pushd /tmp
  curl -o atom-mac.zip -L -O https://atom.io/download/ma
  unzip atom-mac.zip
  mv Atom.app/ /Applications/

  echo "please run atom"
  exit 0
fi

apm install --packages-file `dirname $0`/atom_package_list.txt
