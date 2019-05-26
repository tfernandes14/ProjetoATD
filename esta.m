function esta(valores, eixo)
    for i=1:12
        for k=1:10
            j=1;
            while(isempty(valores{eixo, k}{i,j})~=1)
                numPeaksCima= size(findpeaks(valores{eixo,k}{i,j},'MinPeakHeight',2),1);
                maxPeaks= max(findpeaks(valores{eixo,k}{i,j}));
                numPeaksAbaixo= size(findpeaks(valores{eixo,k}{i,j}),1) - numPeaksCima;
                switch i
                    case 1
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'X','color', 'red');
                    case 2
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'X','color', 'blue');
                    case 3
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'X','color', 'green');
                    case 4
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'o','color', 'red');
                    case 5
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'o', 'color','blue');
                    case 6
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, 'o','color', 'green');
                    case 7
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, '*','color', 'red');
                    case 8
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, '*', 'color','green');
                    case 9
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, '*','color', 'yellow');
                    case 10
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, '*','color', 'black');
                    case 11
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, '*','color', 'cyan');
                    case 12
                        plot3(numPeaksCima, maxPeaks, numPeaksAbaixo, '*','color', 'magenta');            
                end
                hold on;
                j=j+1;
            end

        end
    end

end

