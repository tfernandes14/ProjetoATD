function int = simpIntV2(fun,t1,tn,h)
    % Obter o valor da funçao nos extremos de integração, i.e., em t1 e tn
    ft1 = double(subs(fun,t1));
    ftn = double(subs(fun,tn));
    % Obter o valor da função nos pontos intermédios separados por h
    % unidade de tempo para i par
    tvp = t1+h:2*h:tn-h;
    sfp = sum(double(subs(fun,tvp)));
    
    % Para i impar
    tvi = t1+2*h:2*h:tn-h;
    sfi = sum(double(subs(fun,tvi)));
    
    % Calcular o valor final do integral
    int = (h/3)*(ft1+ftn+4*sfp+2*sfi);
end