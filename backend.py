import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import rfft, rfftfreq

def freq(acc, sample_rate = 208):
    ax, ay, az = [], [], []
    for j in acc:
        ax.append(float(j[0]))
        ay.append(float(j[1]))
        az.append(float(j[2]))
    steps = 30/len(ax)
    time = []
    for x in range(len(ax)):
        time.append(x*steps)
    Ax, Ay, Az = [], [], []
    for i in range(len(time)):
        integ_x = np.trapz(ax[i:i+2], x = time[i:i+2])
        integ_y = np.trapz(ay[i:i+2], x = time[i:i+2])
        integ_z = np.trapz(az[i:i+2], x = time[i:i+2])
        try:
            Ax.append(Ax[i-1] + integ_x)
            Ay.append(Ay[i-1] + integ_y)
            Az.append(Az[i-1] + integ_z)
        except IndexError:
            Ax.append(integ_x)
            Ay.append(integ_y)
            Az.append(integ_z)

    A = [((Ax[i])**2 + (Ay[i])**2 + (Az[i])**2)**(1/2) for i in range(len(Ax))]

    yf = rfft(A)
    xf = rfftfreq(len(time), 1/sample_rate)
    return xf, yf

print(freq([['1', '2', '3'], ['2', '3', '4']]))