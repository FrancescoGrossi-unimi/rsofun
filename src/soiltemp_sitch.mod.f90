module md_soiltemp
  !////////////////////////////////////////////////////////////////
  ! Soil temperature based on LPJ (Sitch et al., 2003)
  !----------------------------------------------------------------
  use md_params_core

  implicit none

  private
  public soiltemp

contains

  subroutine soiltemp( soil, dtemp, doy )
    !/////////////////////////////////////////////////////////////////////////
    ! Calculates soil temperature (deg C) based on air temperature (deg C).
    !-------------------------------------------------------------------------
    use md_params_core, only: ndayyear, nlu, ndaymonth, pi
    use md_sofunutils, only: running
    use md_tile_pmodel, only: soil_type
    use md_interface_pmodel, only: myinterface

    ! arguments
    type( soil_type ), dimension(nlu), intent(inout) :: soil
    real, dimension(ndayyear), intent(in)            :: dtemp      ! daily temperature (deg C)
    integer, intent(in)                              :: doy        ! current day of year

    ! local variables
    real, dimension(:),   allocatable, save   :: dtemp_pvy    ! daily temperature of previous year (deg C)
    real, dimension(:,:), allocatable, save   :: wscal_pvy    ! daily Cramer-Prentice-Alpha of previous year (unitless) 
    real, dimension(:,:), allocatable, save   :: wscal_alldays

    integer :: pm ,ppm, lu, window_length

    real :: avetemp, meanw1
    real :: tempthismonth, templastmonth
    real :: diffus
    real :: alag, amp, lag, lagtemp

    ! in first year, use this years air temperature (available for all days in this year)
    if ( myinterface%steering%init .and. doy == 1 ) then
      if (.not.allocated(dtemp_pvy    )) allocate( dtemp_pvy(ndayyear) )
      if (.not.allocated(wscal_pvy    )) allocate( wscal_pvy(nlu,ndayyear) )
      if (.not.allocated(wscal_alldays)) allocate( wscal_alldays(nlu,ndayyear) )
      ! Note: in the first year, we use this year as previous year,
      ! meaning that the end of this year is used is if it was the end of last year.
      dtemp_pvy(:) = dtemp(:)
      wscal_pvy(:,:) = wscal_alldays(:,:)
    end if

    wscal_alldays(:,doy) = soil(:)%phy%wscal

    avetemp = running( dtemp, doy, ndayyear, "mean", dtemp_pvy(:) )

    ! get average temperature of the preceeding N days in month (30 days)
    window_length = 30
    tempthismonth = running( dtemp, doy, window_length, "mean", dtemp_pvy(:))
    templastmonth = running( dtemp, doy - window_length, window_length, "mean", dtemp_pvy(:))

    do lu=1,nlu
      !-------------------------------------------------------------------------
      ! recalculate running mean of previous 12 month's temperature and soil moisture
      ! avetemp stores running mean temperature of previous 12 months.
      ! meanw1 stores running mean soil moisture in layer 1 of previous 12 months 
      !-------------------------------------------------------------------------
      meanw1  = running( wscal_alldays(lu,:), doy, ndayyear, "mean", wscal_pvy(lu,:))

      ! In case of zero soil water, soil temp = air temp
      if (abs(meanw1 - 0.0) < eps) then
        soil(lu)%phy%temp = dtemp(doy)
        cycle
      endif

      ! Interpolate thermal diffusivity function against soil water content
      if (meanw1<0.15) then
        diffus = ( soil(lu)%params%thdiff_whc15 - soil(lu)%params%thdiff_wp ) / 0.15 &
                  * meanw1 + soil(lu)%params%thdiff_wp
      else
        diffus = ( soil(lu)%params%thdiff_fc - soil(lu)%params%thdiff_whc15 ) / 0.85 &
                  * ( meanw1 - 0.15 ) + soil(lu)%params%thdiff_whc15
      endif
          
      ! Convert diffusivity from mm2/s to m2/month
      ! multiplication by 1e-6 (-> m2/s) * 2.628e6 (s/month)  =  2.628
      diffus = diffus * 2.628

      ! Calculate amplitude fraction and lag at soil depth 0.25 m
      alag = 0.25 / sqrt( 12.0 * diffus / pi )
      amp  = exp(-alag)
      lag  = alag * ( 6.0 / pi )                                 !convert lag from angular units to months
          
      ! Calculate monthly soil temperatures for this year.  For each month,
      ! calculate average air temp for preceding 12 months (including this one)
          
      ! Estimate air temperature "lag" months ago by linear interpolation
      ! between air temperatures for this and last month
      lagtemp = ( tempthismonth - templastmonth ) * ( 1.0 - lag ) + templastmonth
          
      ! Adjust amplitude of lagged air temp to give estimated soil temp
      soil(lu)%phy%temp = avetemp + amp * ( lagtemp - avetemp )

    end do

    ! save temperature for next year
    if (doy == ndayyear) then
      dtemp_pvy(:) = dtemp(:)
      wscal_pvy(:,:) = wscal_alldays(:,:)
    end if

    ! free memory on the last simulation year and day
    if ( myinterface%steering%finalize .and. doy == ndayyear ) then
      if (allocated(dtemp_pvy    )) deallocate( dtemp_pvy )
      if (allocated(wscal_pvy    )) deallocate( wscal_pvy )
      if (allocated(wscal_alldays)) deallocate( wscal_alldays )
    end if    

  end subroutine soiltemp

  function air_to_soil_temp(dtemp, doy) result (soil_temp)
    !/////////////////////////////////////////////////////////////////////////
    ! Calculates soil temperature (deg C) based on air temperature (deg C).
    ! Convnience wrapper
    !-------------------------------------------------------------------------
    use md_tile_pmodel, only: soil_type, initglobal_soil

    ! arguments
    real, dimension(ndayyear), intent(in)            :: dtemp      ! daily temperature (deg C)
    integer, intent(in)                              :: doy        ! current day of year

    ! local variables
    type( soil_type ) :: soil

    call initglobal_soil( soil )

    call soiltemp(soil, dtemp, doy)

    soil_temp = soil%phy%temp

  end function air_to_soil_temp

end module md_soiltemp
