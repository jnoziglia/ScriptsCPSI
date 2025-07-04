%Programa para calcular el maximo y minimo coeficiente de la 
%transformada de onditas de un electro normal y uno con fibrilacion.
clear
clc
close all
load A0009
normal_ejemplo=ECG.data(12,1:5000);
load A0010
fibrilacion_ejemplo=ECG.data(12,1:5000);
tm = 0:1/360:numel(normal_ejemplo)*1/360-1/360;
figure(1)
plot(tm,normal_ejemplo,'b')
grid on
hold on
plot(tm,fibrilacion_ejemplo,'r')
axis tight
legend('Normal','Fibrilation')
title("ECG")
xlabel("Time (s)")
ylabel("Amplitude")
figure(2)
subplot(1,2,1)
[cfs_normal,f] = cwt(normal_ejemplo,360);
imagesc(tm,f,abs(cfs_normal))
xlabel("Time (s)")
ylabel("Frequency (Hz)")
axis xy
clim=[0.025 0.25];
title("CWT of ECG Normal Data")
colorbar
[max_normal,I_normal]= max(max(abs(cfs_normal),[],1));
[min_normal,Imin_normal]= min(min(abs(cfs_normal),[],1));

subplot(1,2,2)
[cfs_fib,f] = cwt(fibrilacion_ejemplo,360);
imagesc(tm,f,abs(cfs_fib))
xlabel("Time (s)")
ylabel("Frequency (Hz)")
axis xy
clim=[0.025 0.25];
title("CWT of ECG Fibrilacion Data")
colorbar
[max_fib,Imax_fib]= max(max(abs(cfs_fib),[],1));
[min_fib,Imin_fib]= min(min(abs(cfs_fib),[],1));
