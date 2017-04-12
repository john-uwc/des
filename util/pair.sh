#!/bin/bash

# pair structure
# author: steven, date:2017.4.12
# a kind of key|value pair implement writing in shell script language

# manual
function pair_help(){
cat << TIPS
pair <order> <container | [<args>]>
container: a memory var to store pair's raw string
order: k/v/new
args: ...
TIPS
}

# new a key value pair
function pair_new(){
if [ $# ! -eq 2 ]; then
return $__err_f_param
fi
echo "$1|$2"
}

# key of a pair, also support a pair list
function pair_k(){
if [ $# -lt 1 ]; then
return $__err_f_param
fi
local r="${1%%|*}"; shift
for p in $@; do
local i=${p%%|*} && r="$r $i"
done
echo $r
}

# value of a pair, also support a pair list
function pair_v(){
if [ $# -lt 1 ]; then
return $__err_f_param
fi
local r=$(pair_k $1) && r=${1#$r|}; shift
for p in $@; do
local i=$(pair_k $p) && i=${p#$i|} && r="$r $i"
done
echo $r
}

# main entry
function pair(){
local order=${1:-""} && shift && _invoke_2c "pair_$order $*" || pair_help
}
