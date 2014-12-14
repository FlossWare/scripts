#!/bin/bash 

#
# This file is part of the FlossWare family of open source software.
#
# FlossWare is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA
#

#
# General purpose utility script.
#

#
# Emit a message to std err
#
# Optional params:
#   $* - these will be echo'd to std-err.
#
emit-msg() {
    echo $* 1>&2
}

#
# Emit an error and exit
#
# Optional params:
#   $* - these will be echo'd to std-err.
#
error-msg() {
    emit-msg "ERROR:  $*"
    exit 1
}
#
# Emit a warning.
#
# Optional params:
#   $* - these will be echo'd to std-err.
#
warning-msg() {
    emit-msg "WARNING:  $*"
}

#
# Emit an informational message.
#
# Optional params:
#   $* - these will be echo'd to std-err.
#
info-msg() {
    emit-msg "INFO:  $*"
}

#
# Compute a default value.  If 2 params handed in, return the second
# one otherwise return the first.
#
# Requried params:
#   $1 - if this is the only param it will be returned.
#
# Optional params:
#   $2 - If defined will be the value returned.
#
compute-default-value() {
    if [ $# -eq 2  -a "$2" != "" ]
    then
        echo $2
    else
        echo $1
    fi
}

#
# Ensure we have a total number of parameters.
#
# Optional params:
#   $1     - if not handed in, will default to 0 params.
#   $2..$N - the params to count.
#
ensure-total-params() {
    TOTAL=`compute-default-value 0 $1`
    shift

    if [ $# -lt "${TOTAL}" -o $# -gt "${TOTAL}" ]
    then
        error-msg "Wrong number of total parameters - expected ${TOTAL}"
    fi
}

#
# Ensure we have a minimum number of params
#
# Optional params:
#   $1     - if not handed in, will default to 0 params.
#   $2..$N - the params to count.
#
ensure-min-params() {
    MIN=`compute-default-value 0 $1`
    shift

    if [ $# -lt ${MIN} ]
    then
        error-msg "Wrong number of minimum parameters - expected at least ${MIN}"
    fi
}

#
# Ensure we have a maximum number of params
#
# Optional params:
#   $1     - if not handed in, will default to 0 params.
#   $2..$N - the params to count.
#
ensure-max-params() {
    MAX=`compute-default-value 0 $1`
    shift

    if [ $# -gt ${MAX} ]
    then
        error-msg "Wrong number of maximum parameters - had ${MAX}"
    fi
}

#
# Ensure a file exists.
#
# Required params:
#   $1 - the file to examine for existance.
#
ensure-file-exists() {
    ensure-total-params 1 $* &&
    if [ ! -e $1 ]
    then
        pwd
        error-msg "File [$1] does not exist!" 1>&2
    fi
}

#
# Ensure a directory exists.
#
# Required params:
#   $1 - the directory to examine for existance.
#
ensure-dir-exists() {
    ensure-total-params 1 $* &&
    if [ ! -d $1 ]
    then
        pwd
        error-msg "Directory [$1] does not exist!" 1>&2
    fi
}

#
# Using params, separate them with commas.
#
# Optional params:
#   $* - all the params to comma separate.
#
separate-with-commas() {
    echo $* | tr -s ' ' ','
}

#
# Convert to a dashed list.
#
# Optional params:
#   $* - all the params to make a dashed list.
#
convert-to-dashed-list() {
    if [ "$*" != "" ]
    then
        echo "- $*" | sed ':a;N;$!ba;s/\n/\n- /g'
    fi
}

#
# Using params, convert to CSV enclosing each field with quotes.
#
# Optional params:
#   $* - all the params to make a CSV..
#
convert-to-csv() {
    VALUE="\(\([[:alnum:]]\)\|\(-\)\|\(\.\)\)\+"
    echo $* | sed -e "s/${VALUE}/\"\0\"/g" -e "s/\" \"/\", \"/g"
}

#
# Take a param and increment it by 1.
#
# Required params:
#   $1 - the value to increment.
#
increment-value() {
    ensure-total-params 1 $* &&
    expr $1 + 1
}

#
# Take a param and decrement it by 1.
#
# Required params:
#   $1 - the value to decrement
#
decrement-value() {
    ensure-total-params 1 $* && expr $1 - 1
}

#
# Create a unique value  We will use an optional prefix and suffix,
# plus the current system date down to nanoseconds and the built in
# RANDOM variable.
#
# Optional params:
#   $1 - the prefix of the computed uniqe string.
#   $2 - the suffix of the computed uniqe string.
#
generate-unique() {
    echo "$1`date +%Y%m%d%H%M%S%N`${RANDOM}$2"
}

#
# Using whatever params are handed in, execute and
# ensure newline are preserved.  Useful if one desires
# the results be stored in a variable.
#
# Optional params:
#   $* - will be echo'd to maintain newlines.
#
execute-with-newlines-preserved() {
    OLD_IFS=$IFS

    IFS=$'\n'

    $*

    IFS=${OLD_IFS}
}

#
# Useless - but makes a nice placeholder.
#
noop() {
    NOOP=""
}