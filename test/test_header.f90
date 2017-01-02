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

!
! This program tests the f2k header
!

program test

    use f2k_header
    use ISO_FORTRAN_ENV, only: OUTPUT_UNIT

    implicit none

    ! print the header without anything:
    call header( )
    ! print the header with a message:
    call header( 'Just testing the header' )
    ! print the header to a specific unit:
    call header( 'Just testing the header with output unit', unit=OUTPUT_UNIT )

end program test
