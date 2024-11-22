import tdwf
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

# initialization of the instrument
ad2 = tdwf.AD2()

# initialization of the waveform generatro
gen = tdwf.WaveGen(ad2.hdwf)

gen.w1.func = tdwf.funcDC
gen.w1.offs = 2

# initializatin of the two scopes
scope = tdwf.Scope(ad2.hdwf)

scope.fs = 1e6
scope.npt = 8192

scope.ch1.rng = 6
scope.ch2.rng = 6


# starting the signal and the measuring
gen.w1.start()
scope.sample()

tt = scope.time.vals
vva = scope.ch1.vals
vvb = scope.ch2.vals


# plotting the data

plt.plot(tt, vva, '.r')
plt.plot(tt, vvb, 'vb')
plt.show()





# saving the data
np.savetxt('data007.txt', np.c_[tt, vva, vvb], fmt = '%.6f')



ad2.close()