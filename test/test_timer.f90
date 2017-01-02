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
! This program tests the timer. It can be used as an example of the timer usage.
!

program test

    use f2k_header
    use f2k_timer

    implicit none

    type(timer) :: test_timer
    integer     :: ind

    ! print the header:
    call header( 'Timer tester' )
    ! start the timer:
    call test_timer%start()
    ! do some loops:
    do ind=1, 5
        ! feedback:
        print*, 'Loop', ind
        ! wait a bit:
        call test_timer%wait(1.d0)
        ! take the loop:
        call test_timer%loop()
    end do
    ! stop the timer:
    call test_timer%stop()
    ! print feedback:
    write(*,*)
    write(*,*) 'Total elapsed time    :', test_timer%elapsed_time() , '(s)'
    write(*,*) 'Mean loop time        :', test_timer%average()      , '(s)'
    write(*,*) 'Variance of loop time :', test_timer%variance()     , '(s)'
    ! reset the timer:
    call test_timer%reset()

end program test
