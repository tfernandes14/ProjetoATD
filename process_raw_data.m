function process_raw_data(expr, usr)
%TITULO DOS GRAFICOS
close all
clc
Sensors={'ACC_X','ACC_Y','ACC_Z'};
activities={'W','WU','WD','S','ST','L','STSit','SitTS','SitTL','LTSit','STL','LTS'};
Fs=50;  % Frequencia da amostragem

% -------------------- EXERC?CIO 2 --------------------
txtFile = strcat('acc_exp',expr,'_user',usr,'.txt');
dacc=read_raw_data(txtFile);

% Le o ficheiro das labels
all_labels=read_labels('labels.txt');

% Vai buscar as labels que interessam
ix_labels=intersect(find(all_labels(:,1)==str2num(expr)),find(all_labels(:,2)==str2num(usr)));

data=dacc;
% Cria um vetor tempo
t=(0:size(data,1)-1)./Fs;

[n_points,n_plots]=size(data);

% -------------------- EXERC?CIO 3 --------------------

aac_x = cell(12, numel(ix_labels));
aac_y = cell(12, numel(ix_labels));
aac_z = cell(12, numel(ix_labels));

% Fazer um plot de todos os canais (x,y,z)
figure(1)
for i=1:n_plots
    subplot(n_plots,1,i);
    plot(t./60,data(:,i),'k--');
    axis([0 t(end)./60 min(data(:,i)) max(data(:,i))])
    xlabel('Time (min)', 'fontsize', 16, 'fontweight', 'bold');
    ylabel(Sensors{i}, 'fontsize', 16, 'fontweight', 'bold');
    hold on
    contador = [1 1 1 1 1 1 1 1 1 1 1 1];
    for j=1:numel(ix_labels)    % Put activity labels on each sub(???)
        plot(t(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5))./60, data(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5),i))
        if mod(j,2) == 1    % Intercalate labels to avoid superposi(???)
            ypos=min(data(:,i))-(0.2*min(data(:,i)));
        else
            ypos=max(data(:,i))-(0.2*min(data(:,i)));
        end
        %calcular a fft
        tipo_movimento = all_labels(ix_labels(j),3);
        aux = abs(fftshift(fft([zeros(1000,1);(detrend(data(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5),i)))])));
        if i == 1
            aac_x{tipo_movimento, contador(tipo_movimento)} = aux;
            contador(tipo_movimento) = contador(tipo_movimento)+1;
        end
         if i == 2
            aac_y{tipo_movimento, contador(tipo_movimento)} = aux;
            contador(tipo_movimento) = contador(tipo_movimento)+1;
        end
        if i == 3
            aac_z{tipo_movimento, contador(tipo_movimento)} = aux;
            contador(tipo_movimento) = contador(tipo_movimento)+1;
        end
        text(t(all_labels(ix_labels(j),4))/60,ypos,activities{all_labels(ix_labels(j),3)});
    end
    hold off
end

% -------------------- EXERC?CIO 4 --------------------
%4.1
figure(2)
plot_windows(n_plots, aac_x, aac_y, aac_z, Fs)

%varias janelas

aac_x_hamming = cell(12, numel(ix_labels));
aac_y_hamming = cell(12, numel(ix_labels));
aac_z_hamming = cell(12, numel(ix_labels));

for i=1:n_plots
    contador = [1 1 1 1 1 1 1 1 1 1 1 1];
    for j=1:numel(ix_labels)   

        %fazer a concatena?ao dos zeros estamos a aumentar o padding e
        %assim as curvas tornam-se mais suaves o que permite uma melhor
        %compara??o que ira ser usasda para o relatorio  ps: nao esquecer
        %que ? necessario fazer ? dft tambem a comcatena?ao do array de
        %zeros como mostra o exemplo abaixo
        
        %NAO METER OS GRAFICOS TODOS JUNTOS TEMOS DE SEPARA-LOS MAS TAMBEM
        %NAO PERCISAMOS DE MOSTRAR TODOS SO OS DO MOVIMENTO
        tipo_movimento = all_labels(ix_labels(j),3);
        x=data(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5),i);
        aux = abs(fftshift(fft([zeros(1000,1);(hamming(all_labels(ix_labels(j),5) -all_labels(ix_labels(j),4)+1).*detrend(x))])));
        if i == 1
            aac_x_hamming{tipo_movimento, contador(tipo_movimento)} = aux;
            contador(tipo_movimento) = contador(tipo_movimento)+1;
        end
        if i == 2
            aac_y_hamming{tipo_movimento, contador(tipo_movimento)} = aux;
            contador(tipo_movimento) = contador(tipo_movimento)+1;
        end
        if i == 3
            aac_z_hamming{tipo_movimento, contador(tipo_movimento)} = aux;
            contador(tipo_movimento) = contador(tipo_movimento)+1;
        end
    end
