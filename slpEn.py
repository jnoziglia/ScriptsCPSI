import numpy as np
import scipy.io
import glob
import os
import math
import random
import EntropyHub as EH
import csv

def getSlopePattern(vectorTimeSeries: list, iEmbeddedDimension: int, fGamma: float, fDelta: float, j: int):
    vectorSlopePattern = []
    for i in range(j + 1, j + iEmbeddedDimension):
        fSlope = vectorTimeSeries[i] - vectorTimeSeries[i - 1]
        if (abs(fSlope) <= fDelta):
            vectorSlopePattern.append(0)
        elif (fSlope > fDelta and fSlope <= fGamma):
            vectorSlopePattern.append(1)
        elif (fSlope > fGamma):
            vectorSlopePattern.append(2)
        elif (fSlope < -fDelta and fSlope >= -fGamma):
            vectorSlopePattern.append(-1)
        else:
            vectorSlopePattern.append(-2)
    return vectorSlopePattern

def fComputeSlopeEntropy(vectorTimeSeries: list, iEmbeddedDimension: int, fGamma: float, fDelta: float) -> float:
    bFound: bool
    fSlopEn: float
    p: float
    fSlope: float
    listPatternsFound = []
    fSlopEn = 0.0
    for j in range(0, len(vectorTimeSeries) - (iEmbeddedDimension - 1)):
        vectorSlopePattern = getSlopePattern(vectorTimeSeries, iEmbeddedDimension, fGamma, fDelta, j)
        bFound = False
        for pattern in listPatternsFound:
            if (pattern['vectorSymbols'] == vectorSlopePattern):
                pattern['c'] += 1
                bFound = True
                break
        if (bFound == False):
            listPatternsFound.append({'c': 1, 'vectorSymbols': vectorSlopePattern})
    for pattern in listPatternsFound:
        p = float(pattern['c']) / len(listPatternsFound)
        fSlopEn += -(p * math.log2(p))
    return fSlopEn

def normalizeSlopEn(entropy, n):
    normalized = (entropy - (-n * math.log(n))) / (((2 * math.sqrt(n)) / math.e) - (-n * math.log(n)))
    return normalized

def processFile(folder, file='/*.mat'):
    print(folder)
    print(file)
    dir = folder
    mat_files = glob.glob(dir + file)

    data = []

    for fname in mat_files:
        mat = scipy.io.loadmat(fname, struct_as_record=False, squeeze_me=True)
        if not 'val' in mat:
            print(mat['x'])
            val = mat['x']
        else:
            val = mat['val']
        slope = EH.SlopEn(Sig=val, m=10, tau=1, Logx=2, Lvls=(5, 45), Norm=True)
        # entropy = fComputeSlopeEntropy(val, 3, 1, 0.001)
        data.append(slope)
        print(slope)

    with open(dir + '.csv', 'w', encoding='UTF8', newline='') as f:
        writer = csv.writer(f)

        # write multiple rows
        writer.writerows(data)

folders = ["1 NSR", "2 APB", "3 AFL", "4 AFIB", "5 SVTA", "6 WPW", "7 PVC", "8 Bigeminy", "9 Trigeminy", "10 VT", "11 IVR", "12 VFL", "13 Fusion", "14 LBBBB", "15 RBBBB", "16 SDHB", "17 PR"]
rootdir = './Data/'
os.chdir(rootdir)
# for folder in folders:
#     processFile(folder=folder)
processFile(folder='1 NSR', file='/200m(0)denoised.mat')
