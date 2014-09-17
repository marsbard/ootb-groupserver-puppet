#!/bin/sh

cd "`dirname $0`"

sudo puppet apply --modulepath=./modules manifests/init.pp
