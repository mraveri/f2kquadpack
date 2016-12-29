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
# This file contains part of the f2k build system: folder creation and cleanup
#

# folder creation:

directories: \
	build_directory \
	old_code_build_directories \
	new_code_build_directories \
	add_code_build_directories

# create the build directories:
build_directory:
	@mkdir -p $(BUILD_DIR)

old_code_build_directories: build_directory
	@mkdir -p $(OLD_BUILD) $(OLD_BUILD_OBJ_DIR) $(OLD_BUILD_INC_DIR) $(OLD_BUILD_LIB_DIR) $(OLD_LIB_TEST)

new_code_build_directories: build_directory
	@mkdir -p $(NEW_BUILD) $(NEW_BUILD_OBJ_DIR) $(NEW_BUILD_INC_DIR) $(NEW_BUILD_LIB_DIR) $(NEW_LIB_TEST)

add_code_build_directories: build_directory
	@mkdir -p $(ADD_BUILD) $(ADD_BUILD_OBJ_DIR) $(ADD_BUILD_INC_DIR) $(ADD_BUILD_LIB_DIR)

# clean targets:

clean:
	@rm -rf $(BUILD_DIR)

clean_old_library:
	@rm -rf $(OLD_BUILD)
	
clean_new_library:
	@rm -rf $(NEW_BUILD)

clean_add_library:
	@rm -rf $(ADD_BUILD)
