#!/bin/bash

#author: steven, date: 2017.3.31

# handle with normal change directory routine
unalias cd 2> /dev/null
cd "$@"
alias cd="source $(_root)/cd.sh"

# intelligent
role 1> /dev/null