module m_iniens
use mod_inistat
use mod_xyqgrid
use m_getcaseid
use m_normal
use m_func
use m_tecmargpdf
use m_moments
implicit none
contains
subroutine iniens(samples,xf,qf,yf,dpert,nrsamp)
   integer, intent(in)   :: nrsamp
   real,    intent(out)  :: xf(nrsamp),qf(nrsamp),yf(nrsamp),dpert(nrsamp)
   real,    intent(out)  :: samples(nrsamp,2)

   real avex,adevx,sdevx,varx,skewx,kurtx
!   character(len=40) caseid
   integer i

   do i=1,nrsamp
      xf(i)=siga*normal()
   enddo
   call moments(xf,nrsamp,avex,adevx,sdevx,varx,skewx,kurtx)
   do i=1,nrsamp
      xf(i)=xf(i)-avex
   enddo

   do i=1,nrsamp
      qf(i)=sigw*normal()
   enddo
   call moments(qf,nrsamp,avex,adevx,sdevx,varx,skewx,kurtx)
   do i=1,nrsamp
      qf(i)=qf(i)-avex
   enddo

   do i=1,nrsamp
      xf(i)=x0+xf(i)
      yf(i)=func(xf(i),qf(i)) 
   enddo

   do i=1,nrsamp
      dpert(i)=d+sigo*normal()
   enddo
   print '(a)','Sampling done'
   samples(:,1)=xf(:)
   samples(:,2)=qf(:)

end subroutine
end module
