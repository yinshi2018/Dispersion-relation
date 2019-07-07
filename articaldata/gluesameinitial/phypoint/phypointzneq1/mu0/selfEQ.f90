subroutine selfEQ(kappa_UV_i,l_i,lb_i,kappa_UV,l,lb,rho0,mPion,mSigma,mf,Vtotal,fpi,h,dr1dh,dr2dh,dr3dh,dr4dh,dr5dh,&
                         Zphil,Zphit,Zpsi,c,kappa)
!This subroutine solve the FRG equation and the equation for the Polyakov loop self-consistently,
!Inputing guess kappa_UV_i,l_i,lb_i, outputing kappa_UV,l,lb and other physical variables

  implicit none
  real(8) kappa_UV_i,l_i,lb_i,kappa_UV,l,lb
  real(8) rho0,mPion,mSigma,mf,Vtotal,fpi,h,Zphil,Zphit,Zpsi,c,kappa,dr1dh,dr2dh,dr3dh,dr4dh,dr5dh
  real(8) l_new,lb_new,l_old,lb_old
  real(8) l_com,lb_com
  real(8) T,mu !temperature and chemical potential
  integer i,j
  integer jmax  !maximal number of loops
  parameter(jmax=600)
  INTEGER kmax,kount !variables in common block of subroutine odeint
  INTEGER KMAXX,NMAX
  PARAMETER (NMAX=50,KMAXX=200)
  real(8) dxsav,xp(KMAXX),yp(NMAX,KMAXX) !variables in common block of subroutine odeint
  real(8) x_bef(KMAXX),y_bef(KMAXX) !used for interpolation
  real(8) k_UV,k_IR,t_UV,t_IR
  real(8) epsi_l,epsi_lb,epsi_err
  logical stopp
  real(8) Vall,Vinfi,Vglue
  external PolyakovEq
  integer nn
  parameter(nn=2)
  real(8) x(nn)
  integer npoint1, ii
  parameter(npoint1=256)
  real(8) w1(npoint1),y1(npoint1) !Guass integral
  integer npoint2
  parameter(npoint2=256)
  real(8) w2(npoint2),y2(npoint2) !Guass integral
  real(8) x_aft(npoint1),y_aft(npoint1) !used for interpolation

  real(8) kA(npoint1),lam1A(npoint1),lam2A(npoint1),lam3A(npoint1),lam4A(npoint1),lam5A(npoint1),lam0A(npoint1)
  real(8) hA(npoint1),dr1dhA(npoint1),dr2dhA(npoint1),dr3dhA(npoint1),dr4dhA(npoint1),dr5dhA(npoint1)
  real(8) ZphilA(npoint1),ZphitA(npoint1),ZpsiA(npoint1),cA(npoint1),kappaA(npoint1)
  real(8) kk,lam1k,lam2k,lam3k,lam4k,lam5k,lam0k,hk,dr1dhk,dr2dhk,dr3dhk,dr4dhk,dr5dhk
  real(8) rho0k0,Zphilk0,Zphitk0
  real(8) a0,a1,a2,a3,a4,a5,b1,b2,b3,b4,c1,c2,c3,c4,c5,d1,d2,d3,d4,d5,T0,T_r,aPolya,cPolya,dPolya,bPolya
  real(8) etaphilA(npoint1),etaphitA(npoint1),etapsiA(npoint1),Zphilk,Zphitk,Zpsik,ck,kappak,etaphilk,etaphitk,etapsik
  logical check
  real(8) pi,hc
  parameter(pi=3.1415926)
  parameter(hc=197.33)
  real(8) k_infi


  COMMON /path/ kmax,kount,dxsav,xp,yp
  common /polyakov_com/ l_com,lb_com
  common /kRange/k_UV,k_IR,t_UV,t_IR
  common /y1w1/ y1, w1
  common /y2w2/ y2, w2
  common /flowconfi/ kA,lam1A,lam2A,lam3A,lam4A,lam5A,lam0A,hA,dr1dhA,dr2dhA,dr3dhA,dr4dhA,dr5dhA,ZphilA,ZphitA,ZpsiA,cA,&
                     kappaA,etaphilA,etaphitA,etapsiA
  common /rho0Zphi/ rho0k0,Zphilk0,Zphitk0
  common /Tmu/ T,mu


  epsi_err=1.e-10

  l_new=l_i
  lb_new=lb_i

  j=0                    !start of loops
  stopp=.false.
  do while((.not. stopp).and.(j < jmax))
    j=j+1

    l_old=l_new
    lb_old=lb_new

    l_com=l_old
    lb_com=lb_old

    call FRG(kappa_UV_i,kappa_UV,rho0,mPion,mSigma,mf,Vall,fpi,h,dr1dh,dr2dh,dr3dh,dr4dh,dr5dh,Zphil,Zphit,Zpsi,c,kappa)
    rho0k0=rho0
    Zphilk0=Zphil
    Zphitk0=Zphit

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!interpolation
    if(j==1)then
      call gauleg(k_UV, k_IR, y1, w1, npoint1)

      k_infi=k_UV*10.
      call gauleg(k_UV, k_infi, y2, w2, npoint2)
    end if


    do ii=1, npoint1
      x_aft(ii)=y1(ii)
      kA(ii)=x_aft(ii)
    end do

    do i=1, kount
      x_bef(i)=k_UV*exp(xp(i))
    end do

    do i=1, kount
      y_bef(i)=yp(1,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      lam1A(ii)=y_aft(ii)
    end do

    do i=1, kount
      y_bef(i)=yp(2,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      lam2A(ii)=y_aft(ii)
    end do

    do i=1, kount
      y_bef(i)=yp(3,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      lam3A(ii)=y_aft(ii)
    end do

    do i=1, kount
      y_bef(i)=yp(4,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      lam4A(ii)=y_aft(ii)
    end do

    do i=1, kount
      y_bef(i)=yp(5,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      lam5A(ii)=y_aft(ii)
    end do

    do i=1, kount
      y_bef(i)=yp(8,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      lam0A(ii)=y_aft(ii)
    end do

    do i=1, kount
      y_bef(i)=yp(9,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      hA(ii)=y_aft(ii)
    end do

    do i=1, kount
      y_bef(i)=yp(10,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      dr1dhA(ii)=y_aft(ii)
    end do

    do i=1, kount
      y_bef(i)=yp(11,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      dr2dhA(ii)=y_aft(ii)
    end do

    do i=1, kount
      y_bef(i)=yp(12,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      dr3dhA(ii)=y_aft(ii)
    end do

    do i=1, kount
      y_bef(i)=yp(13,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      dr4dhA(ii)=y_aft(ii)
    end do

    do i=1, kount
      y_bef(i)=yp(14,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      dr5dhA(ii)=y_aft(ii)
    end do


    do i=1, kount
      y_bef(i)=yp(15,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      ZphilA(ii)=y_aft(ii)
    end do

    do i=1, kount
      y_bef(i)=yp(16,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      ZphitA(ii)=y_aft(ii)
    end do

    do i=1, kount
      y_bef(i)=yp(17,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      ZpsiA(ii)=y_aft(ii)
    end do

    do i=1, kount
      y_bef(i)=yp(18,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      cA(ii)=y_aft(ii)
    end do

    do i=1, kount
      y_bef(i)=yp(19,i)
    end do
    call intLin(KMAXX,kount,npoint1,x_bef,y_bef,x_aft,y_aft)
    do ii=1, npoint1
      kappaA(ii)=y_aft(ii)
    end do

    do ii=1, npoint1
      kk=kA(ii)
      lam1k=lam1A(ii)
      lam2k=lam2A(ii)
      lam3k=lam3A(ii)
      lam4k=lam4A(ii)
      lam5k=lam5A(ii)
      lam0k=lam0A(ii)
      hk=hA(ii)
      dr1dhk=dr1dhA(ii)
      dr2dhk=dr2dhA(ii)
      dr3dhk=dr3dhA(ii)
      dr4dhk=dr4dhA(ii)
      dr5dhk=dr5dhA(ii)
      Zphilk=ZphilA(ii)
      Zphitk=ZphitA(ii)
      Zpsik=ZpsiA(ii)
      ck=cA(ii)
      kappak=kappaA(ii)

      call eta(kk,lam1k,lam2k,lam3k,lam4k,lam5k,lam0k,hk,dr1dhk,dr2dhk,dr3dhk,dr4dhk,dr5dhk,Zphilk,Zphitk       &
                            ,Zpsik,ck,kappak,etaphilk,etaphitk,etapsik)

      etaphilA(ii)=etaphilk
      etaphitA(ii)=etaphitk
      etapsiA(ii)=etapsik

!      etaphiA(ii)=0.
!      etapsiA(ii)=0.

    end do
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    x(1)=l_com
    x(2)=lb_com
    call newt(x, nn, check, PolyakovEq)
    l_new=x(1)
    lb_new=x(2)

    epsi_l=abs(l_new-l_old)/abs(l_new)
    epsi_lb=abs(lb_new-lb_old)/abs(lb_new)

!    if(epsi_l<epsi_err.and.epsi_lb<epsi_err.and.j>=4)then
    if(epsi_l<epsi_err.and.epsi_lb<epsi_err)then
      stopp=.true.                                           !循环控制
    end if

   write(*,"('polya loop number=', I4)")j
   write(*,"('epsi_l=', e20.9)")epsi_l
   write(*,"('epsi_lb=', e20.9)")epsi_lb
   write(*,"('l_old=', f15.12)")l_old
   write(*,"('l_new=', f15.12)")l_new

  end do

  l=l_old
  lb=lb_old

  l_com=l
  lb_com=lb

  call vInf(k_UV,Vinfi)

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!glue potential
  a0=6.75
  a1=-1.95
  a2=2.625
  a3=-7.44

  b3=0.75
  b4=7.5

  T0=208./hc

  T_r=0.57*(T-T0)/T0

  b2=a0+a1/(1.+T_r)+a2/(1.+T_r)**2+a3/(1.+T_r)**3

  Vglue=(-(b2*l*lb)/2. + (b4*l**2*lb**2)/4. - (b3*(l**3 + lb**3))/6.)*T**4
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  Vtotal=Vall+Vinfi+Vglue

end







