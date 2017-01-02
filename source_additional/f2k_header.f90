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

!> @file f2k_header.f90
!! This file contains the subroutine that prints the f2k header to screen or other units.

!----------------------------------------------------------------------------------------
!> This module contains the subroutine that prints the f2k header to screen or other units.

!> @author Marco Raveri

module f2k_header

    use ISO_FORTRAN_ENV, only: OUTPUT_UNIT

    implicit none

    private

    !----------------------------------------------------------------------------------------
    ! definitions:

    character ( len = * ), public, parameter :: f2k_version = 'V0.0 Jan17'

    !----------------------------------------------------------------------------------------
    ! public definitions:
    public :: header

    !----------------------------------------------------------------------------------------

contains

    ! ---------------------------------------------------------------------------------------------
    !> Subroutine that prints the f2k header
    !!
    !! @author    Marco Raveri
    !! @date      02 January 2017
    !! @copyright GNU Public License v3
    !! @todo
    !!
    subroutine header( message, unit )

        implicit none

        character ( len  = * ), intent(in), optional :: message !< input message message
        integer   ( kind = 4 ), intent(in), optional :: unit    !< code for the output unit

        integer   ( kind = 4 ) :: temp_unit

        ! sort the output unit out:
        if ( present(unit) ) then
            temp_unit = unit
        else
            temp_unit = OUTPUT_UNIT
        end if
        ! write the header:
        write(temp_unit,'(a)') "***************************************************************"
        write(temp_unit,'(a)') "          __ ___ _    "
        write(temp_unit,'(a)') "         / _|_  ) |__ "
        write(temp_unit,'(a)') "        |  _|/ /| / / "
        write(temp_unit,'(a)') "        |_| /___|_\_\ "//" "//f2k_version
        write(temp_unit,'(a)') "  "
        write(temp_unit,'(a)') "***************************************************************"
        ! write the message if it is present:
        if ( present(message) ) then
            write(temp_unit,'(a)') " "//message
        end if
        ! end the header:
        write(temp_unit,'(a)') " This application was developed using the f2k library."
        write(temp_unit,'(a)') "***************************************************************"

    end subroutine header

    ! ---------------------------------------------------------------------------------------------

end module f2k_header
