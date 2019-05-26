function exercicio4_5(valores, eixo)
    for i=1:3
        for k=1:10
            j=1;
            while(isempty(valores{eixo,k}{i,j})~=1)
                numPeaksCima= size(findpeaks(valores{eixo,k}{i,j},'MinPeakHeight',2),1);
                maxPeaks= max(findpeaks(valores{eixo,k}{i,j}));
                numPeaksAbaixo= size(findpeaks(valores{eixo,k}{i,j}),1) - numPeaksCima;
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

end

