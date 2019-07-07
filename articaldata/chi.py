#!/usr/bin/env python
# -*- coding: utf-8 -*-
# sphinx_gallery_thumbnail_number = 3

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.ticker import NullFormatter  # useful for `logit` scale
import matplotlib.ticker as ticker
import matplotlib as mpl

mpl.style.use('classic')


# Data for plotting

chi1mu500=np.loadtxt(r'gluesameinitial/fixpointz1/mu500/buffer/chi1.dat')
chi2mu500=np.loadtxt(r'gluesameinitial/fixpointz1/mu500/buffer/chi2.dat')
chi3mu500=np.loadtxt(r'gluesameinitial/fixpointz1/mu500/buffer/chi3.dat')
chi4mu500=np.loadtxt(r'gluesameinitial/fixpointz1/mu500/buffer/chi4.dat')


nchi1mu500=np.loadtxt(r'gluesameinitial/fixpointzneq1/mu500/buffer/chi1.dat')
nchi2mu500=np.loadtxt(r'gluesameinitial/fixpointzneq1/mu500/buffer/chi2.dat')
nchi3mu500=np.loadtxt(r'gluesameinitial/fixpointzneq1/mu500/buffer/chi3.dat')
nchi4mu500=np.loadtxt(r'gluesameinitial/fixpointzneq1/mu500/buffer/chi4.dat')



fig=plt.figure(figsize=(9, 7))
ax1=fig.add_subplot(221)


ax1.plot(chi1mu500,color='orange',linestyle='-',linewidth=2,markersize=5,label=r'$Z^{\bot}_{\phi,k}=Z^{\|}_{\phi,k}$')


line13,=ax1.plot(nchi1mu500,color='fuchsia',linestyle='--',linewidth=2,markersize=5,label=r'$Z^{\bot}_{\phi,k}\neq Z^{\|}_{\phi,k}$')
line13.set_dashes((10,2))



plt.text(150,0.1,'$\mu_B=500MeV$',fontsize=20)

ax1.axis([0,300,-0.01,0.6])

ax1.set_xlabel('$T\,[\mathrm{MeV}]$', fontsize=15, color='black')
ax1.set_ylabel(r'$\chi_1$', fontsize=15, color='black')

ax1.legend(loc=2,fontsize=7.3,frameon=False,shadow=True,handlelength=3.,borderpad=0,borderaxespad=0.3)



for label in ax1.xaxis.get_ticklabels():
    label.set_fontsize(10)
for label in ax1.yaxis.get_ticklabels():
    label.set_fontsize(10)



ax2=fig.add_subplot(222)


ax2.plot(chi2mu500,color='orange',linestyle='-',linewidth=2,markersize=5)

line23,=ax2.plot(nchi2mu500,color='fuchsia',linestyle='--',linewidth=2,markersize=5)
line23.set_dashes((10,2))



ax2.axis([0,300,-0.01,0.7])

ax2.set_xlabel('$T\,[\mathrm{MeV}]$', fontsize=15, color='black')
ax2.set_ylabel(r'$\chi_2$', fontsize=15, color='black')
#ax2.legend(loc=0,fontsize=10,frameon=False,shadow=True,handlelength=3.,borderpad=0.5,borderaxespad=1)

for label in ax2.xaxis.get_ticklabels():
    label.set_fontsize(10)
for label in ax2.yaxis.get_ticklabels():
    label.set_fontsize(10)

ax3=fig.add_subplot(223)



line34,=ax3.plot(chi3mu500,color='orange',linestyle='-',linewidth=2,markersize=5)#,label=r'$Z^{\bot}_{\phi,k}=Z^{\|}_{\phi,k}$')

line33,=ax3.plot(nchi3mu500,color='fuchsia',linestyle='--',linewidth=2,markersize=5)#,label=r'$Z^{\bot}_{\phi,k}\neq Z^{\|}_{\phi,k}$')
line33.set_dashes((10,2))



ax3.axis([0,300,-0.2,1.2])


ax3.set_xlabel('$T\,[\mathrm{MeV}]$', fontsize=15, color='black')
ax3.set_ylabel(r'$\chi_3$', fontsize=15, color='black')



for label in ax3.xaxis.get_ticklabels():
    label.set_fontsize(10)
for label in ax3.yaxis.get_ticklabels():
    label.set_fontsize(10)



ax4=fig.add_subplot(224)



line42,=ax4.plot(chi4mu500,color='orange',linestyle='-',linewidth=2,markersize=5)#,label=r'$Z^{\bot}_{\phi,k}=Z^{\|}_{\phi,k}$')

line43,=ax4.plot(nchi4mu500,color='fuchsia',linestyle='--',linewidth=2,markersize=5)#,label=r'$Z^{\bot}_{\phi,k}\neq Z^{\|}_{\phi,k}$')
line43.set_dashes((10,2))



ax4.axis([0,300,-2.5,2.6])

ax4.set_xlabel('$T\,[\mathrm{MeV}]$', fontsize=15, color='black')
ax4.set_ylabel(r'$\chi_4$', fontsize=15, color='black')
#ax4.legend(loc=2,fontsize=7.3,frameon=False,shadow=True,handlelength=3.,borderpad=0.5,borderaxespad=1)

for label in ax4.xaxis.get_ticklabels():
    label.set_fontsize(10)
for label in ax4.yaxis.get_ticklabels():
    label.set_fontsize(10)

fig.subplots_adjust(top=0.9, bottom=0.15, left=0.1, right=0.95, hspace=0.35,
                    wspace=0.2)
                   

fig.savefig("chi.pdf")

#plt.show()
