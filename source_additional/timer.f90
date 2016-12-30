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

!> @file timer.f90
!! This file contains a quality timer class to benchmark applications.

!----------------------------------------------------------------------------------------
!> This module contains a quality timer class to benchmark applications.

!> @author Marco Raveri

module f2k_timer

    implicit none

    private

    public timer

    !----------------------------------------------------------------------------------------
    ! Internal definitions:

    integer, parameter :: allocated_num_loops = 50 ! number of elements to allocate temporarily arrays. If length exceeds this number then another chunk of this length is allocated.

    !----------------------------------------------------------------------------------------
    !> This is the main timer class. The timer works in seconds.
    type :: timer

        real    ( kind=8 ), public :: start_time          !< timer begin time
        real    ( kind=8 ), public :: end_time            !< timer end time

        integer ( kind=4 ), public :: number_loops        !< number of timer loops

        real    ( kind=8 ), public, allocatable, dimension(:) :: loop_times !< array containing the time intervals of all the loops

        real    ( kind=8 ), private :: internal_start_time !< internal timer cache
        real    ( kind=8 ), private :: internal_end_time   !< internal timer cache

    contains

        procedure :: start        => timer_start    !< subroutine that starts the timer.
        procedure :: stop         => timer_stop     !< subroutine that stops the timer.
        procedure :: loop         => timer_loop     !< subroutine that records intermediate times (loops).
        procedure :: average      => timer_average  !< function that gives the average loop time.
        procedure :: variance     => timer_variance !< function that gives the variance of the loop time.
        procedure :: elapsed_time => timer_elapsed  !< function that returns the elapsed time, defined as (end_time-start_time)
        procedure :: reset        => timer_reset    !< subroutine that resets the timer.
        procedure :: wait         => timer_wait     !< subroutine that waits a number of seconds.
        procedure :: time         => timer_time     !< function that takes the time.

    end type timer

contains

    ! ---------------------------------------------------------------------------------------------
    !> Subroutine that starts the timer.
    subroutine timer_start( self )

        implicit none

        class( timer ) :: self !< the base class

        ! first reset the timer:
        call self%reset()
        ! then start the timer:
        self%start_time = self%time()

    end subroutine timer_start

    ! ---------------------------------------------------------------------------------------------
    !> Subroutine that stops the timer.
    subroutine timer_stop( self )

        implicit none

        class( timer ) :: self !< the base class

        ! stop the timer:
        self%end_time = self%time()

    end subroutine timer_stop

    ! ---------------------------------------------------------------------------------------------
    !> Subroutine that records intermediate times (loops).
    subroutine timer_loop( self )

        implicit none

        class( timer ) :: self !< the base class

        integer ( kind=4 ) :: temp_size, ind
        real    ( kind=8 ), allocatable, dimension(:) :: temp_loop_times

        ! take the time:
        self%internal_end_time = self%time()
        ! increase by one the number of loops:
        self%number_loops = self%number_loops +1
        ! check the allocation of the loop array:
        if ( .not. allocated( self%loop_times ) ) then
            allocate( self%loop_times(allocated_num_loops ) )
            self%loop_times = 0.0d0
        end if
        ! get the length of the loop array:
        temp_size = size(self%loop_times)
        ! reallocate the loop array if needed:
        if ( self%number_loops > temp_size ) then
            ! allocate a temporary array:
            allocate( temp_loop_times(temp_size) )
            ! copy the timing array on the temporary one:
            temp_loop_times = self%loop_times
            ! deallocate the loop array and reallocate it:
            deallocate( self%loop_times )
            allocate( self%loop_times( (self%number_loops/allocated_num_loops+1)*allocated_num_loops ) )
            self%loop_times = 0.0d0
            ! copy the time data:
            do ind=1, self%number_loops-1
                self%loop_times(ind) =  temp_loop_times(ind)
            end do
        end if
        ! store the time:
        if ( self%number_loops==1 ) then
            self%loop_times(self%number_loops) = self%internal_end_time -self%start_time
        else
            self%loop_times(self%number_loops) = self%internal_end_time -self%internal_start_time
        end if
        ! restart the timer:
        self%internal_start_time = self%time()

    end subroutine timer_loop

    ! ---------------------------------------------------------------------------------------------
    !> Function that gives the average loop time.
    function timer_average( self )

        implicit none

        class( timer  ) :: self           !< the base class
        real ( kind=8 ) :: timer_average  !< the output loop average time

        integer ( kind=4 ) :: ind

        ! initialize:
        timer_average = 0.0d+0
        ! accumulate time measurements:
        do ind=1, self%number_loops
            timer_average = timer_average +self%loop_times(ind)
        end do
        ! compute and return the average:
        timer_average = timer_average/REAL(self%number_loops)

    end function timer_average

    ! ---------------------------------------------------------------------------------------------
    !> Function that gives the variance of the loop time.
    function timer_variance( self )

        implicit none

        class( timer  ) :: self           !< the base class
        real ( kind=8 ) :: timer_variance !< the output variance of the loop times

        real    ( kind=8 ) :: average_time
        integer ( kind=4 ) :: ind

        ! initialize:
        timer_variance = 0.0d+0
        ! compute the variance:
        if ( self%number_loops>1 ) then
            average_time = self%average()
            do ind=1, self%number_loops
                timer_variance = timer_variance +( self%loop_times(ind) -average_time )**2
            end do
            timer_variance = sqrt( timer_variance/REAL(self%number_loops-1) )
        end if

    end function timer_variance

    ! ---------------------------------------------------------------------------------------------
    !> Function that returns the elapsed time, defined as (end_time-start_time)
    function timer_elapsed( self )

        implicit none

        class(timer)    :: self          !< the base class
        real ( kind=8 ) :: timer_elapsed !< the total elapsed time

        timer_elapsed = self%end_time -self%start_time

    end function timer_elapsed

    ! ---------------------------------------------------------------------------------------------
    !> Subroutine that resets the timer.
    subroutine timer_reset( self )

        implicit none

        class(timer)    :: self !< the base class

        self%start_time   = 0.0d+0
        self%end_time     = 0.0d+0

        self%number_loops = 0

        self%internal_start_time = 0.0d+0
        self%internal_end_time   = 0.0d+0

        if ( allocated( self%loop_times ) ) deallocate( self%loop_times )

    end subroutine timer_reset

    ! ---------------------------------------------------------------------------------------------
    !> Subroutine that waits a number of seconds.
    subroutine timer_wait( self, time )

        implicit none

        class( timer  )             :: self !< the base class
        real ( kind=8 ), intent(in) :: time !< the input number of seconds to wait

        real( kind=8 ) :: start_time, elapsed_time

        start_time = self%time()
        do
            elapsed_time = self%time() -start_time
            if ( elapsed_time > time ) return
        end do

    end subroutine timer_wait

    ! ---------------------------------------------------------------------------------------------
    !> Function that takes the time.
    function timer_time( self )

        implicit none

        class(timer)    :: self        !< the base class
        real ( kind=8 ) :: timer_time  !< the return value

        call CPU_TIME(timer_time)

    end function timer_time

    ! ---------------------------------------------------------------------------------------------

end module f2k_timer
