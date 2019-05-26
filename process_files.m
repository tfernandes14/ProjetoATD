clear all
close all
clc

Expr={'21','22','23','24','25','26','27','28','29','30'};
User={'10','11','12','13','14','15'};

infoFch = cell(1, 10);
medias= cell(4, 3);
aac= cell(3, 10);

zero = [0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 ];
for i=1:4
    for j=1:3
        medias{i,j}=zero;
    end
end

[medias, aac] = process_raw_data(Expr{1,1}, User{1,1}, medias, 1, aac);
pause()
j=2;
for i=2:(size(User,2)-1)
    [medias, aac] = process_raw_data(Expr{1,j}, User{1,i}, medias, j, aac);
    pause()
    j=j+1;
    [medias, aac] = process_raw_data(Expr{1,j}, User{1,i}, medias, j, aac);
    pause()
    j=j+1;
end
[medias, aac] = process_raw_data(Expr{1,size(Expr,2)}, User{1,size(User,2)}, medias, j, aac);

for i=1:4
    for j=1:3
        soma=0;
        for k=1:3
            for l=1:10
                soma = soma + medias{i,j}(k,l);
            end
            desvio = std(medias{i,j}(k,:));
            desvio
            soma = soma/10;
            soma
        end
    end
end

%4.3
figure('Name','Atividades dinamicas vs Atividades de transicao e estaticas')
exercicio4_3(aac, 1)
exercicio4_3(aac, 2)
exercicio4_3(aac, 3)

%4.4
figure('Name','Tipos de Atividades')
esta(aac, 1)
esta(aac, 2)
esta(aac, 3)

%4.5
figure('Name','Atividades Dinamicas')
exercicio4_5(aac, 1)
exercicio4_5(aac, 2)
exercicio4_5(aac, 3)
