clear
close all
clc

load resultado_normal_1.mat
load resultado_normal_2.mat
load resultado_prueba_AF.mat
load resultado_prueba_AF_2.mat
figure(1)
subplot(2,2,1)
contour(diferencia_N,3)
subplot(2,2,2)
contour(diferencia_N2,3)
subplot(2,2,3)
contour(diferencia_AF,3)
subplot(2,2,4)
contour(diferencia_AF2,3)
figure(2)
subplot(2,2,1)
contour(matriz_mi_N,20)
subplot(2,2,2)
contour(matriz_mi_N2,20)
subplot(2,2,3)
contour(matriz_mi_AF,20)
subplot(2,2,4)
contour(matriz_mi_AF2,20)

figure(3)
subplot(2,2,1)
[c h]= contour(matriz_TE1_N,5)
clabel(c,h)
subplot(2,2,2)
[c h]=contour(matriz_TE1_N2,5)
clabel(c,h)
subplot(2,2,3)
[c h]=contour(matriz_TE1_AF,5)
clabel(c,h)
subplot(2,2,4)
[c h]=contour(matriz_TE1_AF2,5)
clabel(c,h)

figure(4)
subplot(2,2,1)
heatmap(matriz_mi_N,'ColorLimits', [0 5])
colormap(jet)
subplot(2,2,2)
heatmap(matriz_mi_N2,'ColorLimits', [0 5])
colormap(jet)
subplot(2,2,3)
heatmap(matriz_mi_AF,'ColorLimits', [0 5])
colormap(jet)
subplot(2,2,4)
heatmap(matriz_mi_AF2,'ColorLimits', [0 5])
colormap(jet)



figure(5)
subplot(2,2,1)
heatmap(diferencia_N./max(max(diferencia_N)))
colormap(jet)
subplot(2,2,2)
heatmap(diferencia_N2./max(max(diferencia_N2)))
colormap(jet)
subplot(2,2,3)
heatmap(diferencia_AF./max(max(diferencia_AF)))
colormap(jet)
subplot(2,2,4)
heatmap(diferencia_AF2./max(max(diferencia_AF2)))
colormap(jet)

figure(6)
subplot(2,2,1)
heatmap(matriz_TE1_N)
colormap(jet)
subplot(2,2,2)
heatmap(matriz_TE1_N2)
colormap(jet)
subplot(2,2,3)
heatmap(matriz_TE1_AF)
colormap(jet)
subplot(2,2,4)
heatmap(matriz_TE1_AF2)
colormap(jet)
