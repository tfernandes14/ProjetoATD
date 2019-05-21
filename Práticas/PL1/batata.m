%EX4
% x = -4:0.01:4;
% y = -4:0.01:4;
% [X, Y] = meshgrid(x,y);
% Z = sin(X.*Y)+cos(X);
% mesh(X, Y, Z)

%EX5
% t = 0:10;
% y = [0 0.7 2.4 3.1 4.2 4.8 5.7 5.9 6.2 6.4 6.3]
% p = polyfit(t,y,2)
% t2 = 0:0.01:10;
% ye = polyval(p,t2);
% plot(t,y,'o',t2,ye,'r')
% xlabel('Tempo(s)')
% ylabel('y(t)')
% legend('dados originais', 'ajuste de 2º ordem', 'Location', 'northwest')

%EX6
x = 7;
fatorial = 1;
for i = x:-1:1
    fatorial = fatorial * i;
end
disp(fatorial)