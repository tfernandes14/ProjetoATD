clear all
close all
clc
% Ex2.1
[imagem, map] = imread('Peppers.bmp');

% Ex2.2
figure(1)
imshow(imagem, map);

% Ex2.3
X_imagem = fftshift(fft2(imagem));

N = length(X_imagem);
figure(2)
mesh(-N/2:N/2-1, -N/2:N/2-1, 20*log10(abs(X_imagem)));
axis([-N/2 N/2 -N/2 N/2]);
view([-37.5 30]);

disp('Índice da cor média no mapa de cores da imagem:')
C0 = abs(X_imagem(N/2+1,N/2+1))/N/N
mean(mean(imagem))

figure(3)
title('Cor média da imagem')
imshow(C0*ones(size(imagem)),map);
