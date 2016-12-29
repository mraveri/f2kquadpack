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
# This file contains part of the f2k build system: directory structure
#

# existing folders:

BASH_SCRIPT_DIR := $(PROJECT_DIR)/bash_script
NEW_SOURCE_DIR  := $(PROJECT_DIR)/source_new
OLD_SOURCE_DIR  := $(PROJECT_DIR)/source_old
ADD_SOURCE_DIR  := $(PROJECT_DIR)/source_additional
TEST_DIR        := $(PROJECT_DIR)/test

# build folders:

BUILD_DIR=$(PROJECT_DIR)/build

OLD_BUILD         := $(BUILD_DIR)/old_library
OLD_BUILD_OBJ_DIR := $(OLD_BUILD)/build
OLD_BUILD_INC_DIR := $(OLD_BUILD)/include
OLD_BUILD_LIB_DIR := $(OLD_BUILD)/lib
OLD_LIB_TEST      := $(OLD_BUILD)/test

NEW_BUILD         := $(BUILD_DIR)/new_library
NEW_BUILD_OBJ_DIR := $(NEW_BUILD)/build
NEW_BUILD_INC_DIR := $(NEW_BUILD)/include
NEW_BUILD_LIB_DIR := $(NEW_BUILD)/lib
NEW_LIB_TEST      := $(NEW_BUILD)/test

ADD_BUILD         := $(BUILD_DIR)/additional_library
ADD_BUILD_OBJ_DIR := $(ADD_BUILD)/build
ADD_BUILD_INC_DIR := $(ADD_BUILD)/include
ADD_BUILD_LIB_DIR := $(ADD_BUILD)/lib
