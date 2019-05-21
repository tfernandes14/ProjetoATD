function int = trapIntV2(fun, t1, tn, h)
    tv = t1+h:h:tn-h; % Obter valores intermedios de tempo
    % Obter valores extremos
    ft1 = double(subs(fun, t1));
    ftn = double(subs(fun, tn));
    % Calcular o integral
    int = h*(((ft1+ftn)/2)+sum(double(subs(fun,tv))));
end