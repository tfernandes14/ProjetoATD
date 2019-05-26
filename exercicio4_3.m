function exercicio4_3(valores, eixo)
    for i=1:12
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
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'X', 'color', 'green');
                    case 3
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'X', 'color', 'green');
                    case 4
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'o', 'color', 'black');
                    case 5
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'o', 'color', 'black');
                    case 6
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'o', 'color', 'black');
                    case 7
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'o', 'color', 'black');
                    case 8
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'o', 'color', 'black');
                    case 9
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'o', 'color', 'black');
                    case 10
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'o', 'color', 'black');
                    case 11
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'o', 'color', 'black');
                    case 12
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'o', 'color', 'black');            
                end
                hold on;
                j=j+1;
            end
        end
    end

end

