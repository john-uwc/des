#!/bin/bash

#author: steven, date: 2017.3.31

_include "util/pair.sh"

# handle with normal change directory routine
_invoke_2c "unalias" "cd"
eb=$(pwd); cd "$@"; ea=$(pwd); _dw_store "cd" $(pair new "$ea" "$eb")
_invoke_2c "alias" "cd=source $(_root)/cd.sh"
