#!/bin/bash

#author: steven, date: 2017.3.31

include "builtin/inc"

# distinguish the current vc system
function dist(){
# git is the only support cvs now, the others may be support later
echo "git"
}

declare sys=$(dist)

# show tips for help
function help(){
cat << HELP
vc is a wrapper of version control system
such as git, svn, cvs ..., that ship with status info tracking on repos
usage: vc ...
HELP
}

# calculate status of current git repos
function st_git(){
local br=$((git branch 2> /dev/null) | grep \* | cut -c3-); ui "vc" "${br:----}"
}


# main
([ $# -lt 1 ] && help || $sys "$@" 2> /dev/null) && st_$sys