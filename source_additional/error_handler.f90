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

!> @file error_handler.f90
!! This file contains a error handler that gives traceback informations.

!----------------------------------------------------------------------------------------
!> This module contains a error handler.

!> @author Marco Raveri
!> @todo   Can we get some inspiration from https://github.com/koenpoppe/ErrorHandlingInFortran2003 ?

module f2k_error_handler

    implicit none

    private

    !----------------------------------------------------------------------------------------
    ! Internal definitions:

    private :: abort
    interface
        subroutine abort() bind(C, name="abort")
        end subroutine
    end interface

    !----------------------------------------------------------------------------------------
    ! public definitions:
    public :: raise_error

    !----------------------------------------------------------------------------------------

contains

    ! ---------------------------------------------------------------------------------------------
    !> Subroutine that raises errors
    !!
    !! @author    Marco Raveri
    !! @date      02 January 2017
    !! @copyright GNU Public License v3
    !! @todo      Implement optional error unit to be passed by the user
    !!
    subroutine raise_error( error_message )

        implicit none

        character ( len = *  ), intent(in), optional :: error_message !< input error message

        ! if there is a message present print it:
        if ( present( error_message ) ) then
            write(*,*) error_message
        end if
        ! call abort function that prints traceback infos when compiled in debug mode:
        call abort()

    end subroutine raise_error

    ! ---------------------------------------------------------------------------------------------

end module f2k_error_handler
