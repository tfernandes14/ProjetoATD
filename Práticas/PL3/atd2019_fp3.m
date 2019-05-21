% ---------------------- PARTE 1 ------------------------------------------
% Ex1.1
close all
clear

% Ler ficheiro com a serie temporal
load lisbon_temp_fmt.mat
x1 = temp; %serie temporal
N = length(x1); %comprimento da serie temporal
t = (0:N-1)'; %escala temporal em meses

% Representaçao grafica
figure(1)
plot(t,x1,'-+');
legend('Serie temporal 1', 'Location', 'northwest')
xlabel('t[m]')
ylabel('Temperatura')
title('Temperatura em Lisboa desde 1980')


% Ex1.2
% Verifica a existencia de NaN
disp('Há NaN?')
haNaN = any(isnan(x1)) % Ha NaN por colunas
elemNaN = find(isnan(x1)) % Elementos com NaN

% Eliminia linahs com NaN e reconstroi
% Sugestao: reconstruir as linhas eliminadas usando extrapolação
x1r = x1;
if any(x1)
    ind = find(isnan(x1));
    for k=1:length(ind)
        tt = t(ind(k)-4:ind(k)-1);
        xx = x1r(ind(k)-4:ind(k)-1);
        x1r(ind(k))=interp1(tt,xx,t(ind(k)),'pchip','extrap'); % interp(um)
    end
end

figure(2)
plot(t,x1,'-+',t,x1r,'-o')
legend('Serie temporal', 'Serie temporal sem NaN', 'Location', 'northwest')
xlabel('t [meses]')
ylabel('Temperatura')

% Ex1.3
% Media, desvio padrao e correlaçao
% Funçoes: mean, std e corrcoef
mu1 = mean(x1r);
sigma1 = std(x1r);

% Determinar temperaturas na decada de 80 e 90
ix80 = 1;
ix89 = find(years==1989) * 12;
ix90 = (find(years==1990) * 12) - 12 + 1;
ix99 = find(years==2000) * 12 - 12;

temp80 = x1r(ix80:ix89);
temp90 = x1r(ix90:ix99);

disp("Correlaçao entre as duas series temporais sem NaN: ")
corr = corrcoef(temp80,temp90);

% Ex1.4
% Verifica outliers
outliers1 = find(abs(x1r - mu1) > 3 * sigma1); % Identifica os outliers
nout1 = length(outliers1); % Numero de outliers

x1ro = x1r;
if nout1
    for k=1:numel(outliers1)
        if x1ro(outliers1(k)) > mu1
            x1ro(outliers1(k)) = mu1 + 2.5 * sigma1;
        else
            x1ro(outliers1(k)) = mu1 - 2.5 * sigma1;
        end
    end
end

figure(3)
plot(t,x1,'-+', t, x1r, '-o', t, x1ro, '-d')
legend("Serie temporal", "Serie sem NaN", "Serie sem outliers")
xlabel('t [meses]')
ylabel('Temperatura')


% ---------------------- PARTE 2 ------------------------------------------
%Ex1.1
% Estimar tendencia parametrica (polinomial) 
% trend de ordem 0
x1ro_t0 = detrend(x1ro, 'constant'); % media da serie
tr1_0 = x1ro - x1ro_t0;
% trend de ordem 1
x1ro_t1 = detrend(x1ro, 'linear'); %serie sem a tendencia
tr1_1 = x1ro - x1ro_t1;

figure(1)
subplot(211)
plot(t, x1ro, '-+', t, tr1_0, '-*')
title("Serie (+) e trend (*) de grau 0")
xlabel("t[meses]")
ylabel("Temperaturas")
subplot(212)
plot(t, x1ro_t0, '-o')
title("Serie sem trend de grau 0")
xlabel("t[meses]")
ylabel("Temperaturas")

figure(2)
subplot(211)
subplot(211)
plot(t, x1ro, '-+', t, tr1_1, '-*')
title("Serie (+) e trend (*) de grau 1")
xlabel("t[meses]")
ylabel("Temperaturas")
subplot(212)
plot(t, x1ro_t1, '-o')
title("Serie sem trend de grau 1")
xlabel("t[meses]")
ylabel("Temperaturas")