end

figure(3)
plot_windows(n_plots, aac_x_hamming, aac_y_hamming, aac_z_hamming, Fs)


aac_x_hann = cell(12, numel(ix_labels));
aac_y_hann = cell(12, numel(ix_labels));
aac_z_hann= cell(12, numel(ix_labels));

for i=1:n_plots
    contador = [1 1 1 1 1 1 1 1 1 1 1 1];
    for j=1:numel(ix_labels)    
        %fazer a concatena?ao dos zeros estamos a aumentar o padding e
        %assim as curvas tornam-se mais suaves o que permite uma melhor
        %compara??o que ira ser usasda para o relatorio  ps: nao esquecer
        %que ? necessario fazer ? dft tambem a comcatena?ao do array de
        %zeros como mostra o exemplo abaixo
        
        %NAO METER OS GRAFICOS TODOS JUNTOS TEMOS DE SEPARA-LOS MAS TAMBEM
        %NAO PERCISAMOS DE MOSTRAR TODOS SO OS DO MOVIMENTO
        tipo_movimento = all_labels(ix_labels(j),3);
        aux = abs(fftshift(fft([zeros(1000,1);(hann(all_labels(ix_labels(j),5) -all_labels(ix_labels(j),4)+1).*detrend(data(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5),i)))])));
        if i == 1
            aac_x_hann{tipo_movimento, contador(tipo_movimento)} = aux;
            contador(tipo_movimento) = contador(tipo_movimento)+1;
        end
        if i == 2
            aac_y_hann{tipo_movimento, contador(tipo_movimento)} = aux;
            contador(tipo_movimento) = contador(tipo_movimento)+1;
        end
        if i == 3
            aac_z_hann{tipo_movimento, contador(tipo_movimento)} = aux;
            contador(tipo_movimento) = contador(tipo_movimento)+1;
        end
    end
end

figure(4)
plot_windows(n_plots, aac_x_hann, aac_y_hann, aac_z_hann, Fs)

aac_x_blackman = cell(12, numel(ix_labels));
aac_y_blackman = cell(12, numel(ix_labels));
aac_z_blackman = cell(12, numel(ix_labels));

for i=1:n_plots
    contador = [1 1 1 1 1 1 1 1 1 1 1 1];
    for j=1:numel(ix_labels)    
        %fazer a concatena?ao dos zeros estamos a aumentar o padding e
        %assim as curvas tornam-se mais suaves o que permite uma melhor
        %compara??o que ira ser usasda para o relatorio  ps: nao esquecer
        %que ? necessario fazer ? dft tambem a comcatena?ao do array de
        %zeros como mostra o exemplo abaixo
        tipo_movimento = all_labels(ix_labels(j),3);
            aux = abs(fftshift(fft([zeros(1000,1);(blackman(all_labels(ix_labels(j),5) -all_labels(ix_labels(j),4)+1).*detrend(data(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5),i)))])));
        if i == 1
            aac_x_blackman{tipo_movimento, contador(tipo_movimento)} = aux;
            contador(tipo_movimento) = contador(tipo_movimento)+1;
        end
        if i == 2
            aac_y_blackman{tipo_movimento, contador(tipo_movimento)} = aux;
            contador(tipo_movimento) = contador(tipo_movimento)+1;
        end
        if i == 3
            aac_z_blackman{tipo_movimento, contador(tipo_movimento)} = aux;
            contador(tipo_movimento) = contador(tipo_movimento)+1;
        end
    end
end

figure(5)
plot_windows(n_plots, aac_x_blackman, aac_y_blackman, aac_z_blackman, Fs)


%4.2

disp(txtFile)

disp('retangular x');
passos(aac_x);
disp('retangular y')
passos(aac_y);
disp('retangular z')
passos(aac_z)

disp('hamming x');
passos(aac_x_hamming);
disp('hamming y')
passos(aac_y_hamming);
disp('hamming z')
passos(aac_z_hamming)

disp('hann x');
passos(aac_x_hann);
disp('hann y')
passos(aac_y_hann);
disp('hann z')
passos(aac_x_hann)

disp('blackman x');
passos(aac_x_blackman);
disp('blackman y')
passos(aac_y_blackman);
disp('blackman z')
passos(aac_z_blackman)
