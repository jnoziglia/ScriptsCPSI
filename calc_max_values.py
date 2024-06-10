import glob
import os
import scipy.io
import numpy as np
from pathlib import Path
import pandas

folders = ["TrainingSet1", "TrainingSet2", "TrainingSet3"]
rootdir = "../"
os.chdir(rootdir)
i = 0
valid_regs = np.zeros((6877, 12))
max_values = np.zeros((6877, 12))
valid_files = [[], [], [], [], [], [], [], [], [], [], [], []]
invalid_files = [[], [], [], [], [], [], [], [], [], [], [], []]
for folder in folders:
    dir = folder
    mat_files = glob.glob(dir + "/*.mat")

    data = []
    for fname in mat_files:
        mat = scipy.io.loadmat(fname, struct_as_record=False, squeeze_me=True)
        j = 0
        for ecg in mat["ECG"].data:
            if max(map(abs, ecg)) < 2:
                valid_regs[i, j] = 1
                invalid_files[j].append(Path(os.path.basename(fname)).stem)
            else:
                valid_files[j].append(Path(os.path.basename(fname)).stem)
            max_values[i, j] = max(map(abs, ecg))
            j += 1
        i += 1

valid_files_dic = {}

for idx, files in enumerate(valid_files):
    channel = "channel" + str(idx + 1)
    valid_files_dic[channel] = files

scipy.io.savemat("valid_files.mat", valid_files_dic)

invalid_files_dic = {}

for idx, files in enumerate(invalid_files):
    channel = "channel" + str(idx + 1)
    invalid_files_dic[channel] = files

scipy.io.savemat("invalid_files.mat", invalid_files_dic)


# df = pandas.DataFrame(valid_regs)
# df2 = pandas.DataFrame(max_values)
# df2.to_csv("./max_values.csv", header=False, index=False)
# df.to_csv("./valid_regs-1.5.csv", header=False, index=False)
