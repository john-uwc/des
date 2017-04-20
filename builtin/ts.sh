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
function commit(){
local hr="" && local pr=$_rp_envpath
for p in $(map $1 eset); do
pr="$pr:$(pair v $p)" && hr="$hr,$(pair k $p)"
done
PATH=$pr && hint "ts" "$hr"
}

# pick from cache
function pick(){
echo $(_cache)/ts.m/$1
}

# main
order=${1:-""}
shift

# with help
[ "help" == "$order" ] && help && return $__err_s_

# begin calculate, query current
declare result=$(_dw_query "sts" $(map init))

# trw
if [ "trw" == "$order" ]; then
[ $# -ne 1 ] && return $__err_f_param
result=$(map "$result" del "$1")
fi

# pck
if [ "pck" == "$order" ]; then
[ $# -gt 2 -o -z "$1" ] && return $__err_f_param
if [ -n "$2" -a -d "$2" ]; then
result=$(map "$result" put "$1" $(cd "$2" && pwd))
else
t=$(pick "$1") && [ -d "$t" ] && result=$(map "$result" put "$1" "$t")
fi
fi

# calculate finish, do handle
commit "$result" && _dw_store "sts" "$result"
