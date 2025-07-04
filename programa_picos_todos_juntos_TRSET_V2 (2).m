clc; 
close all;
clear;
archivos = dir('*.mat');
fs=500;
j=1;
k=1;
% b=50;
%load('100m (0).mat');
for i=1:length(archivos)
    load(archivos(i).name)
    %canal2=ECG.data(2,:);
if length(ECG.data(2,:))>=5000%%Filtro las que tienen menos de 5000 muestras
        vector = ECG.data(2,1:5000);%Tomo las primeras 5000 muestras de cada ECG
        t = (1:1:length(vector));
        %valormax(i)=max(abs(canal2));
        lim_y = 0.5*max(abs(vector));
        lim_x = fs/3;
        
        %%%%%%%%%%Arreglar picos altísimos%%%%%%%%%%%%%%%%%%%%%

        if(max(abs(canal2))>10*mean(abs(canal2)))%%Si entra hay un pico muy elevado
            [M,I]= max(abs(canal2));
            canal2(I)=(canal2(I+1)+canal2(I-1))/2;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if(max(abs(vector))==abs(min(vector)))
            vector=vector*-1;
        end
        Distancias=0;
        
        [R_amplitud, R_locacion] = findpeaks(vector,'MinPeakHeight',lim_y,'MinPeakDistance',lim_x);
        
        R_locacion = R_locacion/fs;
        %Ahora las locaciones están en segundos
        tam=length(R_locacion)-1;
        cant_picos(j)= length(R_locacion);
        for h=1:tam
            g=h+1;
            Distancias(h)= R_locacion(g)- R_locacion(h)
        end
        MAX(j)= max(Distancias);
        MIN(j)= min(Distancias);
        DESVIO(j)= std(Distancias);
        j=j+1;

else
    filtrados(k)=i;%Me guardo los números de electros que fueron removidos
    k=k+1;
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