#!/bin/bash

#author: steven, date: 2017.3.31

# main
function hint(){
local uic=$(_dw_query "ui"); [ -z "$uic" ] && uic=$(map init)
uic=$(map "$uic" put "$1" "$2")
_dw_store "ui" "$uic"
}

