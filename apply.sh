#!/bin/sh

cd "`dirname $0`"

sudo puppet apply -v -d --modulepath=./modules manifests/init.pp
