clc; 
close all;
clear;

load norm_vs_af;

for i=1:length(mat_mi_af_all)
    [mi_p_af_vs_normp(i),mi_t2_af_vs_normp(i)] = hotell2_y_aprox(mat_mi_norm, squeeze(mat_mi_af_all(i,:,:)));
    [mi_p_af_vs_afp(i),mi_t2_af_vs_afp(i)] = hotell2_y_aprox(mat_mi_af, squeeze(mat_mi_af_all(i,:,:)));
    [te_p_af_vs_normp(i),te_t2_af_vs_normp(i)] = hotell2_y_aprox(mat_te_norm, squeeze(mat_te_af_all(i,:,:)));
    [te_p_af_vs_afp(i),te_t2_af_vs_afp(i)] = hotell2_y_aprox(mat_te_af, squeeze(mat_te_af_all(i,:,:)));
end

for i=1:length(mat_mi_norm_all)
    [mi_p_norm_vs_normp(i),mi_t2_norm_vs_normp(i)] = hotell2_y_aprox(mat_mi_norm, squeeze(mat_mi_norm_all(i,:,:)));
    [mi_p_norm_vs_afp(i),mi_t2_norm_vs_afp(i)] = hotell2_y_aprox(mat_mi_af, squeeze(mat_mi_norm_all(i,:,:)));
    [te_p_norm_vs_normp(i),te_t2_norm_vs_normp(i)] = hotell2_y_aprox(mat_te_norm, squeeze(mat_te_norm_all(i,:,:)));
    [te_p_norm_vs_afp(i),te_t2_norm_vs_afp(i)] = hotell2_y_aprox(mat_te_af, squeeze(mat_te_norm_all(i,:,:)));
end