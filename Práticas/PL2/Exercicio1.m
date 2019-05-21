function Exercicio1

clear all
close all
PL=3;
A1 = 2 * (mod(PL,2) +1) %4
A2 = 6 * (mod(PL,2) +1) %12
Wa = mod(PL,5) +2 %5
Wb = mod(PL,7) +7 %10
Wc = mod(PL,9) +1 %4

%X1 = A1sin(Wat)cos(Wbt) + A2cos^2(Wct)
%X1 = 4sin(5t)cos(10t) + 12cos^2(4t) 
%X1 = (4/2) * (sin(15t) + sin(-5t) + (12/2) (1+ cos(8t))
%X1 = 2 sin(15t) + 2sin(-5t) + 6 + 6cos(8t)
%X1 = 2 sin(15t) - 2sin(5t) + 6 + 6cos(8t)
%X1 = 2 cos(15t-PI/2) - 2sin(5t-PI/2) + 6 + 6cos(8t)
%X1 = 2 cos(15t-PI/2) + 2cos(5t-PI/2+PI) + 6 + 6cos(8t)
%X1 = 6 cos(0t+0) + 2COS(5t+PI/2) + 6cos(8t) + 2cos(15t-PI/2)

%W1 = 0 rad/s,  W2= 5 rad/s, W3= 8 rad/s, W4= 15 rad/s

%W0 = M.D.C {5,8,15} = 1
%f0 = w0/2PI = 1 / 2PI Hz
%T0 = 1/f0 = 2PIs

%1.1
syms t
x1ts = A1*sin(Wa*t)*cos(Wb*t)+A2*cos(Wc*t)^2;

w0=1;
f0=w0/(2*pi);
T0=1/f0;
C=[6 0 0 0 0 2 0 0 6 0 0 0 0 0 0 2];
Teta= [0 0 0 0 0 pi/2 0 0 0 0 0 0 0 0 0 -pi/2];

tv = [-T0/2:0.01:T0/2];
xltsCos=zeros(1,numel(tv));
for m=1:numel(C)
    xltsCos=xltsCos+C(m)*cos((m-1)*w0*tv+Teta(m));
end

figure;fplot(x1ts,[-T0/2,T0/2],'linewidth',3);
hold on
plot(tv,xltsCos,'--','linewidth',3)
axis([-T0/2 T0/2 min(xltsCos) max(xltsCos)])
grid on
grid minor
set(gca,'fontsize',20,'fontweight','bold','linewidth',3)
%axis([-10 10 -5 5])
xlabel('t')
ylabel('x1(t)')
title('x1(t)')


%1.2
x1_ts = subs(x1ts,'t',-t);

%1.3
Ts=0.1;
syms n
x1ns=subs(x1ts,n*Ts);
%Representaçao grafica
t=linspace(-pi,-pi,100);
n=round(-pi/Ts):round(pi/Ts);

x1t=double(subs(x1ts));

x1n=double(subs(x1ns));

plot(t,x1t,'--',n*Ts,x1n,'o')
xlabel('tempo [s]')
ylabel('Amplitude de x1(t) e x1[n]')
title('Gráficos de x1(t) e x1[n]')
legend('x1(t)','x1(t) decomposto','x1[n]')









end