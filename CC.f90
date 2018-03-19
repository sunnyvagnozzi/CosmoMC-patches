!------------------------------------------------------------------------------------------!
! Module for cosmic chronometers (CC) likelihood                                           !
! CC use the differential evolution of passive early-type galaxies to estimate H(z) at     !
! various redshifts up to z~2 in a model-independent way                                   !
!                                                                                          !
! Reads the CC redshifts, measurements, and error bars, and calculates -Ln(Likelihood)     !
!                                                                                          !
! Currently written for being used with the compilation of 30 measurements of H(z) from    !
! Moresco et al., A 6% measurements of the Hubble parameter at z~0.45: direct evidence     !
! of the epoch of cosmic re-acceleration, JCAP 1605 (2016) no.05, 014 [arXiv: 1601.01701]  !
! Can be easily modified to use a different sample, see the README for more instructions   !
!                                                                                          !
! Module written by Sunny Vagnozzi 2018                                                    !
! Direct questions and report bugs to Sunny Vagnozzi (sunny.vagnozzi@fysik.su.se)          !
!                                                                                          !
!                                       v 1.0                                              !
!                                  Sunny Vagnozzi                                          !
!                            Last modified on 19/03/2018                                   !
!                                                                                          !
!------------------------------------------------------------------------------------------!

  module CC
    use settings
    use CosmologyTypes
    use CosmoTheory
    use Calculator_CAMB
    use Calculator_Cosmology
    use Likelihood_Cosmology
    use CAMB

    implicit none
    private

    real :: tmp1, tmp2, tmp3

    Type CCdata

      real,dimension(0:29) :: CCred
      real,dimension(0:29) :: CCmeas
      real,dimension(0:29) :: CCerr

    end Type CCdata

    Type(CCdata) :: CCset

    type, extends(TCosmoCalcLikelihood) :: CClikelihood
    contains
    procedure, nopass :: ReadCCdata
    procedure :: LogLike => CC_LnLike
    end type CCLikelihood

    public CCLikelihood, CCLikelihood_Add
    contains

    subroutine CCLikelihood_Add(LikeList, Ini)
    class(TLikelihoodList) :: LikeList
    class(TSettingIni) :: ini
    Type(CCLikelihood), pointer :: this

    if (Ini%Read_Logical('use_CC',.false.)) then
        allocate(this)
        this%LikelihoodType = 'CC'
        this%name= Ini%Read_String('CC_name')
        this%needs_background_functions = .true.
        call ReadCCdata()
        call LikeList%Add(this)
    end if

    end subroutine CCLikelihood_Add

 subroutine ReadCCdata()

   integer :: i, io
   character(len=80) data_file

   data_file = "data/CC_full.dat"

   write(*,*) "About to read cosmic chronometers data"

   do i=0, 29
      CCset%CCred(i) = 0.0
      CCset%CCmeas(i) = 0.0
      CCset%CCerr(i) = 0.0
   enddo

   open(9,file=data_file,status='old')
   io=0
   i=0
   do while (io.eq.0)
      read (9,*,iostat=io) tmp1,tmp2,tmp3
      if(io.ne.0) cycle
      CCset%CCred(i) = tmp1
      CCset%CCmeas(i) = tmp2
      CCset%CCerr(i) = tmp3
      i = i+1
   enddo
   close(9)

   write(*,*) "Read cosmic chonometers data"
!   write(*,*) "Ninth redshift, ninth H, ninth error", CCset%CCred(8), CCset%CCmeas(8), CCset%CCerr(8)

 end subroutine ReadCCdata

    real(mcp) function CC_LnLike(this, CMB, Theory, DataParams)
    Class(CCLikelihood) :: this
    Class(CMBParams) CMB
    Class(TCosmoTheoryPredictions), target :: Theory
    real(mcp) :: DataParams(:)
    real(mcp):: chisq
    real(dl) :: dtauda
    external dtauda
    integer :: j
    real(mcp) :: red, meas, err, teo

    chisq = 0.0

    do j=0, 29
       red = CCset%CCred(j)
       meas = CCset%CCmeas(j)
       err = CCset%CCerr(j)
       teo = this%Calculator%Hofz_Hunit(red)
!       write(*,*) "theory=", teo
!       write(*,*) "measurement=", meas
       chisq = chisq + ((teo-meas)**(2.0))/(err**(2.0))
    enddo

    CC_LnLike = chisq/2.0

    end function  CC_LnLike

  end module CC
