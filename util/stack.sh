#!/bin/bash

# stack structure
# author: steven, date:2017.3.31
# a kind of stack implement writing in shell script language

_include "util/collection.sh"

# manual
function stack_help(){
cat << TIPS
stack [container] <order> [<args>]
container: a memory var to store stack's raw string
order: o/pop/push/empty/clr/init
args: ...
TIPS
}

# fetch the value of the top item
function stack_o(){
if [ $# -ne 1 ]; then
return $__err_f_param
fi
echo $(collection $1 at 0)
}

# pop the top item
function stack_pop(){
if [ $# -ne 1 ]; then
return $__err_f_param
fi
# remove the top item
echo $(collection $1 remove 0)
}

# push new item
function stack_push(){
if [ $# -ne 2 ]; then
return $__err_f_param
fi
# append new item to the head of stack
echo $(collection $1 insert $2)
}

# empty test
function stack_empty(){
if [ $# -ne 1 ]; then
return $__err_f_param
fi
echo $(collection ${1:-$(collection new)} empty)
}

# clear
function stack_clr(){
if [ $# -ne 1 ]; then
return $__err_f_param
fi
echo $(collection new) # generate new collection
}

# init, the same as clear
function stack_init(){
if [ $# -ne 0 ]; then
return $__err_f_param
fi
echo $(stack_clr)
}

# main entry
function stack(){
# while the raw parameter list has a single item,
# it must be "help" or "init", that is a rule
# resolve parameter list
local container=$([ "help" == "$1" -o "init" == "$1" ] && echo "" || echo ${1:-""})
local order=$([ "help" == "$1" -o "init" == "$1" ] && echo $1 || echo ${2:-""})
shift; shift # args for order
# order execute
_invoke_2c "stack_$order $container $*" || stack_help
}