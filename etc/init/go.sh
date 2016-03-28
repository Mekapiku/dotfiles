#!/bin/bash

go get -u -v github.com/alecthomas/gometalinter
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v github.com/nsf/gocode
go get -u -v github.com/rogpeppe/godef
go get -u -v golang.org/x/tools/cmd/oracle
go get -u -v github.com/tools/godep

gometalinter --install --update
