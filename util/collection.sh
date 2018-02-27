#!/bin/bash

# collection structure
# author: steven, date:2017.4.12
# a kind of collection implement writing in shell script language

_include "util/pair.sh"

# manual
function collection_help(){
cat << TIPS
collection [container] <order> [<args>]
container: a memory var to store raw string of collection
order: clr/at/ls/size/remove/insert/empty
args: ...
TIPS
}

# clear with items
function collection_clr(){
if [ $# -lt 1 ]; then
return $__err_f_param
fi
shift
local r="{"
for i in "$@"; do
r=$r"($i)" 
done
r=$r"}" && echo "$r"
}

# fetch items in the collection at a group of fix position,
# if not any fix position, the all items should be hit
function collection_at(){
if [ $# -lt 1]; then
return $__err_f_param
fi
local cls=$(echo "$1" \
| perl -e '@l= <>=~/(?x)\((([^\(\)]*|\((?1)\))*)\)/g; print "@l\n"')
shift
local r=$cls
if [ $# -gt 0 ]; then
r=""; for i in "$@"; do r=$r${cls[$i]}; done
fi
echo "$r"
}

# as a list according to a selector, which could be null or a regular expression
function collection_ls(){
if [ $# -lt 1 ]; then
return $__err_f_param
fi
local r=""
local p=-1
for i in $(collection_at "$1"); do
p=$[p+1]; [ -z ${i/${2:-*}/} ] && r="$r $(pair new $p $i) "
done
echo "$r"
}

# calculate size
function collection_size(){
if [ $# -ne 1 ]; then
return $__err_f_param
fi
local r=($(collection_at "$1")) && echo ${#r[@]}
}

# remove items from collection at a group of fix position
function collection_remove(){
if [ $# -lt 2 ]; then
return $__err_f_param
fi
local r=($(collection_at "$1"))
local o=$1; shift
for i in "$@"; do
unset r[$i]
done
echo $(collection_clr "$o" ${r[@]})
}

# insert item to collection at fix position
function collection_insert(){
if [ $# -ne 3 ]; then
return $__err_f_param
fi
local r=($(collection_at "$1"))
local i=$3; [ $i -lt 0 ] && i=0 || [ $i -gt ${#r[@]} ] && i=${#r[@]}
local p=${#r[@]}
while [ $p -ne $i ]; do
p=$[p-1] && r[$[p+1]]=${r[$p]}
done
r[$i]=$2
echo $(collection_clr "$1" ${r[@]})
}

# empty test
function collection_empty(){
[ $1 == $(collection_clr "{}") ] && echo true || echo false # if equals to a new collection, return true, otherwise false
}

# main entry
function collection(){
# while the raw parameter list has a single item,
# it must be "help" or "new", that is a rule
# resolve parameter list
local container=$([ "help" == "$1" ] && echo "" || echo ${1:-""})
local order=$([ "help" == "$1" ] && echo $1 || echo ${2:-""})
shift; shift # args for order
# order execute
_invoke_2c "collection_$order" "$container" "$@" || collection_help
}