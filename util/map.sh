#!/bin/bash

# map structure
# author: steven, date:2017.3.31
# a kind of map implement writing in shell script language

# remove the item tag with key
function map_del(){
echo $1 | sed "s/($2|[^)]*)//g";
}

# if item tag with key is exist, 
# remove it, then 
# append one to the head shipped with new value
function map_put(){
local result=$(map_del $1 $2); echo ${result/#{/{($2|$3)};
}

# remove all items except one tag with key, then
# fetch the value of the item
function map_get(){
local result=$(echo $1 | grep -o "($2|[^)]*)"); result=${result#(*|}; echo ${result%)};
}

# remove all items
function map_clr(){
echo "{}"
}

# if equals to result of clr order, return true
function map_empty(){
[ $1 == $(map_clr) ] && echo true || echo false
}

# map entry
function map(){
# mapping container and order parameters, 
# when raw parameter list has only one item, it must be "init", that is an order  
local container=${1:-""}; local order=$([ $# -eq 1 ] && echo $container || echo ${2:-""})
# calculate order parameters
shift; shift

# dispatch order
local result=""

while [ -z "$result" ]; do

# no order to echo help tips
if [ -z "$order" ]; then
cat << TIPS
error:invaild paraments... 
usage:map container order <params...>
container: a memory var to store map's raw string
order: del/put/get/empty/clr/init
params: ...
TIPS
break
fi

# del
if [ "del" == "$order" -a $# -eq 1 ]; then
result=$(map_del $container $1); break
fi

# put
if [ "put" == "$order" -a $# -eq 2 ]; then
result=$(map_put $container $1 $2); break
fi

# get
if [ "get" == "$order" -a $# -eq 1 ]; then
result=$(map_get $container $1); break
fi

# empty
if [ "empty" == "$order" -a $# -eq 0 ]; then
result=$(map_empty $container); break
fi

# clr, init is the same as clr order
if [ "clr" == "$order" -o "init" == "$order" -a $# -eq 0 ]; then
result=$(map_clr); break
fi

order="";

done

# result of map order
echo "$result"
}