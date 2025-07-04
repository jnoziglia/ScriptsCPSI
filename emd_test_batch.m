clc; 
close all;
clear;

% Clase 1
% archivos = ["1 NSR/100m (1)" "1 NSR/101m (1)" "1 NSR/103m (1)" "1 NSR/105m (1)" "1 NSR/106m (1)" "1 NSR/114m (1)" "1 NSR/115m (1)" "1 NSR/116m (1)" "1 NSR/123m (1)" "1 NSR/202m (1)" "4 AFIB/201m (1)" "4 AFIB/202m (1)" "4 AFIB/202m (a26)" "4 AFIB/203m (1)" "4 AFIB/210m (1)" "4 AFIB/210m (a19)" "4 AFIB/219m (1)" "4 AFIB/219m (a11)" "4 AFIB/221m (1)" "4 AFIB/221m (a11)"];

archivos_norm = dir('./Data/1 NSR/*.mat');
archivos_norm(contains({archivos_norm.name},{'denoised'})) = [];
archivos_fib = dir('./Data/4 AFIB/*.mat');
archivos_fib(contains({archivos_fib.name},{'denoised'})) = [];

%archivos_norm = ["1 NSR/100m (1)" "1 NSR/101m (1)" "1 NSR/103m (1)" "1 NSR/105m (1)" "1 NSR/106m (1)" "1 NSR/114m (1)" "1 NSR/115m (1)" "1 NSR/116m (1)" "1 NSR/123m (1)" "1 NSR/202m (1)"];
%archivos_fib = ["4 AFIB/201m (1)" "4 AFIB/202m (1)" "4 AFIB/202m (a26)" "4 AFIB/203m (1)" "4 AFIB/210m (1)" "4 AFIB/210m (a19)" "4 AFIB/219m (1)" "4 AFIB/219m (a11)" "4 AFIB/221m (1)" "4 AFIB/221m (a11)"];
archivos = [archivos_norm; archivos_fib];

fs = 360;

results = cell(length(archivos), 1);  % Preallocate

