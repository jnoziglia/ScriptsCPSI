%Programa para calcular el maximo y minimo coeficiente de la 
%transformada de onditas de un electro normal y uno con fibrilacion.
clc; 
close all;
clear;
archivos = dir('TrainingSet1/*.mat');
archivos = cat(1, archivos, dir('TrainingSet2/*.mat'));
archivos = cat(1, archivos, dir('TrainingSet3/*.mat'));
fs=500;
j=1;
k=1;

for i=1:length(archivos)
    load(archivos(i).name)
    if length(ECG.data(2,:))>=5000%%Filtro las que tienen menos de 5000 muestras
        vector = ECG.data(2,1:5000);%Tomo las primeras 5000 muestras de cada ECG
        t = (1:1:length(vector));
        
        [cfs,f] = cwt(vector,fs);
        
        [max_cfs(i),ind_max(i)]= max(max(abs(cfs),[],1));
        [min_cfs(i),ind_min(i)]= min(min(abs(cfs),[],1));
        
        %[max_aux,max_f(i)] = max(cfs(ind_max(i),:));
        [max_aux(i),f_max(i)] = max(abs(cfs(:,ind_max(i))));
        
        %cat(1, signal_max_wav, cfs(f_max(i),:)
        
        signal_max_wav(:,i) = cfs(f_max(i),:);
        
    end
end
