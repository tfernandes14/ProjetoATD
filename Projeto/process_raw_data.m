close all
clear all
clc

Expr={'21','22','23','24','25','26','27','28','29','30'};
User={'10','11','12','13','14','15'};
Sensors={'ACC_X','ACC_Y','ACC_Z'};
activities={'W','WU','WD','S','ST','L','STSit','SitTS','SitTL','LTSit','STL','LTS'};
Fs=50;  % Frequencia da amostragem

% -------------------- EXERCÍCIO 2 --------------------
dacc=read_raw_data('acc_exp23_user11.txt');

% Le o ficheiro das labels
all_labels=read_labels('labels.txt');

% Vai buscar as labels que interessam
ix_labels=intersect(find(all_labels(:,1)==str2num('23')),find(all_labels(:,2)==str2num('11')));

data=dacc;
% Cria um vetor tempo
t=(0:size(data,1)-1)./Fs;

[n_points,n_plots]=size(data);

% -------------------- EXERCÍCIO 3 --------------------

aac_x = cell(1, numel(ix_labels));
aac_y = cell(1, numel(ix_labels));
aac_z = cell(1, numel(ix_labels));

% Fazer um plot de todos os canais (x,y,z)
figure(1)
for i=1:n_plots
    subplot(n_plots,1,i);
    plot(t./60,data(:,i),'k--');
    axis([0 t(end)./60 min(data(:,i)) max(data(:,i))])
    xlabel('Time (min)', 'fontsize', 16, 'fontweight', 'bold');
    ylabel(Sensors{i}, 'fontsize', 16, 'fontweight', 'bold');
    hold on
    for j=1:numel(ix_labels)    % Put activity labels on each sub(???)
        plot(t(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5))./60, data(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5),i))
        if mod(j,2) == 1    % Intercalate labels to avoid superposi(???)
            ypos=min(data(:,i))-(0.2*min(data(:,i)));
        else
            ypos=max(data(:,i))-(0.2*min(data(:,i)));
        end
        %calcular a fft
        aux = abs(fftshift(fft(data(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5),i))));
        if i == 1
            aac_x{1, j} = aux;
        end
        if i == 2
            aac_y{1, j} = aux;
        end
        if i == 3
            aac_z{1, j} = aux;
        end
        text(t(all_labels(ix_labels(j),4))/60,ypos,activities{all_labels(ix_labels(j),3)});
    end
    hold off
end

% -------------------- EXERCÍCIO 4 --------------------

figure(2)
for i=1:numel(ix_labels)
   N= length(aac_x{1,i});
   if (mod(N,2) == 0)
        f = -Fs/2:Fs/N:Fs/2-Fs/N;
   else
        f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
   end
   plot(f, aac_x{1,i})
   title("Frequências da DFT com a janela retangular")
   hold on
end

%varias janelas

aac_x_janelas = cell(1, numel(ix_labels));
aac_y_janelas = cell(1, numel(ix_labels));
aac_z_janelas = cell(1, numel(ix_labels));
for i=1:n_plots
    for j=1:numel(ix_labels)    
        %fazer a concatenaçao dos zeros estamos a aumentar o padding e
        %assim as curvas tornam-se mais suaves o que permite uma melhor
        %comparação que ira ser usasda para o relatorio  ps: nao esquecer
        %que é necessario fazer À dft tambem a comcatenaçao do array de
        %zeros como mostra o exemplo abaixo
        
        %NAO METER OS GRAFICOS TODOS JUNTOS TEMOS DE SEPARA-LOS MAS TAMBEM
        %NAO PERCISAMOS DE MOSTRAR TODOS SO OS DO MOVIMENTO
        aux = abs(fftshift(fft([zeros(1000,1);(hamming(all_labels(ix_labels(j),5) -all_labels(ix_labels(j),4)+1).*data(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5),i))])));
        if i == 1
            aac_x_janelas{1, j} = aux;
        end
        if i == 2
            aac_y_janelas{1, j} = aux;
        end
        if i == 3
            aac_z_janelas{1, j} = aux;
        end
    end
end

figure(3)
for i=1:numel(ix_labels)
    N= length(aac_x_janelas{1,i});
   
   if (mod(N,2) == 0)
        f = -Fs/2:Fs/N:Fs/2-Fs/N;
   else
        f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
    end
    plot(f, aac_x_janelas{1,i})
    title("Janela de Hamming")
    hold on
end

figure(4)
for i=1:n_plots
    for j=1:numel(ix_labels)    
        %fazer a concatenaçao dos zeros estamos a aumentar o padding e
        %assim as curvas tornam-se mais suaves o que permite uma melhor
        %comparação que ira ser usasda para o relatorio  ps: nao esquecer
        %que é necessario fazer À dft tambem a comcatenaçao do array de
        %zeros como mostra o exemplo abaixo
        
        %NAO METER OS GRAFICOS TODOS JUNTOS TEMOS DE SEPARA-LOS MAS TAMBEM
        %NAO PERCISAMOS DE MOSTRAR TODOS SO OS DO MOVIMENTO
        aux = abs(fftshift(fft([zeros(1000,1);(blackman(all_labels(ix_labels(j),5) -all_labels(ix_labels(j),4)+1).*data(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5),i))])));
        if i == 1
            aac_x_janelas{1, j} = aux;
        end
        if i == 2
            aac_y_janelas{1, j} = aux;
        end
        if i == 3
            aac_z_janelas{1, j} = aux;
        end
    end
end


for i=1:numel(ix_labels)
    N= length(aac_x_janelas{1,i});
   
   if (mod(N,2) == 0)
        f = -Fs/2:Fs/N:Fs/2-Fs/N;
   else
        f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
    end
    plot(f, aac_x_janelas{1,i})
    hold on
end

figure(5)
for i=1:n_plots
    for j=1:numel(ix_labels)    
        %fazer a concatenaçao dos zeros estamos a aumentar o padding e
        %assim as curvas tornam-se mais suaves o que permite uma melhor
        %comparação que ira ser usasda para o relatorio  ps: nao esquecer
        %que é necessario fazer À dft tambem a comcatenaçao do array de
        %zeros como mostra o exemplo abaixo
        
        %NAO METER OS GRAFICOS TODOS JUNTOS TEMOS DE SEPARA-LOS MAS TAMBEM
        %NAO PERCISAMOS DE MOSTRAR TODOS SO OS DO MOVIMENTO
        aux = abs(fftshift(fft([zeros(1000,1);(hann(all_labels(ix_labels(j),5) -all_labels(ix_labels(j),4)+1).*data(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5),i))])));
        if i == 1
            aac_x_janelas{1, j} = aux;
        end
        if i == 2
            aac_y_janelas{1, j} = aux;
        end
        if i == 3
            aac_z_janelas{1, j} = aux;
        end
    end
end


for i=1:numel(ix_labels)
    N= length(aac_x_janelas{1,i});
   
   if (mod(N,2) == 0)
        f = -Fs/2:Fs/N:Fs/2-Fs/N;
   else
        f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
    end
    plot(f, aac_x_janelas{1,i})
    hold on
end
