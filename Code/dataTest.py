import tdwf
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit


ad2 = tdwf.AD2()

gen = tdwf.WaveGen(ad2.hdwf)
gen.w1.func = tdwf.funcSine
gen.w1.offs = 0
gen.w1.freq = 200

gen.w1.start()


scope = tdwf.Scope(ad2.hdwf)
scope.ch1.rng = 5
scope.fs = 1e5
scope.npt = 1000
scope.trig(True)


scope.sample()
tt = scope.time.vals
vals = scope.ch1.vals


plt.plot(tt, vals, '.r')
plt.plot(tt, (np.sin(200*2*np.pi*tt)), '--k')
plt.show()

ad2.close()