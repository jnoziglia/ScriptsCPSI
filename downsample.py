import wfdb
from wfdb import processing
import glob
import os
import scipy.io

SAMPLES = 1200

folders = ["TrainingSet1", "TrainingSet2", "TrainingSet3"]
rootdir = "../"
os.chdir(rootdir)
for folder in folders:
    dir = folder
    mat_files = glob.glob(dir + "/*.mat")

    data = []
    for fname in mat_files:
        print(fname)
        mat = scipy.io.loadmat(fname, struct_as_record=False, squeeze_me=True)
        val = mat["ECG"].data[1]
        (downsampled_signal, downsampled_signal_t) = wfdb.processing.resample_sig(
            x=val, fs=500, fs_target=200
        )
        print(downsampled_signal)
        segments = len(downsampled_signal) // SAMPLES
        for start in range(segments):
            segment = downsampled_signal[start * SAMPLES : (start + 1) * SAMPLES]
            segment_dict = {"ECG": segment}
            scipy.io.savemat(
                fname.split(".")[0] + "_" + str(start) + ".mat", segment_dict
            )
        if downsampled_signal.size % SAMPLES != 0:
            start = len(downsampled_signal) - SAMPLES
            segment = downsampled_signal[start:]
            segment_dict = {"ECG": segment}
            scipy.io.savemat(
                fname.split(".")[0] + "_" + str(segments) + "_DA.mat", segment_dict
            )
