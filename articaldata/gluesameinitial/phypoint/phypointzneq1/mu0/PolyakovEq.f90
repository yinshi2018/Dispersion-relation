subroutine PolyakovEq(n, x, fvec)

  implicit none

  integer n
  real(8) x(n), fvec(n)                     !x(1)
  real(8) l,lb
  integer i,j
  integer npoint1, ii
  parameter(npoint1=256)
  real(8) w1(npoint1),y1(npoint1) !Guass integral
  integer npoint2
  parameter(npoint2=256)
  real(8) w2(npoint2),y2(npoint2) !Guass integral
  real(8) dr1dhA(npoint1),dr2dhA(npoint1),dr3dhA(npoint1),dr4dhA(npoint1),dr5dhA(npoint1)
  real(8) kA(npoint1),lam1A(npoint1),lam2A(npoint1),lam3A(npoint1),lam4A(npoint1),lam5A(npoint1),lam0A(npoint1),hA(npoint1)
  real(8) ZphilA(npoint1),ZphitA(npoint1),ZpsiA(npoint1),cA(npoint1),kappaA(npoint1),etaphilA(npoint1),etapsiA(npoint1)
  real(8) kk,lam1k,lam2k,lam3k,lam4k,lam5k,lam0k,hk,Zphik,Zpsik,ck,kappak,etaphilk,etaphitk,etapsik,rhok,etaphitA(npoint1)
  real(8) rho0k0,Zphilk0,Zphitk0,dr1dhk,dr2dhk,dr3dhk,dr4dhk,dr5dhk,Zphilk,Zphitk
  real(8) rho0
  real(8) pi,hc
  parameter(pi=3.1415926)
  parameter(hc=197.33)
  real(8) dtVd1l,dtVd1lb
  real(8) Vd1l_1,Vd1lb_1,Vd1l_2,Vd1lb_2,Vd1l_4,Vd1lb_4,Vd1l,Vd1lb
  real(8) T,mu
  real(8) a0,a1,a2,a3,a4,a5,b1,b2,b3,b4,c1,c2,c3,c4,c5,d1,d2,d3,d4,d5,T0,T_r,aPolya,cPolya,dPolya,bPolya


  common /y1w1/ y1, w1
  common /y2w2/ y2, w2
  common /flowconfi/ kA,lam1A,lam2A,lam3A,lam4A,lam5A,lam0A,hA,dr1dhA,dr2dhA,dr3dhA,dr4dhA,dr5dhA,ZphilA,ZphitA,ZpsiA,cA,&
                       kappaA,etaphilA,etaphitA,etapsiA
  common /rho0Zphi/ rho0k0,Zphilk0,Zphitk0
  common /Tmu/ T,mu


  l=x(1)
  lb=x(2)


  Vd1l_1=0.
  Vd1lb_1=0.
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
    etaphilk=etaphilA(ii)
    etaphitk=etaphitA(ii)
    etapsik=etapsiA(ii)

    rhok=rho0k0*Zphitk/Zphitk0

    call dtVdiff1(kk,lam0k,hk,dr1dhk,dr2dhk,dr3dhk,dr4dhk,dr5dhk,Zphilk,Zphitk,Zpsik,ck,kappak,etaphilk,etaphitk,etapsik &
                                   ,rhok,l,lb,dtVd1l,dtVd1lb)

    Vd1l_1=Vd1l_1+w1(ii)/kk*dtVd1l
    Vd1lb_1=Vd1lb_1+w1(ii)/kk*dtVd1lb

  end do

  Vd1l_2=0.
  Vd1lb_2=0.
  do ii=1, npoint2
    kk=y2(ii)

    call dtVdiff2(kk,l,lb,dtVd1l,dtVd1lb)

    Vd1l_2=Vd1l_2-w2(ii)/kk*dtVd1l
    Vd1lb_2=Vd1lb_2-w2(ii)/kk*dtVd1lb

  end do

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

  Vd1l_4=(-(b3*l**2)/2. - (b2*lb)/2. + (b4*l*lb**2)/2.)*T**4
  Vd1lb_4=(-(b2*l)/2. + (b4*l**2*lb)/2. - (b3*lb**2)/2.)*T**4
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  Vd1l=Vd1l_1+Vd1l_2+Vd1l_4
  Vd1lb=Vd1lb_1+Vd1lb_2+Vd1lb_4

  fvec(1)=Vd1l
  fvec(2)=Vd1lb

end





