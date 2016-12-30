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
# This file contains the definition of a function that checks for succesfull completion
# of commands
#
#
# Developed by: Marco Raveri (mraveri@uchicago.edu)
#

function valid() {
  if [ $? -ne 0 ]; then
        echo 'ERROR'
        echo $1
        exit 1
  fi
}