% Ex1.2
disp("Aproximaçao linear de 2º grau: ")
p1 = polyfit(t, x1ro,2) %coeficientes dos polinomios
tr1_2 = polyval(p1,t); % valores resultantes
x1ro_t2 = x1ro - tr1_2;

figure(3)
subplot(211)
plot(t, x1ro, '-+', t, tr1_2, '-*')
title("Serie (+) e trend (*) de grau 2")
xlabel("t[meses]")
ylabel("Temperaturas")
subplot(212)
plot(t, x1ro_t2, '-o')
title("Serie sem trend de grau 2")
xlabel("t[meses]")
ylabel("Temperaturas")

%Ex1.3
period = 12;
x1ro_t2Mat = reshape(x1ro_t2, period, floor(numel(x1ro_t2))/period);
st1 = repmat(mean(x1ro_t2Mat,2),floor(numel(x1ro_t2))/period,1);
x1ro_s = x1ro - st1;

figure(4)
subplot(211)
plot(t, x1ro, '-+', t, x1ro_s, '-o')
title("Serie 1 (+) e sem sazonalidade (o)")
xlabel("t[meses]")
ylabel("Temperaturas")
subplot(212)
plot(t, st1, '-*')
title("Sazonalidade da serie 1")
xlabel("t[meses]")
ylabel("Temperaturas")

% Ex1.4
% Estimar a componente
irreg_x1 = x1ro - tr1_2 - st1;
% Serie temporal sem a componente irregular
x1ro_i = x1ro - irreg_x1;

figure(5)
subplot(211)
plot(t, x1ro, '-+', t, x1ro_i, '-o')
title("Serie com (+) e sem (o)componente irregular")
xlabel("t[meses]")
ylabel("Temperaturas")
subplot(212)
plot(t, irreg_x1, '-*')
title("Componente irregular da serie 1")
xlabel("t[meses]")
ylabel("Temperaturas")

% -------------------------- PARTE 3 --------------------------------------
% ===== Ex1.1 =====
% adftest -> Funçao que verifica que a funçao e estacionaria ou nao
if adftest(x1ro) == 0
    disp("Série não estacionária")
else
    disp("Série estacionária")
end

if adftest(x1ro_t1) == 0
    disp("Série sem a tendencia de 1º ordem não estacionária")
else
    disp("Série sem a tendencia de 1º ordem estacionária")
end

% ===== Ex1.2 =====
ix00 = (find(years == 2000) * 12) - 1; %Identificar indice para Dez
serie_treino = x1ro_t1(1:ix00); % Temp entre Jan 1980 e Dez 2000
serie_teste = x1ro_t1(ix00+1:end); %Temp entre Jan 2001 e Dez 2018

% Identificar tendencias para a comparaçao final entre a serie
trend_treino=tr1_1(1:ix00);
trend_teste=tr1_1(ix00+1:end);

%Criar objeto IDDATA com dados de treino
id_treino=iddata(serie_treino, [], 1, 'TimeUnit', "Months");

% ===== Ex1.3 - Modelo AR =====
figure; % Representaçao da FACP
parcorr(serie_treino, round(numel(serie_treino)/4))

opt1_AR=arOptions("Approach", "ls"); % Opçoes do modelo AR
na1_AR=37; % Historico da variavel
model1_AR=ar(id_treino, na1_AR, opt1_AR); % Modelo AR
pcoef1_AR=polydata(model1_AR); % Parametros do modelo AR

