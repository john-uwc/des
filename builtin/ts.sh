#!/bin/bash

#author: steven, date: 2017.3.31

_include "util/map.sh"
_include "p/hint.sh"

# help tips
function help(){
cat << HELP
ts is a tool suite increment loader 
usage: ts <order> <args>
order: pck/trw
args: ....
HELP
}

# perform export path and fresh hint 
function handle(){
local hr="" && local pr=$_rp_envpath
for p in $(map $1 eset); do
pr="$pr:$(pair v $p)" && hr="$hr,$(pair k $p)"
done
PATH=$pr && hint "ts" $hr
}

# pick from cache
function pck_c(){
echo $(_cache)/ts.m/$1
}


# main
order=${1:-""}; shift

[ "help" == "$order" ] && help && return $__err_s_ # with help

# begin calculate, query current
declare result=$(_dw_query sts); [ -z $result ] && result=$(map init)

# trw
if [ "trw" == "$order" -a $# -eq 1 ]; then
result=$(map $result del $1)
fi

# pck
if [ "pck" == "$order" -a $# -le 2 -a -n "$1" ]; then
if [ -d "$2" ]; then
result=$(map $result put $1 $(cd $2 && pwd))
elif [ -d $(pck_c $1) ]; then
result=$(map $result put $1 $(pck_c $1))
fi
fi

# calculate finish, do handle
handle $result && _dw_store sts $result
