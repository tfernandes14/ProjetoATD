function sig = x(n)

ix = union(find(n < -40), find(n > 40)); %Obter indices onde u(n+40)-u(n-40) e faz a uniao dos 2

sig = 1.5 * sin(0.025 * pi * n);

sig(ix) = 0; % Impor que o sinal deve ser zero nos valores do u(n+40)-u(n-40)

end