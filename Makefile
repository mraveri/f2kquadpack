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
include $(MAKE_DIR)/compilers_options.make
include $(MAKE_DIR)/project_structure.make
include $(MAKE_DIR)/setup_cleanup.make

################### global targets      ########################################

all: \
	old_library \
	new_library \
	add_library \
	test \
	documentation

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
$(OLD_BUILD_OBJ_DIR)/%.o: $(OLD_SOURCE_DIR)/%.f90 old_code_build_directories
	$(F90C) $(FFLAGS) $(LAPACK_LINK)  $(LAPACK_INCLUDE) $(MODULE_FLAG)$(OLD_BUILD_INC_DIR) -c $(OLD_SOURCE_DIR)/$*.f90 -o $(OLD_BUILD_OBJ_DIR)/$*.o

$(OLD_BUILD_OBJ_DIR)/%.o: $(OLD_SOURCE_DIR)/%.f old_code_build_directories
	$(F90C) $(FFLAGS) $(LAPACK_LINK) $(LAPACK_INCLUDE) $(MODULE_FLAG)$(OLD_BUILD_INC_DIR) -c $(OLD_SOURCE_DIR)/$*.f -o $(OLD_BUILD_OBJ_DIR)/$*.o

old_library: $(OLD_SOURCES_TARGETS) old_code_build_directories
	ar -r $(OLD_BUILD_LIB_DIR)/lib$@.a $(OLD_SOURCES_TARGETS)

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

# compile the old library:
$(NEW_BUILD_OBJ_DIR)/%.o: $(NEW_SOURCE_DIR)/%.f90 new_code_build_directories
	$(F90C) $(FFLAGS) $(LAPACK_LINK)  $(LAPACK_INCLUDE) $(MODULE_FLAG)$(NEW_BUILD_INC_DIR) -c $(NEW_SOURCE_DIR)/$*.f90 -o $(NEW_BUILD_OBJ_DIR)/$*.o

$(NEW_BUILD_OBJ_DIR)/%.o: $(NEW_SOURCE_DIR)/%.f new_code_build_directories
	$(F90C) $(FFLAGS) $(LAPACK_LINK) $(LAPACK_INCLUDE) $(MODULE_FLAG)$(NEW_BUILD_INC_DIR) -c $(NEW_SOURCE_DIR)/$*.f -o $(NEW_BUILD_OBJ_DIR)/$*.o

new_library: $(NEW_SOURCES_TARGETS) new_code_build_directories
	ar -r $(NEW_BUILD_LIB_DIR)/lib$@.a $(NEW_SOURCES_TARGETS)

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

# compile the old library:
$(ADD_BUILD_OBJ_DIR)/%.o: $(ADD_SOURCE_DIR)/%.f90 add_code_build_directories
	$(F90C) $(FFLAGS) $(LAPACK_LINK)  $(LAPACK_INCLUDE) $(MODULE_FLAG)$(ADD_BUILD_INC_DIR) -c $(ADD_SOURCE_DIR)/$*.f90 -o $(ADD_BUILD_OBJ_DIR)/$*.o

$(ADD_BUILD_OBJ_DIR)/%.o: $(ADD_SOURCE_DIR)/%.f add_code_build_directories
	$(F90C) $(FFLAGS) $(LAPACK_LINK) $(LAPACK_INCLUDE) $(MODULE_FLAG)$(ADD_BUILD_INC_DIR) -c $(ADD_SOURCE_DIR)/$*.f -o $(ADD_BUILD_OBJ_DIR)/$*.o

add_library: $(ADD_SOURCES_TARGETS) add_code_build_directories
	ar -r $(ADD_BUILD_LIB_DIR)/lib$@.a $(ADD_SOURCES_TARGETS)

################### test build            ######################################

# compile all the test in the test directory against the two libraries:

# get the test source files:
TEST_SOURCES := $(wildcard $(TEST_DIR)/*.f90)
# replace the extension:
TEST_SOURCES_TEMP_1 := $(basename $(TEST_SOURCES))
# remove the path:
TEST_SOURCES_TEMP_2 := $(notdir $(TEST_SOURCES_TEMP_1))
# define the library files:
TEST_SOURCES_FILES := $(addsuffix .x, $(TEST_SOURCES_TEMP_2))
# define the targets:
TEST_SOURCES_TARGETS :=
TEST_SOURCES_TARGETS += $(addprefix $(OLD_LIB_TEST)/, $(TEST_SOURCES_FILES))
TEST_SOURCES_TARGETS += $(addprefix $(NEW_LIB_TEST)/, $(TEST_SOURCES_FILES))

# compile the test against the old library:
$(OLD_LIB_TEST)/%.x: $(TEST_DIR)/%.f90 old_code_build_directories add_library old_library
	$(F90C) $(FFLAGS) $(TEST_DIR)/$*.f90 -L $(OLD_BUILD_LIB_DIR) -lold_library -L $(ADD_BUILD_LIB_DIR) -ladd_library $(LAPACK_LINK) -I $(OLD_BUILD_INC_DIR) -I $(ADD_BUILD_INC_DIR) $(LAPACK_INCLUDE) -o $(OLD_LIB_TEST)/$*.x

# compile the test against the new library:
$(NEW_LIB_TEST)/%.x: $(TEST_DIR)/%.f90 new_code_build_directories add_library new_library
	$(F90C) $(FFLAGS) $(TEST_DIR)/$*.f90 -L $(NEW_BUILD_LIB_DIR) -lnew_library -L $(ADD_BUILD_LIB_DIR) -ladd_library $(LAPACK_LINK) -I $(NEW_BUILD_INC_DIR) -I $(ADD_BUILD_INC_DIR) $(LAPACK_INCLUDE) -o $(NEW_LIB_TEST)/$*.x

# global test targets:
.PHONY: test

test: $(TEST_SOURCES_TARGETS)

################### documentation         ######################################

.PHONY: documentation

documentation:
	@cd $(DOC_DIR) && doxygen doxyfile
