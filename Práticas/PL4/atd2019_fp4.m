close all
clear all %#ok<CLALL>
PL = 3;
b0 = 0.1*(mod(PL,2)+1);
b1 = 0.4*(mod(PL,2));
b2 = 0.4*(mod(1+PL,2));
b3 = 0.3*(mod(PL,3)+1);
b4 = -0.1*(mod(PL,4)+1);
% So começa a aparecer valores a partir de -40 e vai ate 39
n = -50:50;
xn = x(n);
yn = b0*atrasa(xn,0)+b1*atrasa(xn,1)+b2*atrasa(xn,2)+b3*atrasa(xn,3)+b4*atrasa(xn,4);
figure
plot(n,xn,n,yn)
xlabel('n');
title('Resposta do sistema ao sinal sem ruído');
legend('x[n]','y[n]','Location','northwest');

%================================= NOISE ==================================

r = rand(1,numel(xn)).*0.4-0.2; % Gerar ruido
xnr = xn + r;
ynr = b0*atrasa(xnr,0)+b1*atrasa(xnr,1)+b2*atrasa(xnr,2)+b3*atrasa(xnr,3)+b4*atrasa(xnr,4);
figure
plot(n,xn,n,xnr,n,yn,n,ynr)
xlabel('n');
title('Resposta do sistema ao sinal sem ruído');
legend('x[n]','xr[n]','y[n]','yr[n]','Location','northwest');

%=================================== EX2 ==================================

x2n = x(2*n-4);
y2n = 0.6*x2n;
y3n = 0.5*atrasa(xn,2).*atrasa(xn,3);
y4n = (n-2).*atrasa(xn,3);

figure

subplot(4,1,1)
plot(n,xn,n,yn)
xlabel('n')
title('y1')

subplot(4,1,2)
plot(n,xn,n,y2n)
xlabel('n')
title('y2')

subplot(4,1,3)
plot(n,xn,n,y3n)
xlabel('n')
title('y3')

subplot(4,1,4)
plot(n,xn,n,y4n)
xlabel('n')
title('y4')

%========================= TESTAR A LINEARIDADE =====================
%================================= y1 ===============================
a = 3;
b = 5;

% Escolher as duas aleatorias e nunca usar outras
x1n = sin(0.1*pi*n);
x2n = cos(0.1*pi*n);

y1n = b0*atrasa(x1n,0)+b1*atrasa(x1n,1)+b2*atrasa(x1n,2)+b3*atrasa(x1n,3)+b4*atrasa(x1n,4);
y2n = b0*atrasa(x2n,0)+b1*atrasa(x2n,1)+b2*atrasa(x2n,2)+b3*atrasa(x2n,3)+b4*atrasa(x2n,4);

y1c = a * y1n + b * y2n;
xc = a * x1n + b * x2n;

y1xc = b0*atrasa(xc,0)+b1*atrasa(xc,1)+b2*atrasa(xc,2)+b3*atrasa(xc,3)+b4*atrasa(xc,4);

figure
plot(n,y1c,n,y1xc,'k--')
title('Comparação para y1')

%============================================= y2 ====================

x1_2n = sin(0.1*pi*2*(2*n-4));
x2_2n = cos(0.1*pi*2*(2*n-4));

y2n1 = 0.6*x1_2n;
y2n2 = 0.6*x1_2n;

y2c = a*y2n1+b*y2n2;

xc = a*x1_2n + b*x2_2n;

y2xc = 0.6*xc;

figure
plot(n,y2n,n,y2xc,'k--')
title('Comparação para y2')

%================================== y3 ===============================

y3n1 = 0.5*atrasa(x1n,2).*atrasa(x1n,3);
y3n2 = 0.5*atrasa(x2n,2).*atrasa(x2n,3);

y3c = a*y3n1+b*y3n2;

xc = a*x1n+b*x2n;

y3xc = 0.5*atrasa(xc,2).*atrasa(xc,3);

figure
plot(n,y3n,n,y3xc,'k--')
title('Comparação para y3')

%============================ y4 =======================================

y4n1 = (n-2).*atrasa(x1n,3);
y4n2 = (n-2).*atrasa(x2n,3);

y4c = a * y4n1 + b * y4n2;
xc = a * x1n + b * y2n;

y4xc = (n-2).*atrasa(xc,3);

figure
plot(n,y4n,n,y4xc,'k--')
title('Comparação para y4')

%=========================== Invariância ==============================
%=============================== y1 ===================================
k = 5;
xn = sin(0.1*pi*n);

y1n = b0*atrasa(xn,0) + b1*atrasa(xn,1) + b2*atrasa(xn,2) + b3*atrasa(xn,3) + b4*atrasa(xn,4);
y1na = atrasa(y1n,4);

% Calcular a entrada atrasada
xn = atrasa(xn, k);

% Calcular a saída com entrada atrasada
y1n = b0*atrasa(xn,0) + b1*atrasa(xn,1) + b2*atrasa(xn,2) + b3*atrasa(xn,3) + b4*atrasa(xn,4);

% Para ser invariante y1na == y1n
figure
plot(n,y1na,n,y1n,'k--')
title('Teste invariância para y1')

%==================================== y2 =============================

x2n = sin(0.1*pi*(2*n-4));
y3n = 0.6.*x2n;
%P1 dos slides
% Calcular a saida com entrada atrasada
x2n = sin(0.1*pi*(2*n-4)-k);
y3xa = 0.6.*x2n;
%P2 dos slides
% Calcular saida atrasada
y3na = atrasa(y3n,k);
% Para ser invariante y1na == y1n
%P3 dos slides
figure
plot(n,y3na,n,y3xa,'k--')
title('Teste invariância para y2')
legend('Saida atrasada','Saída da entrada atrasada')

%================================== y3 ================================

x3n1 = sin(0.1*pi*atrasa(xn,2));
x3n2 = sin(0.1*pi*atrasa(xn,3));

x3n = 0.5 * atrasa(xn,2).*atrasa(xn,3);

% Calcular a entrada atrasada
y3na = atrasa(xn,k);

% Calcular a saida com entrada atrasada
xn = atrasa(xn,k);
y3n = 0.5*atrasa(xn,2).*atrasa(xn,3);

figure
plot(n,y3na,n,y3n,'k--')
title('Teste invariância para y3')

%=================================== y4 ================================

xn = sin(0.1*pi*n);
y4n = (n-2).*atrasa(xn,3);

% Calcular a entrada atrasada
y4na = atrasa(y4n,k);

% Calcular a saida com entrada atrasada
xn = atrasa(xn,k);
y4n = (n-2).*atrasa(xn,3);

figure
plot(n,y4na,n,y4n,'k--')
title('Teste invariância para y4')

%======================= Resposta Impulsional h1 =======================

xn = zeros(1,numel(n));
ix = find(n==0);
xn(ix) = 1;

hn = b0*atrasa(xn,0)+b1*atrasa(xn,1)+b2*atrasa(xn,2)+b3*atrasa(xn,3)+b4*atrasa(xn,4);
figure
stem(n,hn)
title('Resposta impulsional de y1[n]')
xlabel('n')

%========================= Resposta do sistema com base em h1 =========

n = -50:50;
xn = x(n);
y1n = conv(xn,hn,'same');
figure
stem(n,xn)
hold on
stem(n,y1n)
title('y1[n]')
xlabel('n')