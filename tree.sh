#!/bin/bash

echo

# If parameter exists, use it as base folder
if [ "$1" != "" ]
   then cd "$1"
fi

pwd

# -F option: append indicator (one of */=>@|) to entries
#     A '/' is a directory
#     A '*'  is executable
#     A ( '|' ) is a FIFO
#     A '@'  is a symbolic link.
# -1 option: print only one entry per line
if [ `ls -F -1 | grep "/" | wc -l` = 0 ]   # Check if no folders
   then echo "   -> no sub-directories"
fi

# ls -R print recursively
# grep ":$" filter lines with ":" at the end of a line (anchoring)
ls -R | grep ":$" | \
   sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
# 1st sed expression: remove colons
# 2nd sed expression: replace higher level folder names with dashes
# 3rd sed expression: indent graph three spaces
# 4th sed expression: replace first dash with a vertical bar

echo
