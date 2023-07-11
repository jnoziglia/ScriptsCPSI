import numpy as np
import scipy.io
import glob
import os
import math
import random
import EntropyHub as EH
import csv

M = 6
TAU = 1
LOG_X = 2
LVLS = (5, 45)
NORM = True
GAMMA = 0.8
DELTA = 0.001


def get_slope_pattern(vector_time_series: list, embedded_dimension: int, gamma: float, delta: float, j: int):
    vector_slope_pattern = []
    for i in range(j + 1, j + embedded_dimension):
        f_slope = vector_time_series[i] - vector_time_series[i - 1]
        if abs(f_slope) <= delta:
            vector_slope_pattern.append(0)
        elif delta < f_slope <= gamma:
            vector_slope_pattern.append(1)
        elif f_slope > gamma:
            vector_slope_pattern.append(2)
        elif -delta > f_slope >= -gamma:
            vector_slope_pattern.append(-1)
        else:
            vector_slope_pattern.append(-2)
    return vector_slope_pattern


def compute_slope_entropy(vector_time_series: list, embedded_dimension: int, gamma: float, delta: float,
                          normalize: bool) -> float:
    b_found: bool
    f_slop_en: float
    p: float
    f_slope: float
    list_patterns_found = []
    f_slop_en = 0.0
    n = len(vector_time_series)
    for j in range(0, n - (embedded_dimension - 1)):
        vector_slope_pattern = get_slope_pattern(vector_time_series, embedded_dimension, gamma, delta, j)
        b_found = False
        for pattern in list_patterns_found:
            if pattern['vectorSymbols'] == vector_slope_pattern:
                pattern['c'] += 1
                b_found = True
                break
        if not b_found:
            list_patterns_found.append({'c': 1, 'vectorSymbols': vector_slope_pattern})
    k = len(list_patterns_found)
    for pattern in list_patterns_found:
        p = float(pattern['c']) / k
        f_slop_en += -(p * math.log(p))
    f_slop_test = f_slop_en
    if normalize:
        k_minus_one = k - 1
        l_calc = (n - k_minus_one) / k
        r_calc = 1/k
        min_bound_analytic = -n * math.log(n)
        min_bound_heur = (- l_calc * math.log(l_calc)) - (k_minus_one * r_calc * math.log(r_calc))
        max_bound = 2 * math.sqrt(n) / math.e
        f_slop_en = (f_slop_en - min_bound_heur) / (max_bound - min_bound_heur)
        f_slop_en = 0 if f_slop_en < 0 else f_slop_en
    return f_slop_en


def calculate_from_file(mat, file_type):
    if file_type == 'China':
        lead_entropy = []
        for lead in mat['ECG'].data:
            # slope = EH.SlopEn(Sig=lead, m=M, tau=TAU, Logx=LOG_X, Lvls=LVLS, Norm=False)
            slope = compute_slope_entropy(lead, M, GAMMA, DELTA, NORM)
            lead_entropy.append(slope)
        return lead_entropy
    elif file_type == 'MIT':
        if 'val' not in mat:
            val = mat['x']
        else:
            val = mat['val']
        # slope = EH.SlopEn(Sig=val, m=M, tau=TAU, Logx=LOG_X, Lvls=LVLS, Norm=NORM)
        slope = compute_slope_entropy(val, M, GAMMA, DELTA, NORM)
        return slope
    elif file_type == 'Test':
        val = [math.sin(2*math.pi*x/100) for x in range(5000)]
        slope = compute_slope_entropy(val, M, GAMMA, DELTA, NORM)
        return slope


def process_file(folder, file='/*.mat', write_to_file=False):
    dir = folder
    mat_files = glob.glob(dir + file)

    data = []

    for fname in mat_files:
        mat = scipy.io.loadmat(fname, struct_as_record=False, squeeze_me=True)
        entropy = calculate_from_file(mat, 'China')
        data.append(entropy)
        print(entropy)

    if write_to_file:
        with open(dir + '.csv', 'w', encoding='UTF8', newline='') as f:
            writer = csv.writer(f)

            # write multiple rows
            writer.writerows(data)


folders = ["TrainingSet1", "TrainingSet2", "TrainingSet3"]
rootdir = '../'
os.chdir(rootdir)
for folder in folders:
    process_file(folder=folder, write_to_file=True)
