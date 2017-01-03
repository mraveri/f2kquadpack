!----------------------------------------------------------------------------------------
!
! This file is part of f2k.
!
! Copyright (C) 2016-2017 by the f2k authors
!
! The f2k code is free software;
! You can use it, redistribute it, and/or modify it under the terms
! of the GNU General Public License as published by the Free Software Foundation;
! either version 3 of the License, or (at your option) any later version.
! The full text of the license can be found in the file LICENSE at
! the top level of the f2k distribution.
!
!----------------------------------------------------------------------------------------

!> @file f2k_tester.f90
!! This file contains a couple of utilities that are used to run the f2k tests.

!----------------------------------------------------------------------------------------
!> This module contains a couple of utilities that are used to run the f2k tests.

!> @author Marco Raveri

module f2k_test

    implicit none

    private

    !----------------------------------------------------------------------------------------
    ! Internal definitions:

    !----------------------------------------------------------------------------------------
    ! public definitions:
    integer ( kind = 4 ), public :: test_unit = 666
    public :: start_test, end_test

    !----------------------------------------------------------------------------------------

contains

    ! ---------------------------------------------------------------------------------------------
    !> Subroutine that starts the test environment
    !!
    !! @author    Marco Raveri
    !! @date      03 January 2017
    !! @copyright GNU Public License v3
    !! @todo
    !!
    subroutine start_test( outroot )

        implicit none

        character ( len = * ), intent(in), optional :: outroot  !< output root for the test file. If not passed the running directory is assumed and the name is assumed to be "output".

        character ( len = : ), allocatable :: root

        ! check for the presence of an output path:
        if ( present( outroot ) ) then
            root = ADJUSTL( TRIM( outroot ) )
        else
            root = 'output'
        end if
        ! open the test output file:
        open( UNIT = test_unit, FILE=root, STATUS='REPLACE', ACTION='WRITE' )

    end subroutine start_test

    ! ---------------------------------------------------------------------------------------------
    !> Subroutine that ends the test environment
    !!
    !! @author    Marco Raveri
    !! @date      03 January 2017
    !! @copyright GNU Public License v3
    !! @todo
    !!
    subroutine end_test( )

        implicit none

        ! close the test output file:
        close( UNIT = test_unit )

    end subroutine end_test

    ! ---------------------------------------------------------------------------------------------

end module f2k_test
