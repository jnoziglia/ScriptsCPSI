chaclc; 
close all;
clear;
%archivos = dir('*.mat');
%%load('A1440.mat');
load('./TrainingSet1/A0747.mat');
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

canal2=ECG.data(2,1:5000);

%%%%%%%%%%Arreglar picos altísimos%%%%%%%%%%%%%%%%%%%%%

if(max(abs(canal2))>5*mean(abs(canal2)))%%Si entra hay un pico muy elevado
    [M,I]= max(abs(canal2));
    canal2(I)=(canal2(I+1)+canal2(I-1))/2;
end

% if(max(abs(canal2))==abs(min(canal2)))
%             canal2=canal2*-1;
% end
t = (1:1:length(canal2));
% fs=360;
 lim_y = 0.3*max(abs(canal2));
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