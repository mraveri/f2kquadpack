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
# This file contains the main part of the f2k build system.
# Additional build systema macros can be found in the folder make_macros.
#

################### directory structure ########################################

# fix the paths of the project:
PROJECT_DIR=$(abspath .)
MAKE_DIR=$(PROJECT_DIR)/make_macros

# include make macros:
include $(MAKE_DIR)/colors.make
include $(MAKE_DIR)/pretty_output.make
include $(MAKE_DIR)/compilers_options.make
include $(MAKE_DIR)/project_structure.make
include $(MAKE_DIR)/setup_cleanup.make
include $(MAKE_DIR)/test.make

################### global targets      ########################################

all:

################### old library build   ########################################

# get the libraries source files:
OLD_SOURCES := $(wildcard $(OLD_SOURCE_DIR)/*.f90)
OLD_SOURCES += $(wildcard $(OLD_SOURCE_DIR)/*.f)
# replace the extension:
OLD_SOURCES_TEMP_1 := $(basename $(OLD_SOURCES))
# remove the path:
OLD_SOURCES_TEMP_2 := $(notdir $(OLD_SOURCES_TEMP_1))
# define the library files:
OLD_SOURCES_FILES := $(addsuffix .o, $(OLD_SOURCES_TEMP_2))
# define the targets:
OLD_SOURCES_TARGETS = $(addprefix $(OLD_BUILD_OBJ_DIR)/, $(OLD_SOURCES_FILES))
	
# compile the old library:
$(OLD_BUILD_OBJ_DIR)/%.o: $(OLD_SOURCE_DIR)/%.f90 | old_code_build_directories
	@printf "%-${COL}s %-${COL}s" "Compiling old library: " $* ; \
	CMD="$(F90C) $(FFLAGS) $(LAPACK_LINK) $(LAPACK_INCLUDE) $(MODULE_FLAG)$(OLD_BUILD_INC_DIR) -c $(OLD_SOURCE_DIR)/$*.f90 -o $(OLD_BUILD_OBJ_DIR)/$*.o" ; \
	LOG="$$($${CMD} 2>&1 )" ; \
	if [ $$? -eq 1 ]; then \
        printf "%b%b" $(ERROR_STRING) "\n" ; \
        printf "%b%s" " $(Red)Command failing: $(Color_Off)" $${CMD} ; \
        printf "\n"; \
        printf "%b%s" " $(Red)Fail log: $(Color_Off)" "$${LOG}" ; \
        printf "\n"; \
        false ; \
    elif [ "$${LOG}" != "" ] ; then \
    	printf "%b%b" $(WARN_STRING) "\n" ; \
        printf "%b%s" " $(Orange)Command: $(Color_Off)" $${CMD} ; \
        printf "\n"; \
        printf "%b%s" " $(Orange)Warning log: $(Color_Off)" "$${LOG}" ; \
        printf "\n"; \
    else \
        printf "%b%b" $(OK_STRING) "\n"; \
    fi;
	
$(OLD_BUILD_OBJ_DIR)/%.o: $(OLD_SOURCE_DIR)/%.f | old_code_build_directories
	@printf "%-${COL}s %-${COL}s" "Compiling old library: " $* ; \
	CMD="$(F90C) $(FFLAGS) $(LAPACK_LINK) $(LAPACK_INCLUDE) $(MODULE_FLAG)$(OLD_BUILD_INC_DIR) -c $(OLD_SOURCE_DIR)/$*.f -o $(OLD_BUILD_OBJ_DIR)/$*.o" ; \
	LOG="$$($${CMD} 2>&1 )" ; \
	if [ $$? -eq 1 ]; then \
        printf "%b%b" $(ERROR_STRING) "\n" ; \
        printf "%b%s" " $(Red)Command failing: $(Color_Off)" $${CMD} ; \
        printf "\n"; \
        printf "%b%s" " $(Red)Fail log: $(Color_Off)" "$${LOG}" ; \
        printf "\n"; \
        false ; \
    elif [ "$${LOG}" != "" ] ; then \
    	printf "%b%b" $(WARN_STRING) "\n" ; \
        printf "%b%s" " $(Orange)Command: $(Color_Off)" $${CMD} ; \
        printf "\n"; \
        printf "%b%s" " $(Orange)Warning log: $(Color_Off)" "$${LOG}" ; \
        printf "\n"; \
    else \
        printf "%b%b" $(OK_STRING) "\n"; \
    fi;

old_library: $(OLD_SOURCES_TARGETS) | old_code_build_directories
	@printf "%-${COL}s %-${COL}s" "Creating old library : " $* ; \
	CMD="ar -r $(OLD_BUILD_LIB_DIR)/lib$@.a $(OLD_SOURCES_TARGETS)" ; \
	LOG="$$($${CMD} 2>&1 )" ; \
	if [ $$? -eq 1 ]; then \
        printf "%b%b" $(ERROR_STRING) "\n" ; \
        printf "%b%s" " $(Red)Command failing: $(Color_Off)" $${CMD} ; \
        printf "\n"; \
        printf "%b%s" " $(Red)Fail log: $(Color_Off)" "$${LOG}" ; \
        printf "\n"; \
        false ; \
    else \
        printf "%b%b" $(OK_STRING) "\n"; \
    fi;
	
all: old_library

################### new library build   ########################################

# get the libraries source files:
NEW_SOURCES := $(wildcard $(NEW_SOURCE_DIR)/*.f90)
NEW_SOURCES += $(wildcard $(NEW_SOURCE_DIR)/*.f)
# replace the extension:
NEW_SOURCES_TEMP_1 := $(basename $(NEW_SOURCES))
# remove the path:
NEW_SOURCES_TEMP_2 := $(notdir $(NEW_SOURCES_TEMP_1))
# define the library files:
NEW_SOURCES_FILES := $(addsuffix .o, $(NEW_SOURCES_TEMP_2))
# define the targets:
NEW_SOURCES_TARGETS = $(addprefix $(NEW_BUILD_OBJ_DIR)/, $(NEW_SOURCES_FILES))

# compile the new library:
$(NEW_BUILD_OBJ_DIR)/%.o: $(NEW_SOURCE_DIR)/%.f90 | new_code_build_directories
	@printf "%-${COL}s %-${COL}s" "Compiling new library: " $* ; \
	CMD="$(F90C) $(FFLAGS) $(LAPACK_LINK)  $(LAPACK_INCLUDE) $(MODULE_FLAG)$(NEW_BUILD_INC_DIR) -c $(NEW_SOURCE_DIR)/$*.f90 -o $(NEW_BUILD_OBJ_DIR)/$*.o" ; \
	LOG="$$($${CMD} 2>&1 )" ; \
	if [ $$? -eq 1 ]; then \
        printf "%b%b" $(ERROR_STRING) "\n" ; \
        printf "%b%s" " $(Red)Command failing: $(Color_Off)" $${CMD} ; \
        printf "\n"; \
        printf "%b%s" " $(Red)Fail log: $(Color_Off)" "$${LOG}" ; \
        printf "\n"; \
        false ; \
    elif [ "$${LOG}" != "" ] ; then \
    	printf "%b%b" $(WARN_STRING) "\n" ; \
        printf "%b%s" " $(Orange)Command: $(Color_Off)" $${CMD} ; \
        printf "\n"; \
        printf "%b%s" " $(Orange)Warning log: $(Color_Off)" "$${LOG}" ; \
        printf "\n"; \
    else \
        printf "%b%b" $(OK_STRING) "\n"; \
    fi;
    
$(NEW_BUILD_OBJ_DIR)/%.o: $(NEW_SOURCE_DIR)/%.f | new_code_build_directories
	@printf "%-${COL}s %-${COL}s" "Compiling new library: " $* ; \
	CMD="$(F90C) $(FFLAGS) $(LAPACK_LINK) $(LAPACK_INCLUDE) $(MODULE_FLAG)$(NEW_BUILD_INC_DIR) -c $(NEW_SOURCE_DIR)/$*.f -o $(NEW_BUILD_OBJ_DIR)/$*.o" ; \
	LOG="$$($${CMD} 2>&1 )" ; \
	if [ $$? -eq 1 ]; then \
        printf "%b%b" $(ERROR_STRING) "\n" ; \
        printf "%b%s" " $(Red)Command failing: $(Color_Off)" $${CMD} ; \
        printf "\n"; \
        printf "%b%s" " $(Red)Fail log: $(Color_Off)" "$${LOG}" ; \
        printf "\n"; \
        false ; \
    elif [ "$${LOG}" != "" ] ; then \
    	printf "%b%b" $(WARN_STRING) "\n" ; \
        printf "%b%s" " $(Orange)Command: $(Color_Off)" $${CMD} ; \
        printf "\n"; \
        printf "%b%s" " $(Orange)Warning log: $(Color_Off)" "$${LOG}" ; \
        printf "\n"; \
    else \
        printf "%b%b" $(OK_STRING) "\n"; \
    fi;
    
new_library: $(NEW_SOURCES_TARGETS) | new_code_build_directories
	@printf "%-${COL}s %-${COL}s" "Creating new library : " $* ; \
	CMD="ar -r $(NEW_BUILD_LIB_DIR)/lib$@.a $(NEW_SOURCES_TARGETS)" ; \
	LOG="$$($${CMD} 2>&1 )" ; \
	if [ $$? -eq 1 ]; then \
        printf "%b%b" $(ERROR_STRING) "\n" ; \
        printf "%b%s" " $(Red)Command failing: $(Color_Off)" $${CMD} ; \
        printf "\n"; \
        printf "%b%s" " $(Red)Fail log: $(Color_Off)" "$${LOG}" ; \
        printf "\n"; \
        false ; \
    else \
        printf "%b%b" $(OK_STRING) "\n"; \
    fi \
        
all: new_library

################### addon library build   ######################################

# get the libraries source files:
ADD_SOURCES := $(wildcard $(ADD_SOURCE_DIR)/*.f90)
ADD_SOURCES += $(wildcard $(ADD_SOURCE_DIR)/*.f)
# replace the extension:
ADD_SOURCES_TEMP_1 := $(basename $(ADD_SOURCES))
# remove the path:
ADD_SOURCES_TEMP_2 := $(notdir $(ADD_SOURCES_TEMP_1))
# define the library files:
ADD_SOURCES_FILES := $(addsuffix .o, $(ADD_SOURCES_TEMP_2))
# define the targets:
ADD_SOURCES_TARGETS = $(addprefix $(ADD_BUILD_OBJ_DIR)/, $(ADD_SOURCES_FILES))

# compile the additional library:
$(ADD_BUILD_OBJ_DIR)/%.o: $(ADD_SOURCE_DIR)/%.f90 | add_code_build_directories
	@printf "%-${COL}s %-${COL}s" "Compiling additional library: " $* ; \
	CMD="$(F90C) $(FFLAGS) $(LAPACK_LINK)  $(LAPACK_INCLUDE) $(MODULE_FLAG)$(ADD_BUILD_INC_DIR) -c $(ADD_SOURCE_DIR)/$*.f90 -o $(ADD_BUILD_OBJ_DIR)/$*.o" ; \
	LOG="$$($${CMD} 2>&1 )" ; \
	if [ $$? -eq 1 ]; then \
        printf "%b%b" $(ERROR_STRING) "\n" ; \
        printf "%b%s" " $(Red)Command failing: $(Color_Off)" $${CMD} ; \
        printf "\n"; \
        printf "%b%s" " $(Red)Fail log: $(Color_Off)" "$${LOG}" ; \
        printf "\n"; \
        false ; \
    elif [ "$${LOG}" != "" ] ; then \
    	printf "%b%b" $(WARN_STRING) "\n" ; \
        printf "%b%s" " $(Orange)Command: $(Color_Off)" $${CMD} ; \
        printf "\n"; \
        printf "%b%s" " $(Orange)Warning log: $(Color_Off)" "$${LOG}" ; \
        printf "\n"; \
    else \
        printf "%b%b" $(OK_STRING) "\n"; \
    fi;
    
$(ADD_BUILD_OBJ_DIR)/%.o: $(ADD_SOURCE_DIR)/%.f | add_code_build_directories
	@printf "%-${COL}s %-${COL}s" "Compiling additional library: " $* ; \
	CMD="$(F90C) $(FFLAGS) $(LAPACK_LINK) $(LAPACK_INCLUDE) $(MODULE_FLAG)$(ADD_BUILD_INC_DIR) -c $(ADD_SOURCE_DIR)/$*.f -o $(ADD_BUILD_OBJ_DIR)/$*.o" ; \
	LOG="$$($${CMD} 2>&1 )" ; \
	if [ $$? -eq 1 ]; then \
        printf "%b%b" $(ERROR_STRING) "\n" ; \
        printf "%b%s" " $(Red)Command failing: $(Color_Off)" $${CMD} ; \
        printf "\n"; \
        printf "%b%s" " $(Red)Fail log: $(Color_Off)" "$${LOG}" ; \
        printf "\n"; \
        false ; \
    elif [ "$${LOG}" != "" ] ; then \
    	printf "%b%b" $(WARN_STRING) "\n" ; \
        printf "%b%s" " $(Orange)Command: $(Color_Off)" $${CMD} ; \
        printf "\n"; \
        printf "%b%s" " $(Orange)Warning log: $(Color_Off)" "$${LOG}" ; \
        printf "\n"; \
    else \
        printf "%b%b" $(OK_STRING) "\n"; \
    fi;
    
add_library: $(ADD_SOURCES_TARGETS) | add_code_build_directories
	@printf "%-${COL}s %-${COL}s" "Creating additional library : " $* ; \
	CMD="ar -r $(ADD_BUILD_LIB_DIR)/lib$@.a $(ADD_SOURCES_TARGETS)" ; \
	LOG="$$($${CMD} 2>&1 )" ; \
	if [ $$? -eq 1 ]; then \
        printf "%b%b" $(ERROR_STRING) "\n" ; \
        printf "%b%s" " $(Red)Command failing: $(Color_Off)" $${CMD} ; \
        printf "\n"; \
        printf "%b%s" " $(Red)Fail log: $(Color_Off)" "$${LOG}" ; \
        printf "\n"; \
        false ; \
    else \
        printf "%b%b" $(OK_STRING) "\n"; \
    fi \
    
all: add_library

################### documentation         ######################################

.PHONY: documentation

documentation:
	@cd $(DOC_DIR) && doxygen doxyfile

all: documentation
