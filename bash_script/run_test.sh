#----------------------------------------------------------------------------------------
#
# This file is part of f2k.
#
# Copyright (C) 2016-2017 by the f2k authors
#
# The f2k code is free software;
# You can use it, redistribute it, and/or modify it under the terms
# of the GNU General Public License as published by the Free Software Foundation;
# either version 3 of the License, or (at your option) any later version.
# The full text of the license can be found in the file LICENSE at
# the top level of the f2k distribution.
#
#----------------------------------------------------------------------------------------

#
# This file contains the bash script that runs all the tests and compares the results
#

#!/bin/bash

# get the path of the script:
SCRIPT_PATH="`dirname \"$0\"`"                  # relative
SCRIPT_PATH="`( cd \"$SCRIPT_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$SCRIPT_PATH" ] ; then
  exit 1
fi

# import things:
source $SCRIPT_PATH/bash_colors.sh
source $SCRIPT_PATH/error_check.sh

# some definitions:
NUMDIFF_OPTIONS="-V --absolute-tolerance=0.001 --relative-tolerance=0.001"

# check things:

# test if numdiff works:
if ! type numdiff > /dev/null; then
	echo 'Numdiff not found test cannot procede'
	exit 1
fi

# some feedback:
printf "${Green}*********************************************************\n"
printf "Running f2k test suite:\n"
printf "*********************************************************\n${Color_Off}"
























exit 0
