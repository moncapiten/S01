import tdwf
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

# initialization of the instrument
ad2 = tdwf.AD2()

# initialization of the waveform generatro
gen = tdwf.WaveGen(ad2.hdwf)
'''
gen.w1.fun = tdwf.funcDC
gen.w1.offs = 2

'''
gen.w1.func = tdwf.funcSine
gen.w1.freq = 1000
gen.w1.ampl = 2
gen.w1.offs = 0



# initializatin of the two scopes
scope = tdwf.Scope(ad2.hdwf)

#scope.trig(True)
scope.fs = 1e6
scope.npt = 8192

scope.ch1.rng = 5

scope.ch2.rng = 5


# starting the signal and the measuring
gen.w1.start()
scope.sample()

tt = scope.time.vals
vva = scope.ch1.vals
vvb = scope.ch2.vals


# plotting the data
'''
plt.plot(tt, vva, '.r')
plt.plot(tt, vvb, 'vb')
plt.show()
'''

# preparing the function for the fit
def sine(t, a, f, p, o):
    return a*np.sin(2*np.pi*f*t+p) + o

p0a = ((np.max(vva)-np.min(vva))/2, 1000, 0, np.mean(vva))
p0b = ((np.max(vvb)-np.min(vvb))/2, 1000, 0, np.mean(vvb))

# plotting the data and fit with p0 params
'''
plt.plot(tt, vva, '.r')
plt.plot(tt, sine(tt, *p0a), '--y')
plt.plot(tt, vvb, 'vb')
plt.plot(tt, sine(tt, *p0b), '--k')
plt.show()
'''

popta, pcova = curve_fit(sine, tt, vva, p0a)
poptb, pcovb = curve_fit(sine, tt, vvb, p0b)

plt.plot(tt, vva, '.r')
plt.plot(tt, sine(tt, *popta), '--y')
plt.plot(tt, vvb, 'vb')
plt.plot(tt, sine(tt, *poptb), '--k')
plt.show()

print(popta)
print(poptb)

G = poptb[0]/popta[0]
print(G)


# saving the data
#np.savetxt('data006.txt', np.c_[tt, vva, vvb], fmt = '%.6f')



ad2.close()
