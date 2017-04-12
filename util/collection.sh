#!/bin/bash

# collection structure
# author: steven, date:2017.4.12
# a kind of collection implement writing in shell script language

# manual
function collection_help(){
cat << TIPS
collection [container] <order> [<args>]
container: a memory var to store collection's raw string
order: new/ls/size/remove/add/empty
args: ...
TIPS
}

# new collection
function collection_new(){
echo "{}"
}

# as list, support regex selector
function collection_ls(){
if [ $# -lt 2 -o $# -gt 3 ]; then
return $__err_f_param
fi
# TODO: list collection items
echo $r
}

# calculate size
function collection_size(){
if [ $# ! -eq 1 ]; then
return $__err_f_param
fi
echo $(collection_ls $1 | wc)
}

# remove element from collection, support regex
function collection_remove(){
if [ $# ! -eq 2 ]; then
return $__err_f_param
fi
local r=$1
for i in $(collection_ls $1 $2); do
r=$(echo $r | sed s/($i)//g)
done
echo $r
}

# add item to collection
function collection_add(){
if [ $# ! -eq 2 ]; then
return $__err_f_param
fi
echo ${1/#{/{($2)}
}

# empty test
function collection_empty(){
[ $1 == $(collection_new) ] && echo true || echo false # if equals to a new collection, return true, otherwise false
}

# main entry
function collection(){
# while the raw parameter list has a single item,
# it must be "help" or "new", that is a rule
# resolve parameter list
local container=$([ "help" == "$1" -o "new" == "$1" ] && echo "" || echo ${1:-""})
local order=$([ "help" == "$1" -o "new" == "$1" ] && echo $1 || echo ${2:-""})
shift; shift # args for order
# order execute
_invoke_2c "collection_$order $container $*" || collection_help
}
