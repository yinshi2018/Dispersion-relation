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
mf1=np.loadtxt(r'gluesameinitial/fixpointz1/mu0/buffer/mf.dat')
mf2=np.loadtxt(r'gluesameinitial/fixpointzneq1/mu0/buffer/mf.dat')

mp1=np.loadtxt(r'gluesameinitial/fixpointz1/mu0/buffer/mPion.dat')
mp2=np.loadtxt(r'gluesameinitial/fixpointzneq1/mu0/buffer/mPion.dat')

ms1=np.loadtxt(r'gluesameinitial/fixpointz1/mu0/buffer/mSigma.dat')
ms2=np.loadtxt(r'gluesameinitial/fixpointzneq1/mu0/buffer/mSigma.dat')





# Create figure
fig=plt.figure(figsize=(4.5, 3.5))
#fig=plt.figure()
ax1=fig.add_subplot(111)

ax1.plot(mp1,'k-',linewidth=1,markersize=5,label=r'$Z^{\|}_{\phi}=Z^{\bot}_{\phi}$')
ax1.plot(mp2,'r--',linewidth=1,markersize=5,label=r'$Z^{\|}_{\phi}\neq Z^{\bot}_{\phi}$')
#ax1.plot(mf3,'k:',linewidth=2,markersize=5,label=r'$m_{q}\,h_k(\rho)\,Z^{\|}_{\phi}=Z^{\bot}_{\phi}\,phypoint$')
#ax1.plot(mf4,'r-',linewidth=1,markersize=5,label=r'$m_{q}\,h_k(\rho)\,Z^{\|}_{\phi}\neq Z^{\bot}_{\phi}\,phypoint$')

ax1.plot(mf1,'k-',linewidth=1,markersize=5)#,label=r'$m_q\,h_k\,Z^{\|}_{\phi}=Z^{\bot}_{\phi}\,fixpoint$')
ax1.plot(mf2,'r--',linewidth=1,markersize=5)#,label=r'$m_{\pi}\,h_k\,Z^{\|}_{\phi}\neq Z^{\bot}_{\phi}\,fixpoint$')
#ax1.plot(mf7,'b:',linewidth=2,markersize=5,label=r'$m_{q}\,h_k\,Z^{\|}_{\phi}\neq Z^{\bot}_{\phi}\,fixpoint$')
#ax1.plot(mf8,'y-',linewidth=1,markersize=5,label=r'$m_{q}\,h_k\,Z^{\|}_{\phi}\neq Z^{\bot}_{\phi}\,phypoint$')
ax1.plot(ms1,'k-',linewidth=1,markersize=5)#,label=r'$m_q\,h_k\,Z^{\|}_{\phi}=Z^{\bot}_{\phi}\,fixpoint$')
ax1.plot(ms2,'r--',linewidth=1,markersize=5)#,label=r'$m_{\pi}\,h_k\,Z^{\|}_{\phi}\neq Z^{\bot}_{\phi}\,fixpoint$')
plt.text(25,460,r'$m_{\sigma}$')
plt.text(25,320,r'$m_{q}$')
plt.text(25,170,r'$m_{\pi}$')
#plt.text(200,530,r'$fix\,\,\,point$')
#plt.text(10,600,r'$field\,\,\,denpend\,\,\,h_k(\rho)$')

ax1.axis([0,300,0,700])
#ax1.set_xscale('log')

ax1.set_xlabel('$T[\mathrm{MeV}]$', fontsize=14, color='black')
ax1.set_ylabel(r'$m[\mathrm{MeV}]$', fontsize=14, color='black')

ax1.legend(loc=0,fontsize='x-small',frameon=False,shadow=True,handlelength=3.,borderpad=0.5,borderaxespad=1)

for label in ax1.xaxis.get_ticklabels():
    label.set_fontsize(10)
for label in ax1.yaxis.get_ticklabels():
    label.set_fontsize(10)



#for ax in fig.axes:
#    ax.grid(True)

# Format the minor tick labels of the y-axis into empty strings with
# `NullFormatter`, to avoid cumbering the axis with too many labels.
#plt.gca().yaxis.set_minor_formatter(NullFormatter())
# Adjust the subplot layout, because the logit one may take more space
# than usual, due to y-tick labels like "1 - 10^{-3}"
fig.subplots_adjust(top=0.9, bottom=0.15, left=0.15, right=0.95, hspace=0.35,
                    wspace=0.35)


fig.savefig("m.pdf")

#plt.show()
