#!/bin/bash

#author: steven, date: 2017.3.31

_include "p/hint.sh"

# distinguish the current vc system
function distsys(){
# git is the only support cvs now, the others may be support later
echo "git"
}

declare sys=$(distsys)

# show tips for help
function help(){
cat << HELP
vc is a wrapper of version control system
such as git, svn, cvs ..., that ship with status info tracking on repos
usage: vc [<args>]
HELP
}

# calculate status of current git repos
function st_git(){
local br=$((invoke_2c "git branch") | grep \* | cut -c3-) && hint "vc" "${br:----}"
}


# main
([ $# -lt 1 ] && help || _invoke_2c $sys $*) && st_$sys