import wfdb
from wfdb import processing
import numpy as np
import scipy.io
import matplotlib.pyplot as plt
from scipy.signal import find_peaks
import glob
import os
from scipy.io import savemat

# print(ann.symbol)
# files = ['00003_hr','00004_hr','00005_hr','00006_hr','00009_hr','00010_hr','00013_hr','00014_hr','00016_hr','00017_hr','00018_hr']
# files = ['00003_lr','00004_lr','00005_lr','00006_lr','00009_lr','00010_lr','00013_lr','00014_lr','00016_lr']

# files = ['00170_lr','00219_lr','00256_lr','00452_lr']
# files = ['00144_lr']

os.chdir("../ptbxl full/records100/21000")
files = glob.glob("*.dat")

for file in files:
    fname = file[:-4]
    sig, fields = wfdb.rdsamp(fname)

    sigList = [x for x in sig]

    sigDic = {"val": sigList}

    print(fname)
    print(len(sigList))

    savemat(fname + ".mat", sigDic)
