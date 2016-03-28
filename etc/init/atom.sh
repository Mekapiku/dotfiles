#!/bin/bash

if [ ! `which atom` ]; then
  # if atom not found
  echo "atom not found. Please install atom from https://atom.io/"
  exit 0
fi

apm install --packages-file `dirname $0`/atom_package_list.txt
