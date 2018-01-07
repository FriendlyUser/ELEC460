# -*- coding: utf-8 -*-
"""
Created on Sun Dec 17 12:54:11 2017

@author: David Li
This script contains some of the plots I used for ELEC 460 Assignment 1, root locus, bode plots. Hopefully I will be able to save the ipython file and upload it to the web, worst case I'll figure something else out, or just convert my assignment to latex using pandoc and a nice template.
"""
from numpy import *
from pylab import * 
from control.matlab import *   
import time


ion()
## Get transfer function from G(s) = 1 * K / (s*(s+1)*(s+20)) when K = 1
#from sympy import *
import sympy as sympy
from sympy import init_printing
# %logstart -o
init_printing()
s = sympy.Symbol('s')  # Symbol, `a`, stored as variable
Gs = sympy.expand((s*(s+1)*(s+20))**-1)
print(Gs)


## Print out the root locus
# Root locus example
#m, k = 2, 0.5
sys = tf([1],[1,21,20,0])
rvect, kvect = rlocus(sys)

# Compute velocity error Kv
Kv = sympy.limit(s*Gs, s, 0)
print('The velocity error Kv is:')
print(Kv)

mag, phase, omega = bode(sys)

print('The velocity error Kv is:')
print(Kv)
real, imag, freq = nyquist(sys,labelFreq=10)
#==============================================================================
# rvect, kvect = rlocus(sys, klist = arange(0,10,0.001))
# close('all')
# clf()
# grid("on")
# xvect0 = array([real(r[0]) for r in rvect])
# yvect0 = array([imag(r[0]) for r in rvect])
# xvect1 = array([real(r[1]) for r in rvect])
# yvect1 = array([imag(r[1]) for r in rvect])
# plot([-100,100],[0,0],"k")
# plot([0,0],[-100,100],"k")
# plot(xvect0,yvect0,"m", linewidth = 3, label = "K= 0...10")
# plot(xvect1,yvect1,"m", linewidth = 3)
# plot(xvect0[0],yvect0[0],"xr",markeredgewidth=3,markersize=10,label = "K=0")
# plot(xvect1[0],yvect1[0],"xr",markeredgewidth=3,markersize=10)
# plot(xvect0[1000],yvect0[1000],"sc",markersize=10,label = "K=1")
# plot(xvect1[1000],yvect1[1000],"sc",markersize=10)
# plot(xvect0[5000],yvect0[5000],"pb",markersize=12,label = "K=5")
# plot(xvect1[5000],yvect1[5000],"pb",markersize=12)
# axis([-25,5,-8,8])
# xlabel("Real", fontsize = 20)
# ylabel("Imag", fontsize = 20)
# legend(loc=2 , prop={'size':18})
# axes().set_aspect("equal")
#==============================================================================
#savefig("figures/rlocusex.pdf")

#==============================================================================
# # Bode second order
# omegan = 10
# zeta1 = 0.1
# zeta2 = 0.8
# freq = logspace(-5,5,500)
# sys1 = tf([omegan*omegan],[1,2*zeta1*omegan,omegan*omegan])
# sys2 = tf([omegan*omegan],[1,2*zeta2*omegan,omegan*omegan])
# amp1, ang1, _ = bode(sys1,freq,Plot=False,dB=True,deg=False)
# amp2, ang2, _ = bode(sys2,freq,Plot=False,dB=True,deg=False)
# figure(0)
# clf()
# ax1 = subplot(211) 
# plot(freq,amp1,'r',linewidth=2,label="$\omega_n=10,\ \zeta=0.1$")
# plot(freq,amp2,'g--',linewidth=2,label="$\omega_n=10,\ \zeta=0.8$")
# plot([omegan,omegan],[-1000,1000],"k-.",linewidth=2)
# legend(loc=3,prop={'size':16})
# grid("on")
# xscale('log')
# ylabel("Gain (dB)", fontsize = 20)
# yticks(arange(-140,70,20))
# axis([freq[0],freq[-1],-100,40])
# ax2 = subplot(212,sharex=ax1)
# plot(freq,ang1,'r',linewidth=2)
# plot(freq,ang2,'g--',linewidth=2)
# plot([omegan,omegan],[-10,10],"k-.",linewidth=2)
# grid("on")
# ylabel("Phase shift (rad)", fontsize = 20)
# xlabel("Frequency (rad/s)", fontsize = 20)
# yticks([-pi,-pi/2,0],["$-\pi$","$-\pi/2$","$0$"])
# axis([freq[0],freq[-1],-pi-0.5,0.5])
# tight_layout()
#==============================================================================
