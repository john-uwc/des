#!/bin/bash

# map structure
# author: steven, date:2017.3.31
# a kind of map implement writing in shell script language

_include "util/collection.sh"
_include "util/pair.sh"

# manual
function map_help(){
cat << TIPS
map [container] <order> [<args>]
container: a memory var to store map's raw string
order: del/put/eset/vset/kset/get/empty/clr/init
args: ...
TIPS
echo
}

# remove the item tag with key
function map_del(){
if [ $# -ne 2 ]; then
return $__err_f_param
fi
echo $(collection $1 remove $(pair new $2 .*))
}

# update item's value tag with key
function map_put(){
if [ $# -ne 3 ]; then
return $__err_f_param
fi
# if item tag with key is exist, 
# remove it, then append one to the head shipped with new value
local r=$(map_del $1 $2); r=$(collection $r insert $(pair $2 $3)); echo $r
}

# fetch element set
function map_eset(){
if [ $# -ne 1 ]; then
return $__err_f_param
fi
echo $(collection ${1:-$(collection new)} ls)
}

# fetch value set
function map_vset(){
if [ $# -ne 1 ]; then
return $__err_f_param
fi
echo $(pair v $(map_eset $1))
}

# fetch key set
function map_kset(){
if [ $# -ne 1 ]; then
return $__err_f_param
fi
echo $(pair k $(map_eset $1))
}

# fetch the value of the item tag with key
function map_get(){
if [ $# -ne 2 ]; then
return $__err_f_param
fi
echo $(pair v $(collection $1 ls $(pair new $2 *)))
}

# empty test
function map_empty(){
if [ $# -ne 1 ]; then
return $__err_f_param
fi
echo $(collection ${1:-$(collection new)} empty)
}

# clear
function map_clr(){
if [ $# -ne 1 ]; then
return $__err_f_param
fi
echo $(collection new) # generate new collection
}

# init, the same as clear
function map_init(){
if [ $# -ne 0 ]; then
return $__err_f_param
fi
echo $(map_clr)
}

# main entry
function map(){
# while the raw parameter list has a single item,
# it must be "help" or "init", that is a rule
# resolve parameter list
local container=$([ "help" == "$1" -o "init" == "$1" ] && echo "" || echo ${1:-""})
local order=$([ "help" == "$1" -o "init" == "$1" ] && echo $1 || echo ${2:-""})
shift; shift # args for order
# order execute
_invoke_2c "map_$order $container $*" || map_help
}