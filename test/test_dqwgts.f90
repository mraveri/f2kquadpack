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
! This program tests the dqwgts function in both libraries
!

program test

    use f2k_header
    use f2k_test
    use f2k_error_handler

#ifdef OLD

#endif
#ifdef NEW
    use quadpack
#endif

    implicit none

    character ( len  = : ), allocatable :: arg
    integer   ( kind = 4 ) :: arg_length

#ifdef OLD
    real      ( kind = 8 ) :: dqwgts
    external               :: dqwgts
#endif

    real      ( kind = 8 ) :: x, a, b, alfa, beta, res, xmin, xmax
    integer   ( kind = 4 ) :: integr, ind, num_points

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
    call header( 'dqwgts tester' )

    ! start the test:
    call start_test( outroot = arg )

    ! initialize the arguments:
    a      = 0.d0
    b      = 1.d0
    alfa   = 1.d0
    beta   = 1.d0

    ! initialize the test:
    num_points = 100
    xmin       = -10.d0
    xmax       = +10.d0

    ! call the function for different arguments:

    integr = 0

    do ind=1, num_points
        x = xmin +REAL(ind-1)*(xmax-xmin)/REAL(num_points-1)
        res = dqwgts ( x, a, b, alfa, beta, integr )
        write( TEST_UNIT,* ) x, a, b, alfa, beta, integr, res
    end do

    integr = 1

    do ind=1, num_points
        x = xmin +REAL(ind-1)*(xmax-xmin)/REAL(num_points-1)
        res = dqwgts ( x, a, b, alfa, beta, integr )
        write( TEST_UNIT,* ) x, a, b, alfa, beta, integr, res
    end do

    integr = 2

    do ind=1, num_points
        x = xmin +REAL(ind-1)*(xmax-xmin)/REAL(num_points-1)
        res = dqwgts ( x, a, b, alfa, beta, integr )
        write( TEST_UNIT,* ) x, a, b, alfa, beta, integr, res
    end do

    integr = 3

    do ind=1, num_points
        x = xmin +REAL(ind-1)*(xmax-xmin)/REAL(num_points-1)
        res = dqwgts ( x, a, b, alfa, beta, integr )
        write( TEST_UNIT,* ) x, a, b, alfa, beta, integr, res
    end do

    ! end the test:
    call end_test()

    ! start the benchmark:

    ! end the benchmark:

end program test
