import wfdb
from wfdb import processing
import glob
import os
import scipy.io

folders = ["TrainingSet1", "TrainingSet2", "TrainingSet3"]
rootdir = '../'
os.chdir(rootdir)
for folder in folders:
    dir = folder
    mat_files = glob.glob(dir + '/*.mat')

    data = []
    for fname in mat_files:
        mat = scipy.io.loadmat(fname, struct_as_record=False, squeeze_me=True)git st
        val = mat['ECG'].data[1]
        (hard_peaks, soft_peaks) = processing.find_peaks(sig=val)
        print(soft_peaks)