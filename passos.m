function passos(valores)
    movimentos_dinamicos = 3;
    for i=1:movimentos_dinamicos
        j=1;
        if i==1
            disp('Walking')
        end
        if i==2
            disp('Walking Up')
        end
        if i==3
            disp('Walking Down')
        end
        while(isempty(valores{i,j})~=1)
            pks = findpeaks(valores{i,j});
            disp(j)
            %disp(max(pks))
            %disp(max(pks(pks<max(pks)))) %segundo maior
            disp(pks(1))%primeiro valor
            disp(pks(1)*60)%primeiro valor do pico *60
            j=j+1;
        end
    end
end