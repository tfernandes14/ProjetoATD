clear all
close all

disp("Exercício 1.1.1 - Ver figure 1 e 2")
x = load('datasetfp7.dat');
Ts = 4*10^-3;   % Ts = 4ms
ws = 2*pi/Ts;
N = length(x);  % Periodo de x[n]
Omega0 = 2*pi/N;
T0 = N*Ts;      % Periodo de x(t)
w0 = 2*pi/T0;

n = (0:N-1)';
t = n*Ts;

m_max = 80;
[Cm,tetam] = SerieFourier(t,x,T0,m_max);
figure(1)
plot(t,x)
title('x[n] dado pelo dataset');
xlabel('t(s)')

m = 0:m_max;
figure(2)
subplot(211)
plot(m,Cm,'o')
title('Valores de Cm')
ylabel('Cm')
xlabel('m')
subplot(212)
plot(m,tetam,'o')
title('Valores de Teta_m')
ylabel('Teta_m (rad)')
xlabel('m')

% Ex1.1.2
disp('Exercício 1.1.2 - Ver figure 3')

mt = [0 10 40 80];

figure(3)
plot(t,x)
title('Reconstrução de x[n]')
xlabel('t(s)')
hold on

for k = 1:length(mt)
    xa = zeros(size(t));
    for m = 0:mt(k)
        xa = xa + Cm(m+1)*cos(m*2*pi/T0*t+tetam(m+1));
    end
    plot(t, xa)
end
hold off

disp('Exercício 1.1.3 - Ver figure 4')
cm=[flip(Cm(2:end)/2.*exp(-j*tetam(2:end)));Cm(1)*cos(tetam(1));Cm(2:end)/2.*exp(j*tetam(2:end))];
m=-m_max:m_max;
figure(4)
subplot(211)
plot(m, abs(cm),'bo')
title('Valores de C_m para a série de Fourier complexa')
ylabel('abs(cm')
xlabel('m')
subplot(212)
plot(m, unwrap(angle(cm)), 'bo')
title('Valores de Teta_m para a série de Fourier complexa')
ylabel('angle(cm)')
xlabel('m')

% Ex1.1.4
disp('Exercício 1.1.4 - Ver figure 5, 6 e 7')
X = fftshift(fft(x));   % DFT de x[n]
X(abs(X) < 0.001) = 0;  % Anular valores residuais

if (mod(N,2)==0)
    w = -ws/2:ws/N:ws/2-ws/N;
    Omega = -pi:2*pi/N:pi-2*pi/N;
else
    w = -ws/2+ws/N/2:ws/N:ws/2-ws/N/2;
    Omega = -pi+pi/N:2*pi/N:pi-pi/N;
end

figure(5)
subplot(211)
plot(m, abs(cm),'bo',w/w0, abs(X)/N,'r*')
title('Comparação dos coeficientes cm com a DFT/T0')
ylabel('|cm| e |DFT|/N')
xlabel('m')
subplot(212)
plot(m,unwrap(angle(cm)),'bo',w/w0,unwrap(angle(X)),'r*')
ylabel('<cm e <DFT (rad)')
xlabel('m')

figure(6)
subplot(211)
plot(m*w0, abs(cm),'bo',w, abs(X)/N,'r*')
title('Comparação dos coeficientes cm com a DFT/T0')
ylabel('|cm| e |DFT|/N')
xlabel('w (rad/s)')
subplot(212)
plot(m*w0,unwrap(angle(cm)),'bo',w,unwrap(angle(X)),'r*')
ylabel('<cm e <DFT (rad)')
xlabel('w (rad/s)')

figure(7)
subplot(211)
plot(m*Omega0, abs(cm),'bo',Omega, abs(X)/N,'r*')
title('Comparação dos coeficientes cm com a DFT/T0')
ylabel('|cm| e |DFT|/T0')
xlabel('Omega (rad)')
subplot(212)
plot(m*Omega0,unwrap(angle(cm)),'bo',Omega,unwrap(angle(X)),'r*')
ylabel('<cm e <DFT (rad)')
xlabel('Omega (rad)')

