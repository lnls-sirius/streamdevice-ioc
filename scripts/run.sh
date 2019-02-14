#!/bin/bash
source common/functions

echo Folder ${1}\; Prefix ${2}\; BASE PORT ${3};

build ${1} ${2} ${3};
run_ioc ${2};