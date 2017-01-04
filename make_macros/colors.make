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
# This file contains part of the f2k build system: makefile colors, make copy of the
# corresponding bash script
#

################### general colors           ###################################

# Reset
Color_Off  = \033[0m

# Regular Colors
Black      = \033[0;30m
Red        = \033[0;31m
Green      = \033[0;32m
Orange     = \033[0;33m
Blue       = \033[0;34m
Purple     = \033[0;35m
Cyan       = \033[0;36m
White      = \033[0;37m

# Bold
BBlack     = \033[1;30m
BRed       = \033[1;31m
BGreen     = \033[1;32m
BOrange    = \033[1;33m
BBlue      = \033[1;34m
BPurple    = \033[1;35m
BCyan      = \033[1;36m
BWhite     = \033[1;37m

# Underline
UBlack     = \033[4;30m
URed       = \033[4;31m
UGreen     = \033[4;32m
UOrange    = \033[4;33m
UBlue      = \033[4;34m
UPurple    = \033[4;35m
UCyan      = \033[4;36m
UWhite     = \033[4;37m

# Background
On_Black   = \033[40m
On_Red     = \033[41m
On_Green   = \033[42m
On_Orange  = \033[43m
On_Blue    = \033[44m
On_Purple  = \033[45m
On_Cyan    = \033[46m
On_White   = \033[47m

# High Intensty
IBlack     = \033[0;90m
IRed       = \033[0;91m
IGreen     = \033[0;92m
IOrange    = \033[0;93m
IBlue      = \033[0;94m
IPurple    = \033[0;95m
ICyan      = \033[0;96m
IWhite     = \033[0;97m

# Bold High Intensty
BIBlack    = \033[1;90m
BIRed      = \033[1;91m
BIGreen    = \033[1;92m
BIOrange   = \033[1;93m
BIBlue     = \033[1;94m
BIPurple   = \033[1;95m
BICyan     = \033[1;96m
BIWhite    = \033[1;97m

# High Intensty backgrounds
On_IBlack  = \033[0;100m
On_IRed    = \033[0;101m
On_IGreen  = \033[0;102m
On_IOrange = \033[0;103m
On_IBlue   = \033[0;104m
On_IPurple = \033[10;95m
On_ICyan   = \033[0;106m
On_IWhite  = \033[0;107m
