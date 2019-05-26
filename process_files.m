clear all
close all
clc

Expr={'21','22','23','24','25','26','27','28','29','30'};
User={'10','11','12','13','14','15'};

infoFch = cell(1, 10);
medias= cell(4, 3);

zero = [0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 ];
for i=1:4
    for j=1:3
        medias{i,j}=zero;
    end
end

medias = process_raw_data(Expr{1,1}, User{1,1}, medias, 1);
pause()
j=2;
for i=2:(size(User,2)-1)
    medias = process_raw_data(Expr{1,j}, User{1,i}, medias, j);
    pause()
    j=j+1;
    medias = process_raw_data(Expr{1,j}, User{1,i}, medias, j);
    pause()
    j=j+1;
end
medias = process_raw_data(Expr{1,size(Expr,2)}, User{1,size(User,2)}, medias, j);

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
