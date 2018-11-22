#!/bin/bash
pushd agilent4uhv/server
	./run-local.sh
popd
pushd mks937b/server
	./run-local.sh
popd
pushd mbtemp/server
	./run-local.sh
popd
