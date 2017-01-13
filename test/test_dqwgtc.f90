!----------------------------------------------------------------------------------------
!
! This file is part of f2kquadpack.
!
! Copyright (C) 2016-2017 by the f2kquadpack authors
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
! This program tests the dqwgtc function in both libraries
!

program test

    use f2k_header
    use f2k_test
    use f2k_error_handler

#ifdef OLD

#endif
#ifdef NEW

#endif

    implicit none

    character ( len  = : ), allocatable :: arg
    integer   ( kind = 4 ) :: arg_length

    ! process the command line to get the test output:
    call get_command_argument( 1, length = arg_length )
    !
    if ( arg_length > 0 ) then
        ! allocate the argument:
        allocate( character(len = arg_length ) :: arg )
        ! get the argument:
        call get_command_argument( 1, value = arg )
    else
        arg = ""
    end if

    ! print the header:
    call header( 'dqwgtc tester' )
    ! start the test:
    call start_test( outroot = arg )





    ! end the test:
    call end_test()

end program test
