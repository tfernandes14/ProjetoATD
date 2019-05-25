function plot_windows(n_plots, aac_x, aac_y, aac_z, Fs)
posgraf=1;
for z=1:n_plots
    if z==1 %para x
        for i=1:3
            subplot(3,3,posgraf);
            for j=1:size(aac_x, 2)
                N= length(aac_x{i,j});

               if (mod(N,2) == 0)
                    f = -Fs/2:Fs/N:Fs/2-Fs/N;
               else
                    f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
               end

                plot(f, aac_x{i,j})     
                ylabel('aac_x');

                    %TITULO DA FIGURA????????????????????????????????
    %CADA SUBPLOT:WALKING WALKING UP WALKING DOWN
    
                hold on
            end
            posgraf=posgraf+1;            
        end

    end
    if z==2 %para y
        for i=1:3
            subplot(3,3,posgraf);
            for j=1:size(aac_y, 2)
                N= length(aac_y{i,j});

               if (mod(N,2) == 0)
                    f = -Fs/2:Fs/N:Fs/2-Fs/N;
               else
                    f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
               end

                plot(f, aac_y{i,j})
                hold on
            end
            posgraf=posgraf+1;        
        end
    end
    if z==3%para z
        for i=1:3
            subplot(3,3,posgraf);
            for j=1:size(aac_z, 2)
                N= length(aac_z{i,j});

               if (mod(N,2) == 0)
                    f = -Fs/2:Fs/N:Fs/2-Fs/N;
               else
                    f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
               end

                plot(f, aac_z{i,j})
                
                hold on
            end
            posgraf=posgraf+1;
        end
    end
end