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
p1chi2=np.loadtxt(r'gluesameinitial/fixpointz1/mu0/buffer/chi2.dat')
p1chi4=np.loadtxt(r'gluesameinitial/fixpointz1/mu0/buffer/chi4.dat')
p2chi2=np.loadtxt(r'gluesameinitial/fixpointzneq1/mu0/buffer/chi2.dat')
p2chi4=np.loadtxt(r'gluesameinitial/fixpointzneq1/mu0/buffer/chi4.dat')
p1r42=p1chi4 / p1chi2
p2r42=p2chi4 / p2chi2


# Create figure
fig=plt.figure(figsize=(4.5, 3.5))
#fig=plt.figure()
ax1=fig.add_subplot(111)
ax1.plot(p1r42,'b-',linewidth=1,markersize=5,label=r'$Z^{\|}_{\phi,k}=Z^{\bot}_{\phi,k}$')
line1,=ax1.plot(p2r42,'r--',linewidth=1,markersize=5,label=r'$Z^{\|}_{\phi,k}\neq Z^{\bot}_{\phi,k}$')
line1.set_dashes((10,2))

plt.text(250,0.5,r'$\mu_B=0MeV$')

ax1.axis([100,300,0,1.2])
#ax1.set_xscale('log')

ax1.set_xlabel('$T[\mathrm{MeV}]$', fontsize=14, color='black')
ax1.set_ylabel(r'$\kappa\sigma^2=\chi_4/\chi_2$', fontsize=14, color='black')

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


fig.savefig("kur.pdf")

#plt.show()
