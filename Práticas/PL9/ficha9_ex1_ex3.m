clc
close all
clear all

% Ex1.1
[x,fs] = audioread('escala.wav');
sound(x,fs)

% Ex1.2
disp("Frequência de amostragem (Hz): ")
fs
Ts = 1/fs;

disp("Período fundamental (N): ")
N = numel(x)

disp("Frequência angular fundamental, Omega0 (rad): ")
Omega0 = 2*pi/N

disp("Resolução em frequência (Hz):")
deltaf = fs/N

% Ex1.3
X = fftshift(fft(x));   % DFT do sinal

if (mod(N,2) == 0)
    f = -fs/2:fs/N:fs/2-fs/N;
else
    f = -fs/2+fs/(2*N):fs/N:fs/2-fs/(2*N);
end

m_X = abs(X);   % Magnitude do sinal com ruído

t = linspace(0,(N-1)/fs,N);

figure
subplot(211)
plot(t,x)
axis tight
xlabel('Tempo (s)')
ylabel('Amplitude')
title('Sinal original')
subplot(212)
plot(f,m_X)
hold on
title('|DFT| do sinal')
ylabel('Magnitude |X|')
xlabel('Frequência (Hz)')
axis tight

% Ex1.4
max_x = max(m_X);
min_mag = max_x - (0.2*max_x);
plot(f, repmat(min_mag,N,1),'r')
[pks,locs] = findpeaks(m_X,'MinPeakHeight',min_mag);    % Esta função pode ser útil

f_relevant = f(locs);
f_relevant = f_relevant(f_relevant > 0);
round(f_relevant)

disp('Frequências angulares: ')
if (mod(N,2) == 0)
    Omega = -Omega0*N/2:Omega0:Omega0*N/2-Omega0;
else
    Omega = -Omega0*N/2+Omega0/2:Omega0:Omega0*N/2-Omega0/2;
end

subplot(211)
plot(t,x)
axis tight
xlabel('Tempo (s)')
ylabel('Amplitude')
title('Sinal original')
subplot(212)
plot(Omega,m_X)
hold on
title('|DFT| do sinal')
ylabel('Magnitude |X|')
xlabel('\Omega (rad)')
axis tight

Omega_relevant = Omega(locs);
Omega_relevant = Omega_relevant(Omega_relevant > 0);

Tframe = 0.128;     % Largura da janela em em análise em s
Toverlap = 0.064;   % Sobreposição das janelas em s
Nframe = round(Tframe*fs);  % Número de amostras da janela
Noverlap = round(Toverlap*fs);  % Número de amostras sobrepostas

h = hamming(Nframe);    % Janela de hamming

if (mod(N,2) == 0)
    f_frame = -fs/2:fs/Nframe:fs/2-fs/Nframe;
else
    f_frame = -fs/2+fs/(2*Nframe):fs/Nframe:fs/2-fs/(2*Nframe);
end

freq_relev = [];
nframes = 0;    % para guardar
tframes = [];

for ii = 1:Nframe-Noverlap:N-Nframe
    % Aplicar a janela ao sinal do tempo
    x_frame = x(ii:ii+Nframe-1).*h;
    
    % Obter a magnitude da fft do sinal
    m_X_frame = abs(fftshift(fft(x_frame)));
    
    % Oter o máximo da magnite do sinal
    m_X_frame_max = max(m_X_frame);
    
    % Encontrar os índices do máximo da magnitude do sinal
    ind = find(abs(m_X_frame - m_X_frame_max)<0.001);
    
    % Encontrar as frequências correspondentes ao máximo de %%%
    freq_relev = [freq_relev, f_frame(ind(2))];
    
    nframes = nframes+1;
    
    % Calcular o vetor de tempo correspondente a cada janela
    % corresponde ao valor do vetor de tempo, t, em cada %%%
    t_frame = t(ii:ii+Nframe-1);
    tframes = [tframes, t_frame(Nframe/2+1)];
end

freq_relev';

deltaf = fs/Nframe
deltat = Tframe - Toverlap;

tframes
tframes2 = 0:deltat:deltat*(nframes-1)
figure()
plot(tframes, freq_relev, 'o')
xlabel('Tempo(s)')
ylabel('Frequência (Hz)')
title('Sequência de frequência por janela')

% Ex3.3
figure()
spectrogram(x,Nframe,Noverlap,[],fs,'yaxis')

[s,f,t,p] = spectrogram(x,Nframe,Noverlap, [],fs);

% Encontrar os máximos de cada janela temporal
[I, A] = max(p);
freq_revel_spec = f(A);

% Ex3.4
f_notas = [262 277 294 311 330 349 370 392 415 440 466 494 523]';
notas = {'Dó'; 'Dó#'; 'Ré'; 'Ré#'; 'Mi'; 'Fá'; 'Fá#'; 'Sol'; 'Sol#'; 'Lá'; 'Lá#'; 'Si'; 'Dó2'};
ind_nj = [];

for k = 1: length(freq_relev)
    % Encontrar quais as notas na gama de frequências
    % [freq_relev(k) - 5Hz, freq_relev(k) + 5Hz]
    
    ind_freq = find(abs(f_notas - freq_relev(k)) < 5);
    ind_nj = [ind_nj; ind_freq];
end

disp('Sequência de notas musicais em cada janela:')
notas_xj = notas(ind_nj,:)