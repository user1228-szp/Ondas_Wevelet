clc;
clear;
close all;

data = readmatrix('Chf_2.csv');

data_no_zeros = data(:, 1:find(data(1,:)~=0, 1, 'last'));

a = data_no_zeros(1,:);

Fs = 125;            % Frecuencia de muestreo
t = 0:1/Fs:(length(a)-1)/Fs;    % Vector de tiempo

signal = a;

% Graficar la señal
figure;
plot(signal);
title('Señal Sinusoidal con Ruido');
xlabel('Tiempo (s)');
ylabel('Amplitud');

[cfs, frequencies] = cwt(signal, 'amor', Fs);

power = abs(cfs).^2;

figure;
imagesc(t, frequencies, power);
axis xy;
title('Espectrograma de la Potencia de la Transformada Wavelet Continua');
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
colorbar;
colormap('jet');