disp('Exercício 1.2:')
m = 0:m_max;
ind = find(Cm>0.1);
disp('-> Componentes de frequência do sinal x[n], m: ')
disp(m(ind))
disp('-> Frequências do sinal x[n], Omega[rad]:')
omega_xn = m(ind)*2*pi/N;
disp(omega_xn)
disp('-> Frequências do sinal x(t), w[rad/s]:')
w_xt = m(ind)*2*pi/T0;  % w_xt = omega_xn/Ts
disp(w_xt)
disp('-> Frequências do sinal x(t), f[Hz]:')
disp(w_xt/2/pi)

disp('Exercício 2.1')
w0 = 10*pi;
f0=w0/(2*pi);
fs = 65;
ws = 2*pi*fs;
Ts = 1/fs;

syms t n
xtt = -1+3*sin(50*pi*t)+4*cos(20*pi*t+pi/4)*sin(40*pi*t)
xnn = subs(xtt,t,n*Ts)

disp('Exercício 2.2 - Ver figura 1')
w0
Omega0=Ts*w0
T0 = 2*pi/w0
f0 = 1/T0;
N = T0/Ts;

if(mod(N,2)==0)
    w = -ws/2:ws/N:ws/2-ws/N;
    Omega=-pi:2*pi/N:pi-2*pi/N;
else
    w = -ws/2+ws/N/2:ws/N:ws/2-ws/N/2;
    Omega=-pi+pi/N:2*pi/N:pi-pi/N;
end

disp('Exercício 2.3')
t=0:0.001:T0-0.001;
xt=double(subs(xtt));
n=0:N-1;
xn=double(subs(xnn));

figure(1)
plot(t,xt,n*Ts,xn,'o')
title('x(t) e x[n]')
xlabel('Tempo(s)')

disp('Exercício 2.4 - Ver figura 2 e 3')
X=fftshift(fft(xn));    % DFT de x[n]
X(abs(X) < 0.001) = 0;  % Anular valores residuais
abs_X = abs(X);
ang_X=angle(X);

figure(2)
subplot(211)
plot(w,abs_X,'o')
title('DFT - Transformada de Fourier Discreta')
ylabel('Magnitude( |X| )')
xlabel('w (rad/s)')
subplot(212)
plot(w,unwrap(ang_X),'o')
ylabel('Fase / <X (rad)')
xlabel('w (rad/s)')

figure(3)
subplot(211)
plot(Omega, abs_X,'o')
title('DFT - Transformada de Fourier Discreta')
ylabel('Magnitude( |X| )')
xlabel('Omega (rad)')
subplot(212)
plot(Omega,unwrap(ang_X),'o')
ylabel('Fase / <X (rad)')
xlabel('w (rad/s)')

disp('Exercício 2.5 - Ver figura 4')
cm=X/N;

figure(4)
subplot(211)
plot(Omega/Omega0,abs(cm),'o')
title('Coeficientes da Série de Fourier complexa')
ylabel('|cm|')
xlabel('m')
subplot(212)
plot(Omega/Omega0, unwrap(angle(cm)),'o')
ylabel('<cm (rad)')
xlabel('m')

disp('Exercício 2.6 - Ver figura 5')
ind=find(Omega>=0);
Cm=[abs(cm(ind(1))) 2*abs(cm(ind(2:end)))];
tetam=angle(cm(ind));

figure(5)
subplot(211)
plot(Omega(ind)/Omega0,Cm,'o')
title('Coeficientes da Série de Fourier trignométrica')
ylabel('Cm')
xlabel('m')
subplot(211)
plot(Omega(ind)/Omega0,tetam,'o')
ylabel('Teta_m (rad)')
xlabel('m')

disp('Exercício 2.7 - Ver figura 6')
xtr=zeros(size(t));
m_max=Omega(ind(end))/Omega0;
for m=0:m_max
    xtr=xtr+Cm(m+1)*cos(m*w0*t+tetam(m+1));
end

figure(6)
plot(t,xt,t,xtr,'-.')
title('Sinal x(t) e sinal reconstruído xr(t)')
xlabel('Tempo(s)')
ylabel('x(t) e x(t) rec.')

