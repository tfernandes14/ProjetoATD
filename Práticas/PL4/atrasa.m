function sa = atrasa(sig, samp)

% Isto e como fazer um shift left
sa = [zeros(1, samp), sig(1: end - samp)];

end