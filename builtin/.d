#!/bin/bash

#author: steven, date: 2017.3.31

_include "util/pair.sh"

# handle with normal change directory routine
_invoke_2c "unalias" "cd"
local eb=$(pwd); cd "$@"; local ea=$(pwd); _dw_store "d" $(pair new "$ea" "$eb")
_invoke_2c "alias" "cd=source .d"
