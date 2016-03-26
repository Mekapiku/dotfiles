#!/bin/bash

if [ ! `which atom` ]; then
  # if atom not found
  exit 0
fi

apm install --packages-file `dirname $0`/atom_package_list.txt
