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
# This file contains part of the f2k build system: building and running tests
#

################### general test definitions ###################################

# get the test source files:
TEST_SOURCES := $(wildcard $(TEST_DIR)/*.f90)
# replace the extension:
TEST_SOURCES_TEMP_1 := $(basename $(TEST_SOURCES))
# remove the path:
TEST_NAMES := $(notdir $(TEST_SOURCES_TEMP_1))
# define the executable files:
TEST_SOURCES_FILES := $(addsuffix .x, $(TEST_NAMES))
# define the output files:
TEST_OUTPUT_FILES := $(addsuffix .out, $(TEST_NAMES))
# define the diff files:
TEST_DIFF_FILES := $(addsuffix .diff, $(TEST_NAMES))

# define the executable targets:
TEST_SOURCES_TARGETS :=
TEST_SOURCES_TARGETS += $(addprefix $(OLD_LIB_TEST)/, $(TEST_SOURCES_FILES))
TEST_SOURCES_TARGETS += $(addprefix $(NEW_LIB_TEST)/, $(TEST_SOURCES_FILES))
# define the test output targets:
OLD_TEST_OUTPUT_TARGETS += $(addprefix $(OLD_LIB_TEST)/, $(TEST_OUTPUT_FILES))
NEW_TEST_OUTPUT_TARGETS += $(addprefix $(NEW_LIB_TEST)/, $(TEST_OUTPUT_FILES))
# define the test diff targets:
NEW_TEST_DIFF_TARGETS += $(addprefix $(NEW_LIB_TEST)/, $(TEST_DIFF_FILES))

################### test build            ######################################

# compile all the test in the test directory against the two libraries:

# compile the test against the old library:
$(OLD_LIB_TEST)/%.x: $(TEST_DIR)/%.f90 | add_library old_library old_code_build_directories
	@printf "%-${COL}s %-${COL}s" "Compiling old library test: " $* ; \
	CMD="$(F90C) $(FFLAGS) $(TEST_DIR)/$*.f90 -L $(OLD_BUILD_LIB_DIR) -lold_library -L $(ADD_BUILD_LIB_DIR) -ladd_library $(LAPACK_LINK) -I $(OLD_BUILD_INC_DIR) -I $(ADD_BUILD_INC_DIR) $(LAPACK_INCLUDE) -o $(OLD_LIB_TEST)/$*.x" ; \
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
        false ; \
    else \
        printf "%b%b" $(OK_STRING) "\n"; \
    fi;
	
# compile the test against the new library:
$(NEW_LIB_TEST)/%.x: $(TEST_DIR)/%.f90 | add_library new_library new_code_build_directories
	@printf "%-${COL}s %-${COL}s" "Compiling new library test: " $* ; \
	CMD="$(F90C) $(FFLAGS) $(TEST_DIR)/$*.f90 -L $(NEW_BUILD_LIB_DIR) -lnew_library -L $(ADD_BUILD_LIB_DIR) -ladd_library $(LAPACK_LINK) -I $(NEW_BUILD_INC_DIR) -I $(ADD_BUILD_INC_DIR) $(LAPACK_INCLUDE) -o $(NEW_LIB_TEST)/$*.x" ; \
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
        false ; \
    else \
        printf "%b%b" $(OK_STRING) "\n"; \
    fi;
    
################### test run              ######################################

# global test targets:
.PHONY: run_test
run_test: run_old_test run_new_test

.PHONY: run_old_test
run_old_test: $(OLD_TEST_OUTPUT_TARGETS)

.PHONY: run_new_test
run_new_test: $(NEW_TEST_OUTPUT_TARGETS)

# test running targets:

# old library:
$(OLD_LIB_TEST)/%.out: $(OLD_LIB_TEST)/%.x
	@printf "%-${COL}s %-${COL}s" "Testing old library: " $*
	@$(OLD_LIB_TEST)/$*.x $(OLD_LIB_TEST)/output > $(OLD_LIB_TEST)/$*.log 2>&1 ; \
	if [ $$? -ne 0 ]; \
		then \
			printf "%b%b" $(ERROR_STRING) "\n"; \
			printf " Log file saved in: %s\n" $(OLD_LIB_TEST)/$*.log; \
		else \
			mv -f $(OLD_LIB_TEST)/output $(OLD_LIB_TEST)/$*.out > /dev/null 2>&1; \
			if [ $$? -ne 0 ]; \
				then printf "%b%b" $(WARN_STRING) ": output file not found \n"; \
			else printf "%b%b" $(OK_STRING) "\n"; \
			fi \
		fi

# new library:
$(NEW_LIB_TEST)/%.out: $(NEW_LIB_TEST)/%.x
	@printf "%-${COL}s %-${COL}s" "Testing new library: " $*
	@$(NEW_LIB_TEST)/$*.x $(NEW_LIB_TEST)/output > $(NEW_LIB_TEST)/$*.log 2>&1 ; \
	if [ $$? -ne 0 ]; \
		then \
			printf "%b%b" $(ERROR_STRING) "\n"; \
			printf " Log file saved in: %s\n" $(NEW_LIB_TEST)/$*.log; \
		else \
			mv -f $(NEW_LIB_TEST)/output $(NEW_LIB_TEST)/$*.out > /dev/null 2>&1; \
			if [ $$? -ne 0 ]; \
				then printf "%b%b" $(WARN_STRING) ": output file not found \n"; \
			else printf "%b%b" $(OK_STRING) "\n"; \
			fi \
		fi

################### compare test results  ######################################

compare_test_results: $(NEW_TEST_DIFF_TARGETS)

# run numdiff:
$(NEW_LIB_TEST)/%.diff: $(NEW_LIB_TEST)/%.out $(OLD_LIB_TEST)/%.out
	@printf "%-${COL}s %-${COL}s" "Comparing: " $*
	@numdiff $(NEW_LIB_TEST)/$*.out $(OLD_LIB_TEST)/$*.out > $(NEW_LIB_TEST)/$*.diff 2>&1 ; \
	if [ $$? -ne 0 ]; \
		then \
			printf "%b%b" $(ERROR_STRING) "\n"; \
			printf " Diff file saved in: %s\n" $(NEW_LIB_TEST)/$*.diff; \
		else \
			rm -rf $(NEW_LIB_TEST)/$*.diff; \
			if [ $$? -ne 0 ]; \
				then printf "%b%b" $(WARN_STRING) ": diff file not found \n"; \
			else \
				printf "%b%b" $(OK_STRING) "\n"; \
				touch $(NEW_LIB_TEST)/$*.diff; \
			fi \
		fi

################### general targets       ######################################

.PHONY: test
test: $(TEST_SOURCES_TARGETS)

.PHONY: clean_test
clean_test:
	@rm -rf $(NEW_LIB_TEST)/*.out $(OLD_LIB_TEST)/*.out

all: test run_test compare_test_results

