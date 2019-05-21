% Ficha pratica nº 5 de ATD 2019
% Exercicios
 clear all
 close all
 b3=0.3;
 b4=-0.18;
 a1=-1.5;
 a2=0.56;
 b=[0 0 0 b3 b4]
 a=[1 a1 a2 0 0]
 
 % Ex1.1
 syms z
 disp("Função de transferencia G(Z):")
 Gz=(b3*z^-3+b4*z^-4)/(1+a1*z^-1+a2*z^-2);
 pretty(Gz)
 
 % Ex1.2
 disp("Zeros:")
 zGz=roots(b)
 disp("Polos:")
 pGz=roots(a)
 
 figure(1)
 zplane(b,a)
 
 % Ex1.3
 if all(abs(pGz)<1)
     disp("Sistema estável")
 else
     disp("Sistema instável")
 end
 
 % Ex1.4
 disp("Ganho do sistema:")
 ddcgain(b,a)
 
 % Ex1.5
 disp("Expressao de h[n]")
 Hz = Gz;
 syms n
 hn=iztrans(Hz);
 pretty(hn)
 
 [r,p,k]=residuez([b3 b4],[1 a1 a2])
 H2z_r=z^-3*(r(1)/(1-p(1)*z^-1))+z^-3*(r(2)/(1-p(2)*z^-1))
 h2n_r=iztrans(H2z_r)
 pretty(h2n_r)
 nv = 0:50;
 stem(nv, double(subs(hn,n,nv)))
 hold on
 
 stem(nv,double(subs(h2n_r,n,nv)),'+')
 title("Resposta a impulso do sistema via iztrans (o) e residuos")
 xlabel('n')
 
 % Ex1.6
 n=0:50;
 h=double(subs(hn));
 h1 = dimpulse(b,a,length(n));
 
 figure(2)
 stem(n,h,'o')
 hold on
 stem(n,h1,'+')
 hold off
 title("Resposta a impulso do sistema via iztrans(o) e dimpulse")
 xlabel('n')
 
 % Ex1.7
 S2 = sum(abs(h))
 disp("O sistema e estável pq sum(h[n]) é finita")
 disp("O sistema e causal pq h[n]=0 para n < 0")
 
 % Ex1.8
 syms n
 sympref('HeavisideAtOrigin',1)
 Xz=ztrans(heaviside(n))
 disp("Transformada de Z de x[n]:")
 pretty(Xz)
 
 Yz=Hz*Xz;
 yn=iztrans(Yz);
 disp("Expressão de y[n]:")
 pretty(yn)
 
 % Ex1.9
 nv=0:50;
 y = double(subs(yn,n,nv));
 y1=dstep(b,a,length(nv));
 
 figure(3)
 stairs(nv,y,'-o')
 hold on
 stairs(nv,y1,'-+')
 hold off
 
 % Ex1.10
 disp("y[infinito] = ")
 yinf=double(limit((1-z^-1)*Yz,1))
 yinf1=double(limit(yn,inf))
 y(end)
 
 % Ex1.11
 syms n
 xn=3*(heaviside(n-2)-heaviside(n-10));
 Xz=ztrans(xn);
 disp("Transformada de Z de x[n]:")
 pretty(Xz)
 
 Yz=Hz*Xz;
 yn=iztrans(Yz);
 
 n=0:50;
 y=double(subs(yn));
 x=double(subs(xn));
 y1=dlsim(b,a,x);
 
 figure(4)
 stairs(n,x,'-*')
 hold on
 stairs(n,y,'-+')
 stairs(n,y1,'-o')
 hold off
 title("Resposta a um pulso do sistema via h[n] (o) e dlsim(+)")
 xlabel('n');
 
 % Ex1.12
 syms o
 Homega=subs(Hz,z,exp(j*o));
 disp("Expressão de H(omega):")
 pretty(Homega)
 
 o = linspace(0,pi,100);
 Ho_abs=double(subs(abs(Homega)));
 Ho_ang=double(subs(angle(Homega)));
 
 figure(5)
 subplot(211)
 plot(o/pi,20*log10(Ho_abs))
 grid
 ylabel('dB')
 xlabel("Frequencia normalizada(x pi)")
 title("Resposta em frequencia do sistema")
 subplot(212)
 plot(o/pi,180*unwrap(Ho_ang)/pi)
 grid
 ylabel('graus')
 xlabel('Frequencia normalizada (x pi)')
 
 figure(6)
 freqz(b,a)
 
 % Ex1.13
 disp("Valor de H(0):")
 M=abs(double(subs(Homega,0)))
 A=angle(double(subs(Homega,0)))
 
 % Ex1.14
 syms n
 xn=2*sin(0.1*pi*n);
 Xz=ztrans(xn);
 Yz=Hz*Xz;
 yn=iztrans(Yz);
 
 %------Usando o dlsim------
 n=0:50;
 x=double(subs(xn,n));
 y=double(subs(yn));
 y1=dlsim(b,a,x);
 
 %------Usando o H(o)-------
 disp("Valor de (0.1*pi):")
 Ho_abs1=double(subs(abs(Homega),0.1*pi))
 Ho_abs1dB=29*log10(Ho_abs1)
 Ho_ang1=double(subs(angle(Homega),0.1*pi))
 Ho_ang1deg=180*Ho_ang1/pi
 
 y2=Ho_abs1*2*sin(0.1*pi*n+Ho_ang1);
 
 figure(7)
 stairs(n,x,'.');
 hold on
 stairs(n,y,'+')
 stairs(n,y1,'o')
 stairs(n,y2,'*')
 hold off
 title("Resposta do sistema a uma sinusoide via H[z] (+), dlsim")