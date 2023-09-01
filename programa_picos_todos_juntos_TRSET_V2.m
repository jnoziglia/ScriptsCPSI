clc; 
close all;
clear;
archivos = [dir('../TrainingSet1/*.mat');dir('../TrainingSet2/*.mat');dir('../TrainingSet3/*.mat')];
fs=500;
j=1;
k=1;
% b=50;
%load('100m (0).mat');
for i=1:length(archivos)
    load(archivos(i).name)
    archivos(i).name
    %canal2=ECG.data(2,:);
    if length(ECG.data(2,:))>=5000%%Filtro las que tienen menos de 5000 muestras
        %vector = ECG.data(2,1:5000);%Tomo las primeras 5000 muestras de cada ECG
        N = 2;
        fc = 1; % Hz
        [B,A] = butter(N,2*fc/fs,'high');
        vector_filt = filtfilt(B,A,ECG.data(2,1:5000));
        vector = filloutliers(vector_filt, "next","percentiles",[0.5 99.5]);
        t = (1:1:length(vector));
        %valormax(i)=max(abs(canal2));
        lim_y = 0.3*max(abs(vector));
        lim_x = fs/3;
        
        Distancias=0;
        
        [R_amplitud_orig, R_locacion_orig] = findpeaks(vector,'MinPeakHeight',lim_y,'MinPeakDistance',lim_x);
        [R_amplitud_inv, R_locacion_inv] = findpeaks(vector*-1,'MinPeakHeight',lim_y,'MinPeakDistance',lim_x);
        
        if length(R_locacion_inv) >= 10 && length(R_locacion_orig) >= 10
            if length(R_locacion_inv) > length(R_locacion_orig)
                R_locacion = R_locacion_inv;
            else
                R_locacion = R_locacion_orig;
            end
        elseif length(R_locacion_inv) >= 10
            R_locacion = R_locacion_inv;
        else
            R_locacion = R_locacion_orig;
        end
            
        if isempty(R_locacion)
            MAX(j)= 0;
            MIN(j)= 0;
            DESVIO(j)= 0;
            cant_picos(j)= 0;
        else
            R_locacion = R_locacion/fs;
            %Ahora las locaciones están en segundos
            tam=length(R_locacion)-1;
            cant_picos(j)= length(R_locacion);
            for h=1:tam
                g=h+1;
                Distancias(h)= R_locacion(g)- R_locacion(h);
            end
            MAX(j)= max(Distancias);
            MIN(j)= min(Distancias);
            DESVIO(j)= std(Distancias);
        end
        j=j+1;

    else
        filtrados(k)=i;%Me guardo los números de electros que fueron removidos
        k=k+1;
        j=j+1;
    end

% figure;
% plot(t,val);
% xlabel('Tiempo s)')
% ylabel('Amplitud (mV)')
% title('ECG')
% xlim([0 4000])


% if((rem(i,b)==0))
%     b=500;%Para que no vuelva a entrar
%     Mi_loc=R_locacion/360;
%     figure;
%     hold on;
%     plot(t,val);
%     scatter(t(R_locacion),R_amplitud)
%     xlabel('Tiempo s)')
%     ylabel('Amplitud (mV)')
%     title('ECG')
%     xlim([0 4000])
%     hold off;
% end
end
MAX=MAX';
MIN=MIN';
DESVIO=DESVIO';
cant_picos=cant_picos';