import wfdb
from wfdb import processing
import numpy as np
import scipy.io
import matplotlib.pyplot as plt
from scipy.signal import find_peaks
import glob
import os

ann = wfdb.rdann('100', 'atr')
print(ann.symbol)
print(ann.sample)

sig, fields = wfdb.rdsamp('100', channel_names=['MLII'])
xqrs = processing.XQRS(sig=sig[:,0], fs=fields['fs'])
xqrs.detect()

print(xqrs.qrs_inds)

comparitor = processing.Comparitor(ann.sample[1:],
                                       xqrs.qrs_inds,
                                       int(0.1 * fields['fs']),
                                       sig[:,0])
comparitor.compare()
comparitor.print_summary()
#comparitor.plot()
#wfdb.plot_items(signal=sig, ann_samp=[xqrs.qrs_inds])

i=0
j=1
finalAnn = []

while i < len(xqrs.qrs_inds) and j < len(ann.sample):
    llimit = ann.sample[j] - 0.1 * fields['fs']
    rlimit = ann.sample[j] + 0.1 * fields['fs']
    if llimit <= xqrs.qrs_inds[i] <= rlimit:
        finalAnn.append([xqrs.qrs_inds[i], ann.symbol[j]])
        i = i+1
        j = j+1
    else:
        if xqrs.qrs_inds[i] > ann.sample[j]:
            j = j+1
        else:
            i = i+1
print(finalAnn)
print(len(finalAnn))
i=0
for index in xqrs.qrs_inds:
    start = (index - 50) if index - 50 >= 0 else 0
    end = (index + 150) if index + 150 <= sig.size else sig.size
    if end - start = 200:
        signals, fields = wfdb.rdsamp('100', sampfrom=start, sampto=end, channel_names=['MLII'])
        fig = wfdb.plot_items(signal=signals, return_fig=True)
        fig.savefig(str(index)+"-"+ann.symbol[i]+".png")
    i = i+1