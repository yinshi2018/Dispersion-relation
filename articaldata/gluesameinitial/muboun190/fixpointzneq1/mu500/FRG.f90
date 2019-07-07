subroutine FRG(kappa_UV_i,kappa_UV,rho0,mPion,mSigma,mf,Vall,fpi,h,dr1dh,dr2dh,dr3dh,dr4dh,dr5dh,Zphil,Zphit,Zpsi,c,kappa)
!This subroutine solve FRG flow equations with fixed expansion point, search for phyiscal point, find
!appropriate expansion point. Inputing a guess kappa_UV_i, outputing kappa_UV and other physical variables

  implicit none

  integer Nv,Nh
! Nv: order of Tylor expansion for effective potential V, Nh: order of Yukawa coupling h
  parameter(Nv=7)
  parameter(Nh=5)
  integer Nz !number of wave function renormalizations
  parameter(Nz=3)
  integer Nck
  parameter(Nck=2)
  integer Nflow !number of flow equations
  parameter(Nflow=(Nv+1)+(Nh+1)+Nz+Nck)
  real(8) yflow(Nflow)
!dependent variables in flow equations
  integer N_str(4) !store the structure of functions of ODE
  real(8) pi,hc
  parameter(pi=3.1415926)
  parameter(hc=197.33)
  real(8) kappa_UV_i,kappa_UV
  real(8) T,mu
  real(8) k_UV,k_IR,t_UV,t_IR
  external derivs,rkqs
  real(8) eps_ode,h1,hmin !variables in subroutine odeint
  integer nok,nbad !variables in subroutine odeint
  INTEGER kmax,kount !variables in common block of subroutine odeint
  INTEGER KMAXX,NMAX
  PARAMETER (NMAX=50,KMAXX=200)
  real(8) dxsav,xp(KMAXX),yp(NMAX,KMAXX) !variables in common block of subroutine odeint
  real(8) rho0,mPion,mSigma,mf,Vall
  real(8) fpi,h,Zphil,Zphit,Zpsi,c,kappa,dr1dh,dr2dh,dr3dh,dr4dh,dr5dh
  integer i
  integer iT,iv
  real(8) l_com,lb_com


  common /strucFun/ N_str
  common /Tmu/ T,mu
  common /kRange/k_UV,k_IR,t_UV,t_IR
  common /odeContr/ eps_ode,h1,hmin
  COMMON /path/ kmax,kount,dxsav,xp,yp
  common /polyakov_com/ l_com,lb_com
  common /iTiv/ iT,iv


  N_str(1)=Nv
  N_str(2)=Nh
  N_str(3)=Nz
  N_str(4)=Nck

  k_UV=700./hc !in unit of fm**(-1)
  k_IR=0.01/hc   !in unit of fm**(-1)
  t_UV=0.
  t_IR=log(k_IR/k_UV)

  eps_ode=1.e-5
  h1=t_IR/200.
  hmin=0.
  kmax=KMAXX
  dxsav=t_IR/10000.


  kappa_UV=kappa_UV_i
  call expaPoint(Nflow,yflow,kappa_UV)
  call initial(Nflow,yflow,kappa_UV)
  call odeint(yflow,Nflow,t_UV,t_IR,eps_ode,h1,hmin,nok,nbad,derivs,rkqs)
  call phypoint2(Nflow,yflow,rho0,mPion,mSigma,mf,Vall)

  fpi=sqrt(2.*rho0)
  h=yflow((Nv+1)+1)
  dr1dh=yflow((Nv+1)+2)
  dr2dh=yflow((Nv+1)+3)
  dr3dh=yflow((Nv+1)+4)
  dr4dh=yflow((Nv+1)+5)
  dr5dh=yflow((Nv+1)+6)
  Zphil=yflow((Nv+1)+(Nh+1)+1)
  Zphit=yflow((Nv+1)+(Nh+1)+2)
  Zpsi=yflow((Nv+1)+(Nh+1)+3)
  c=yflow((Nv+1)+(Nh+1)+Nz+1)
  kappa=yflow((Nv+1)+(Nh+1)+Nz+2)



  goto 110

  open(unit=51,file='./buffer/Rkapparho0.dat',position='append')
  write(51, "(e21.14)")kappa/rho0
  close(51)


  write(*,"('kappa_UV=', f21.14)")kappa_UV
  write(*,"('kappa=', f21.14)")kappa
  write(*,"('rho0=', f21.14)")rho0
  write(*,"('fpi=', f21.14)")fpi*hc
  write(*,"('mPion=', f21.14)")mPion*hc
  write(*,"('mSigma=', f21.14)")mSigma*hc
  write(*,"('mf=', f21.14)")mf*hc


  open(unit=51,file='./buffer/rho0.dat')
  write(51, "(e20.9)")rho0
  close(51)

  open(unit=51,file='./buffer/mPion.dat')
  write(51, "(e20.9)")mPion*hc
  close(51)

  open(unit=51,file='./buffer/mSigma.dat')
  write(51, "(e20.9)")mSigma*hc
  close(51)

  open(unit=51,file='./buffer/mf.dat')
  write(51, "(e20.9)")mf*hc
  close(51)

  open(unit=51,file='./buffer/fpi.dat')
  write(51, "(e20.9)")fpi*hc
  close(51)




  open(unit=51,file='./buffer/yflow.dat')
  do i=1, Nflow
    write(51, "(e20.9)")yflow(i)
  end do
  close(51)

  open(unit=51,file='./buffer/t.dat')
  do i=1, kount
    write(51, "(e20.9)")xp(i)
  end do
  close(51)

  open(unit=51,file='./buffer/k.dat')
  do i=1, kount
    write(51, "(e20.9)")k_UV*exp(xp(i))*hc
  end do
  close(51)


  open(unit=51,file='./buffer/lam1.dat')
  do i=1, kount
    write(51, "(e20.9)")yp(1,i)
  end do
  close(51)

  open(unit=51,file='./buffer/lam2.dat')
  do i=1, kount
    write(51, "(e20.9)")yp(2,i)
  end do
  close(51)

  open(unit=51,file='./buffer/lam3.dat')
  do i=1, kount
    write(51, "(e20.9)")yp(3,i)
  end do
  close(51)

  open(unit=51,file='./buffer/lam4.dat')
  do i=1, kount
    write(51, "(e20.9)")yp(4,i)
  end do
  close(51)

  open(unit=51,file='./buffer/lam5.dat')
  do i=1, kount
    write(51, "(e20.9)")yp(5,i)
  end do
  close(51)

  open(unit=51,file='./buffer/lam6.dat')
  do i=1, kount
    write(51, "(e20.9)")yp(6,i)
  end do
  close(51)

  open(unit=51,file='./buffer/lam7.dat')
  do i=1, kount
    write(51, "(e20.9)")yp(7,i)
  end do
  close(51)

  open(unit=51,file='./buffer/lam0.dat')
  do i=1, kount
    write(51, "(e20.9)")yp(8,i)
  end do
  close(51)

  open(unit=51,file='./buffer/h.dat')
  do i=1, kount
    write(51, "(e20.9)")yp(9,i)
  end do
  close(51)

  open(unit=51,file='./buffer/Zphi.dat')
  do i=1, kount
    write(51, "(e20.9)")yp(12,i)
  end do
  close(51)

  open(unit=51,file='./buffer/Zpsi.dat')
  do i=1, kount
    write(51, "(e20.9)")yp(13,i)
  end do
  close(51)

  open(unit=51,file='./buffer/c.dat')
  do i=1, kount
    write(51, "(e20.9)")yp(14,i)
  end do
  close(51)

  open(unit=51,file='./buffer/kappa.dat')
  do i=1, kount
    write(51, "(e20.9)")yp(15,i)
  end do
  close(51)

  open(unit=51,file='./buffer/nok.dat')
  write(51, "(I4)")nok
  close(51)

  open(unit=51,file='./buffer/nbad.dat')
  write(51, "(I4)")nbad
  close(51)

  stop
110 continue

end


