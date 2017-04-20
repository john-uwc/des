#!/bin/bash

#author: steven, date: 2017.3.31

# post prompt sign
function prompt(){
export PS1="\u@\h: \033[36m\W\033[0m \033[33m<<<\033[32m$(_dw_query ts)\033[33m::\033[35m$(_dw_query vc)\033[33m>>>\033[0m \$ "
}


# main
function hint(){
_dw_store "$1" "$2" && prompt
}