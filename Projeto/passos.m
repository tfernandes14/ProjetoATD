function passos(valores, n)
    movimentos_dinamicos = 3;
    passos_val = cell(3, n);
    contador = [1 1 1];
    media = zeros(1,3);
    for i=1:movimentos_dinamicos
        j=1;
%         if i==1
%             disp('Walking')
%         end
%         if i==2
%             disp('Walking Up')
%         end
%         if i==3
%             disp('Walking Down')
%         end
        while(isempty(valores{i,j})~=1)
            pks = findpeaks(valores{i,j});
            passos_por_minuto = pks(1)*60; %primeiro valor do pico *60
            passos_val{i,contador(i)}=passos_por_minuto;
            contador(i) = contador(i)+1;
            j=j+1;
        end
    end
    
    for i=1:movimentos_dinamicos
         soma=0;
        j=1;
        while(isempty(passos_val{i,j})~=1)
            soma = soma+passos_val{i,j};
            j = j+1;
        end
        media(i)= soma/j;
    end
  media
end