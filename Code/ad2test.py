import tdwf
import numpy as np
import matplotlib.pyplot as plt


def sine(x, a, f, phi, o):
    return a*np.sin(2*np.pi*f*x+phi)+o
    
ad2 = tdwf.AD2()

scope = tdwf.Scope(ad2.hdwf)
scope.ch1.rng = 5
scope.fs = 1e4
scope.npt = 1000
scope.sample()
#xx = np.linspace(range(len(scope)))
tt = scope.time.vals
vals = scope.ch1.vals
p0 = ((np.max(vals)-np.min(vals))/2, 50, np.pi, np.mean(vals))

plt.plot(tt, vals)
plt.plot(tt, sine(tt, *p0))
plt.show()


ad2.close()