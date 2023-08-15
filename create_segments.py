import wfdb
from wfdb import processing
import numpy as np
import scipy.io
import matplotlib.pyplot as plt
from scipy.signal import find_peaks
import glob
import os
from scipy.io import savemat
import array as arr

records = ['100','101','103','105','106','108','109','111','112','113','114','115','116','117','118','119','121','122','123','124','200','201','202','203','205','207','208','209','210','212','213','214','215','219','220','221','222','223','228','230','231','232','233','234']
aami = {'N': 'N','L': 'N','R': 'N','e': 'S','j': 'S','A': 'S','a': 'S','J': 'S','S': 'S','V': 'V','E': 'V','F': 'F','f': 'Q','Q': 'Q'}

for record in records:
    print(record)
    ann = wfdb.rdann(record, 'atr')

    sig, fields = wfdb.rdsamp(record, channel_names=['MLII'])

    xqrs = processing.XQRS(sig=sig[:,0], fs=fields['fs'])
    xqrs.detect()

    i=0
    j=1
    finalAnn = []
    finalSig = []

    while i < len(xqrs.qrs_inds) and j < len(ann.sample):
        llimit = ann.sample[j] - 0.1 * fields['fs']
        rlimit = ann.sample[j] + 0.1 * fields['fs']
        if llimit <= xqrs.qrs_inds[i] <= rlimit:
            index = xqrs.qrs_inds[i]
            start = (index - 50) if index - 50 >= 0 else 0
            end = (index + 150) if index + 150 <= sig.size else sig.size
            if end - start == 200:
                signals, fields = wfdb.rdsamp(record, sampfrom=start, sampto=end, channel_names=['MLII'])
                if aami.get(ann.symbol[j]) == None:
                    print(ann.symbol[j])
                else:
                    finalSig.append(signals)
                    finalAnn.append(aami[ann.symbol[j]])
            i = i+1
            j = j+1
        else:
            if xqrs.qrs_inds[i] > ann.sample[j]:
                j = j+1
            else:
                i = i+1
    sigDic = {'val': finalSig}
    annDic = {'val': finalAnn}

    savemat(record+'ann.mat', annDic)
    savemat(record+'sig.mat', sigDic)

arr.array()