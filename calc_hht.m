clc; 
close all;
clear;

archivo = load("1 NSR/101m (1)");
% archivo = load("4 AFIB/210m (1)");
fs = 360;

orig_signal = archivo.val;
% Pronar cambiando el tipo de wavelet, los niveles o usar señales sin
% denoise
denoised = wdenoise(orig_signal,3,Wavelet="db1");
imf = emd(denoised);
imf = emd(orig_signal);

% Probar cambiando el limite superior de 'FrequencyLimits'
[P, f, t] = hht(imf, fs, 'FrequencyLimits', [0 60]);

max_P = max(full(P),[],2);

%% Curva de maxima energia v Frecuencia
figure(1)
plot(f, max_P)
% Area bajo la curva
area = trapz(f, max_P)
xlabel('Frecuencia (Hz)')
ylabel('Energía instantánea')
ylim([0 25000])

%% Envolvente de curva de maxima energia v Frecuencia
% Probar cambiando el 2do parametro que corresponde al numero de samples y
% el ultimo parametro que corresponde al tipo de envolvente
figure(2)
plot(f, max_P)
[up, lo] = envelope(max_P, 4,'peak');
hold on
plot(f,up,'linewidth',1.5)
xlabel('Frecuencia (Hz)')
ylabel('Energía instantánea')
ylim([0 25000])
legend('Señal','Envolvente sup')
hold off

%% Grafico 3d, Energia instantanea v tiempo v frecuencia
figure(3)
mesh(seconds(t),f,P,'EdgeColor','none','FaceColor','interp')
xlabel('Tiempo (s)')
ylabel('Frecuencia (Hz)')
zlabel('Energía instantánea')

%% Grafico 2d, Energia instantanea v tiempo v frecuencia
figure(4)
imagesc(t, f, P);
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
title('Espectro de Hilbert (Energía)');