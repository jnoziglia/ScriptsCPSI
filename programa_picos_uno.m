clc; 
close all;
clear;
%archivos = dir('*.mat');
%%load('A1440.mat');
load('A0113.mat');
fs=500;
%val=val*(-1);
% prom= mean(val);
% minimo=min(val);
% maximo= max(val);
%val=val-minimo;
% for(i=1:length(val))
% val_resc(i)= (val(i)- minimo)/(maximo-minimo);
% end
% val_stand= (val-prom)/std(val);
% val_sin_continua= (val-prom);
% for i=1:length(archivos)
%     load(archivos(i).name)
%

N = 2;
fc = 1; % Hz
[B,A] = butter(N,2*fc/500,'high');
canal2_filt = filtfilt(B,A,ECG.data(2,1:5000));

canal2=filloutliers(canal2_filt, "next","percentiles",[0.5 99.5]);

t = (1:1:length(canal2));
% fs=360;
 lim_y = 0.5*max(abs(canal2));
%  lim_y2 = 0.8*max(abs(val_resc));
 lim_x = fs/3;
%  lim_ys = 0.8*max(abs(val_stand));
%  lim_xs = 1;
% % if(rem(i,15)==0)
%   figure;
%   plot(t,val);
%   xlabel('Muestras')
%   ylabel('Amplitud (mV)')
%   title('ECG')
%   xlim([0 4000])
%  end

[R_amplitud, R_locacion] = findpeaks(canal2,'MinPeakHeight',lim_y,'MinPeakDistance',lim_x);
% [R_amplituds2, R_locacions2] = findpeaks(val_stand,'MinPeakHeight',lim_ys,'MinPeakDistance',lim_xs);
% [R_amplitud3, R_locacion3] = findpeaks(val_resc,'MinPeakHeight',lim_y2,'MinPeakDistance',lim_x);

% if((rem(i,15)==0))
figure;
hold on;
plot(t,canal2);
scatter(t(R_locacion),R_amplitud)
% plot(t,val_stand,'r');
% plot(t,val_resc,'g');
% scatter(t(R_locacions2),R_amplituds2)
%plot(t,val_sin_continua,'m');
% scatter(t(R_locacion3),R_amplitud3)
xlabel('Muestras')
ylabel('Amplitud (mV)')
title('ECG')
xlim([0 6000])
hold off;
% end
 R_locacion = R_locacion/360;
 %R_locacion2 = R_locacion2/360;
% %Ahora las locaciones están en segundos
 tam=length(R_locacion)-1;
 for j=1:tam
     k=j+1;
     Distancias(j)= R_locacion(k)- R_locacion(j)
 end
MAX= max(Distancias);
MIN= min(Distancias);
DESVIO= std(Distancias);
% end
%MAX=MAX';
%MIN=MIN';
%DESVIO=DESVIO';