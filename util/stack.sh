#!/bin/bash

# stack structure
# author: steven, date:2017.3.31
# a kind of stack implement writing in shell script language


# fetch the value of the top item
function stack_o(){
local result=${1%%^*}; result=${result#{(}; echo ${result%)};
}

# remove the top item
function stack_pop(){
echo ${1/#{($(stack_o $1))^/{}
}

# append new item to the head of stack
function stack_push(){
echo ${1/#{/{($2)^}
}

# remove all items
function stack_clr(){
echo "{}"
}

# if equals to result of clr order, return true
function stack_empty(){
[ $1 == $(stack_clr) ] && echo true || echo false
}

stack(){
# mapping container and order parameters, 
# when raw parameter list has only one item, it must be "init", that is an order
local container=${1:-""}; local order=$([ $# -eq 1 ] && echo $container || echo ${2:-""})
# calc params
shift; shift

# dispatch order
local result=""

while [ -z "$result" ]; do

# no order to echo help tips
if [ -z "$order" ]; then
cat << TIPS
error:invaild paraments... 
usage:stack container order <params...>
container: a memory var to store stack's raw string
order: o/pop/push/empty/clr/init
params: ...
TIPS
break
fi

# o
if [ "o" == "$order" -a $# -eq 0 ]; then
result=$(stack_o $container); break
fi

# pop
if [ "pop" == "$order" -a $# -eq 0 ]; then
result=$(stack_pop $container); break
fi

# push
if [ "push" == "$order" -a $# -eq 1 ]; then
result=$(stack_push $container $1); break
fi

# empty
if [ "empty" == "$order" -a $# -eq 0 ]; then
result=$(stack_empty $container); break
fi

# clr, init is the same as clr order
if [ "clr" == "$order" -o "init" == "$order" -a $# -eq 0 ]; then
result=$(stack_clr); break
fi

order=""

done

# return result of stack order
echo "$result"
}