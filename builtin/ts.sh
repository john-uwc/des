#!/bin/bash

#author: steven, date: 2017.3.31

include "builtin/inc"

# show tips for help
function help(){
cat << HELP
ts is a tool suite increment loader 
usage: ts order params...
order: pck/trw
params: ....
HELP
}

# path for search
function tpath(){
echo $(loc)/../role/$1
}


#
# main
#
order=${1:-""}; shift; [ "help" == "$order" ] && help

# query current
declare result=$(_dw_query sts); echo $result ;[ -z $result ] && result=$(map init)

# trw
if [ "trw" == "$order" -a $# -eq 1 ]; then
result=$(map $result del $1)
fi

# pck
if [ "pck" == "$order" -a $# -le 2 -a -n "$1" ]; then
if [ -d "$2" ]; then
result=$(map $result put $1 $2)
elif [ -d "$(tpath $1)" ]; then
result=$(map $result put $1 $(tpath $1))
fi
fi

# restore 
$(_dw_store sts $result)

# post handle ts
result=${result#\{} && result=${result%\}} && echo $result

PATH=$env_rp_path:$(root)$(echo $result | sed -E "s/\([^|]*|([^\)]*)\)/:\1/g")  && ui "ts" $(echo $result | sed -E "s/\(([^|]*)|[^\)]*\)/,\1/g")