for i = 1:length(archivos)
    archivo = load(strcat(archivos(i).folder,"\", archivos(i).name));
    %archivo = load(archivos(i));
    orig_signal = archivo.val;
    denoised = wdenoise(orig_signal,3,Wavelet="db1");
    imf = emd(orig_signal);

    [P, f, t] = hht(imf, fs, 'FrequencyLimits', [0 50]);
    
    max_P = max(full(P),[],2);
    area = trapz(f, max_P);

    % mean_p = mean(P(:));
    % P = P - mean_p;

    maxEnergy = max(P(:));
    threshold = 0.8 * maxEnergy;
    mask = P >= threshold;

    linearIdxs = find(mask);
    [rows, cols] = ind2sub(size(P), linearIdxs);

    frequencies = f(rows);
    times = t(cols);
    energies = P(mask);

    %% Compute maximum per second and corresponding frequency
    maxPerSecond = [];
    freqAtMaxPerSecond = [];
    maxTime = ceil(max(t));  % Total number of full seconds

    for s = 1:maxTime
        idx = find(t >= (s-1) & t < s);  % columns for this second
        if ~isempty(idx)
            Pseg = P(:, idx);  % Extract segment
            [maxSeg, linearIdxSeg] = max(Pseg(:));
            [rowSeg, ~] = ind2sub(size(Pseg), linearIdxSeg);
            freqSeg = f(rowSeg);  % Get frequency of max

            maxPerSecond(end+1) = maxSeg;
            freqAtMaxPerSecond(end+1) = freqSeg;
        else
            maxPerSecond(end+1) = NaN;
            freqAtMaxPerSecond(end+1) = NaN;
        end
    end

    %% Store all results
    resultStruct = struct();
    resultStruct.filename = archivos(i);
    resultStruct.energies = energies;
    resultStruct.times = times;
    resultStruct.frequencies = frequencies;
    resultStruct.maxEnergy = maxEnergy;
    resultStruct.threshold = threshold;
    resultStruct.maxPerSecond = maxPerSecond;
    resultStruct.freqAtMaxPerSecond = freqAtMaxPerSecond;
    resultStruct.area = area;

    results{i} = resultStruct;

    %% Plot
%     figure;
%     imagesc(t, f, P);
%     axis xy;
%     xlabel('Time (s)');
%     ylabel('Frequency (Hz)');
%     title(sprintf('HHT: %s', archivos(i)));
%     colorbar;
% 
%     hold on;
%     scatter(times, frequencies, 40, 'r', 'filled');
%     legend('HHT Energy (80%-100% max)', 'Location', 'best');
end

energy_norm_mat = zeros(10,length(archivos_norm));
freq_norm_mat = zeros(10,length(archivos_norm));
energy_fib_mat = zeros(10,length(archivos_fib));
freq_fib_mat = zeros(10,length(archivos_fib));

for j = 1:length(archivos_norm)
    for i = 1:10
        energy_norm_mat(i, j) = results{j}.maxPerSecond(i);
        freq_norm_mat(i, j) = results{j}.freqAtMaxPerSecond(i);
    end
end
mean_energy_norm = mean(energy_norm_mat, 1);
mean_freq_norm = mean(freq_norm_mat, 1);
std_energy_norm = std(energy_norm_mat, 1);
std_freq_norm = std(freq_norm_mat, 1);

x = 1:length(archivos_norm);
figure(1)
scatter(x, mean_energy_norm)
hold
scatter(x, mean_freq_norm)
% plot(x, mean(mean_energy_norm)*ones(1,length(archivos_norm)))
% fill([x, flip(x)], [mean_energy_norm+std_energy_norm, flip(mean_energy_norm-std_energy_norm)], [0.8 0.8 0.8])
% hold
% scatter(x, mean_energy_norm)
%figure(2)
%scatter(x, mean_freq_norm)
%hold
%plot(x, mean(mean_freq_norm)*ones(1,length(archivos_norm)))

for j = length(archivos_norm)+1:length(archivos_norm)+length(archivos_fib)
    for i = 1:10
        energy_fib_mat(i, j-length(archivos_norm)) = results{j}.maxPerSecond(i);
        freq_fib_mat(i, j-length(archivos_norm)) = results{j}.freqAtMaxPerSecond(i);
    end
end
mean_energy_fib = mean(energy_fib_mat, 1);
mean_freq_fib = mean(freq_fib_mat, 1);
std_energy_fib = std(energy_fib_mat, 1);
std_freq_fib = std(freq_fib_mat, 1);

x = 1:length(archivos_norm);
figure(1)
scatter(x, mean_energy_norm)
hold
y = 1:length(archivos_fib);
scatter(y, mean_energy_fib)

x = 1:length(archivos_norm);
figure(2)
scatter(x, mean_freq_norm)
hold
y = 1:length(archivos_fib);
scatter(y, mean_freq_fib)

% x = 1:length(archivos_fib);
% figure(3)
% scatter(x, mean_energy_fib)
% hold
% plot(x, mean(mean_energy_fib)*ones(1,length(archivos_fib)))
% figure(4)
% scatter(x, mean_freq_fib)
% hold
% plot(x, mean(mean_freq_fib)*ones(1,length(archivos_fib)))


mean_energy_norm_val = mean(mean_energy_norm)
mean_freq_norm_val = mean(mean_freq_norm)
std_energy_norm_val = std(mean_energy_norm)
std_freq_norm_val = std(mean_freq_norm)
mean_energy_fib_val = mean(mean_energy_fib)
mean_freq_fib_val = mean(mean_freq_fib)
std_energy_fib_val = std(mean_energy_fib)
std_freq_fib_val = std(mean_freq_fib)

%% Energy max v Freq
%plot(max(full(P),[],2))
%envelope(max(full(P),[],2), 9,'peak')

areas = cellfun(@(s) s.area, results, 'UniformOutput', false);
areas_norm = cell2mat(areas(1:length(archivos_norm)));
areas_fib = cell2mat(areas(length(archivos_norm)+1:length(archivos_norm)+length(archivos_fib)));
mean_area_norm = mean(areas_norm);
mean_area_fib = mean(areas_fib);
std_area_norm = std(areas_norm);
std_area_fib = std(areas_fib);

error_area_norm = std_area_norm / sqrt(length(archivos_norm));
error_area_fib = std_area_fib / sqrt(length(archivos_fib));

error_ener_norm = std_energy_norm_val / sqrt(length(archivos_norm));
error_ener_fib = std_energy_fib_val / sqrt(length(archivos_fib));

error_freq_norm = std_freq_norm_val / sqrt(length(archivos_norm));
error_freq_fib = std_freq_fib_val / sqrt(length(archivos_fib));

