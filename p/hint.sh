#!/bin/bash

#author: steven, date: 2017.3.31

# post prompt sign
function prompt(){
if [ $# -ne 1 ]; then
return $__err_f_param
fi
local svc=$(map "$1" get vc)
local tcs=$(map "$1" get ts)
export PS1="\u@\h: \033[36m\W\033[0m \033[33m<<<\033[32m${tcs}\033[33m::\033[35m${svc}\033[33m>>>\033[0m \$ "
}


# main
function hint(){
local uic=$(_dw_query "ui"); [ -z "$uic" ] && uic=$(map init)
uic=$(map "$uic" put "$1" "$2") && prompt "$uic"
_dw_store "ui" "$uic"
}