% ===== Ex1.4 - Simualaçao do modelo AR =====
y1_AR=serie_treino(end-na1_AR:end);
for k=(1:numel(serie_teste))+numel(y1_AR)
    y1_AR(k)=sum(-pcoef1_AR(2:end)'.* flip(y1_AR(k-na1_AR:k-1)));
    % plot(y1_AR(1:k))
    % drawnow
    % pause(0.5)
end

% Adicionar as tendencias para comparar com a serie original
y1_AR=y1_AR+[trend_treino(end-na1_AR:end);trend_teste];

% Simulação do Modelo AR com forecast - ignora o inicio, so vem a previsao
y1_ARf=forecast(model1_AR, serie_treino(end-na1_AR:end), numel(serie_teste));

% Determinação dos vetores tempo para a serie original e para a serie
% original e para o tempo 
tp=-na1_AR:numel(y1_AR)-(na1_AR+1); % Tempo para a previsao
to=1:numel(serie_teste); % Tempo para a serie original(teste)

figure % Compara a serie com a sua estimaçao
plot(to, serie_teste+trend_teste, '-+', tp, y1_AR, '-o', to, y1_ARf+trend_teste, '-*');
xlabel('Tempo (meses)');
title('Serie medida e regularizada (-+), estimação com o modelo AR (-o), estimação com o modelo AR e usando a função forecast(-*)')

% ===== Ex1.5 - Modelo ARMA =====
figure;
autocorr(serie_treino, round(numel(serie_treino)/4))

opt1_ARMAX=armaxOptions('SearchMethod', 'auto'); 

na1_ARMA=12;
nc1_ARMA=5;
model1_ARMA = armax(id_treino, [na1_ARMA nc1_ARMA], opt1_ARMAX); % Estimar parametros

[pa1_ARMA, pb1_ARMA, pc1_ARMA]=polydata(model1_ARMA);

% ===== Ex1.6 =====
npoints2pred=numel(serie_teste)+na1_ARMA+1;

% Simulação do modelo ARMA
y1_ARMA=serie_treino(end-na1_ARMA:end);
e=randn(numel(serie_teste)+numel(y1_ARMA),1);
for k=numel(y1_ARMA):npoints2pred
    y1_ARMA(k)=sum(-pa1_ARMA(2:end)'.*flip(y1_ARMA(k-na1_ARMA:k-1)))+sum(pc1_ARMA'.*flip(e(k-nc1_ARMA:k)));
end

% Adicionar as tendencias para comparar com a serie original
y1_ARMA=y1_ARMA+[trend_treino(end-na1_ARMA:end);trend_teste];

% Simulação do modelo ARMA com forecast
y1_ARMAf=forecast(model1_ARMA,serie_treino(end-na1_ARMA:end),numel(serie_teste));
tp=-na1_ARMA:numel(y1_ARMA)-(na1_ARMA+1); % Vetor tempo
figure % Compara a serie com a sua estimação
plot(to, serie_teste+trend_teste, '-+', tp, y1_ARMA, '-o', to, y1_ARMAf+trend_teste,'-*');
xlabel('Tempo (meses)');
title('Serie medida e regularizada (-+), estimação com o modelo ARMA (-o), estimação com o modelo ARMA e usando a função forecast(-*)')

% Metrica para a analise
E1_ARMA=sum(((serie_teste+trend_teste)-(y1_ARMAf+trend_teste)).^2)

% ===== Ex1.7 - Estimação do modelo ARIMA =====
p1_ARIMA=15;
D1_ARIMA=1;
q1_ARIMA=5;
MD1=arima(p1_ARIMA, D1_ARIMA, q1_ARIMA);
% Obtem a estrutura do modelo ARIMA

% ===== Ex1.8 =====
serie_treino=x1ro(1:ix00);
serie_teste=x1ro(ix00+1:end)
EstMd1=estimate(MD1, serie_treino);
% Simulaçao do modelo ARIMA
y1_ARIMA=simulate(EstMd1, numel(serie_teste), 'Y0', serie_treino(end-(p1_ARIMA+D1_ARIMA)+1:end));
figure
plot(to, serie_teste, '-+', to, y1_ARIMA, '-o');
xlabel('Tempo (meses)');
title('Série 1 (-+) e estimação com o modelo ARIMA (-o)')
% Metrica para analise
E1_ARIMA=sum(((serie_teste)-(y1_ARIMA)).^2)