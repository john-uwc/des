#!/bin/bash

#author: steven, date: 2017.3.31

include "builtin/inc"

# handle with normal change directory routine
unalias cd 2> /dev/null
cd "$@"
alias cd="source $(loc)/cd.sh"

# intelligent
# role calc auto complete, while work directory has been changed
role 1> /dev/null
rolrorol