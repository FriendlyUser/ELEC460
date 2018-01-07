# -*- coding: utf-8 -*-
"""
Created on Sun Dec 17 12:54:11 2017

@author: David Li
This script contains some of the plots I used for ELEC 460 Assignment 1, root locus, bode plots. Hopefully I will be able to save the ipython file and upload it to the web, worst case I'll figure something else out, or just convert my assignment to latex using pandoc and a nice template.
Use 
%logstart -o 
to start recording what I do, and then
ipython nbconvert --to latex notebook.ipynb
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
K=1
sys = tf([20*K],[1,21,20,0])
rvect, kvect = rlocus(sys)

# Compute velocity error Kv
Kv = sympy.limit(s*Gs, s, 0)
print('The velocity error Kv is:')
print(Kv)

mag, phase, omega = bode(sys)

print('The velocity error Kv is:')
print(Kv)
real, imag, freq = nyquist(sys,labelFreq=10)

## Compute new system with found gain, done in matlab, K = 0.479
K = 0.479
sys = tf([20*K],[1,21,20,0])
gm, pm, Wcg, Wcp = margin(sys)
print(gm)
print(pm)
## Plot step response
#step_response(sys,T=None, X0=0.0, input=0, output=None, return_x=False)
#ramp(sys)
##
