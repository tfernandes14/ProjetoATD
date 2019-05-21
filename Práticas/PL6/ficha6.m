clear all
close all

%1.1.1
T0=input('Introduza o per�odo fundamental: ');

%1.1.2
t=0:T0/500:T0-T0/500; % ==> linspace(0,T0,500)

%1.1.3
opt=menu('Sinal x(t)', 'Onda quadrada', 'Dente de serra', 'Express�o');
switch opt
    case 1
        x=square(2*pi/T0*t);
        syms t
        xt=heaviside(t)-2*heaviside(t-T0/2);
        t=0:T0/500:T0-T0/500;
        %x=double(subs(xt));
    case 2
        x=sawtooth(2*pi/T0*t);
        syms t
        xt=(t-T0/2)*2/T0;
        t=0:T0/500:T0-T0/500;
        %x=double(subs(xt));
    otherwise
        syms t
        xt=input('x(t) = ');
        t=0:T0/500:T0-T0/500;
        x=double(subs(xt));
end

figure(1)
plot(t,x)
title('Sinal peri�dico de tempo cont�nuo x(t)')
xlabel('Tempo (s)')
ylabel('Amplitude')

m_max=input('Valor de m_max (default=50): ');
if isempty(m_max)
    m_max = 50;
end

%1.1.4
[Cm, tetam] = SerieFourier(t',x',T0, m_max);
m=0:m_max;
figure(2)
subplot(2,1,1)
plot(m,Cm,'bo');
title('Coeficientes da S�rie de Fourier trignom�trica')
ylabel('Cm');
xlabel('m');
subplot(2,1,2);
plot(m,tetam,'bo');
ylabel('tetam (rad)');
xlabel('m');

%1.1.5
figure(3)
plot(t,x,'r');
hold on

mt=input('Valores limites de m (como vetor): ');
if isempty(mt)
    mt=[0 1 3 5 10 50];
end

for k=1:length(mt)
    x1=zeros(size(t));
    for m=0:mt(k)
        x1=x1+Cm(m+1)*cos(m*2*pi/T0*t+tetam(m+1));
    end
    plot(t,x1,'-.b');
end
hold 	

%1.1.6
cm=[flip(Cm(2:end)/2.*exp(-j*tetam(2:end)));Cm(1)*cos(tetam(1));Cm(2:end)/2.*exp(j*tetam(2:end))];

%1.5
syms t m
cms=int(xt*exp(-j*m*2*pi*t/T0)/T0,t,0,T0);
cm1=[];
for m=-m_max:m_max
    cm1=[cm1; double(limit(cms,m))];
end

figure(4)
subplot(211)
plot(-m_max:m_max,abs(cm),'bo',-m_max:m_max,abs(cm1),'g+')
title('Coeficientes da S�rie de Fourier complexa')
ylabel('abs(cm)')
xlabel('m')
subplot(212)
plot(-m_max:m_max,angle(cm),'bo',-m_max:m_max,angle(cm1),'g+')
ylabel('angle(cm)')
xlabel('m')