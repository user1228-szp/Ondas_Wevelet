clc
clear
clf
close all
clc

identify_file = dir('*.csv');
total_files = length(identify_file);

for a = 1:total_files
    name_file = identify_file(a).name;
    data = readmatrix(name_file);
    data = -1 * data;
    
    data_no_zeros = data(:, 1:find(data(1,:)~=0, 1, 'last'));
    a = data_no_zeros(1,:);
    
    Fs = 125;  % Frecuencia de muestreo
    t = 0:1/Fs:(length(a)-1)/Fs;  % Vector de tiempo
    
    signal = a;
    
    % Crear figura con subplots
    figure;
    
    % Graficar la señal
    subplot(2,1,1);
    plot(t, signal);
    title('Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    % Transformada Wavelet Continua
    [cfs, frequencies] = cwt(signal, 'amor', Fs);
    
    power = abs(cfs).^2;
    
    % Graficar el espectrograma de la potencia
    subplot(2,1,2);
    imagesc(t, frequencies, power);
    axis xy;
    title('Continuous Wavelet Transform Power Spectrogram');
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    colorbar;
    colormap('jet');
    
    pause();
end
