function exercicio4_5(valores)
for i=1:3
    j=1;
    while(isempty(valores{i,j})~=1)
        numPeaksCima= size(findpeaks(valores{i,j},'MinPeakHeight',2),1);
        maxPeaks= max(findpeaks(valores{i,j}));
        numPeaksAbaixo= size(findpeaks(valores{i,j}),1) - numPeaksCima;
        switch i
            case 1
                plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'X', 'color', 'green');
            case 2
                plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, '*', 'color', 'blue');
            case 3
                plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'o', 'color', 'red');          
        end
        hold on;
        j=j+1;
    end

end

end

