clc; clear all; close all;
warning('off','all');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GERANDO DADOS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funcao base
f = @(x) 3*sin(x);

%Faixas para geracao dos dados
inicial = -5;
final = 5;
passo = 0.01;

x = zeros();
y = zeros();
y_real = zeros();

%Faixas de ruido
a = .4;  
b = -.5;

k = 1;
for i=inicial:passo:final
    x(k) = i;
    y(k) = f(i)+(b-a)*rand(1) + a;
    y_real(k) = f(i);
    k = k + 1;
end
% Definindo conjunto de dados
x = normalizar(x);
dados_real = [x' y_real'];
dados = [x' y'];

figure(1);
scatter (dados(:,1), dados(:,2), '.', 'red');
hold on
scatter (dados_real(:,1), dados_real(:,2), '.', 'black');
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d = @(x, y) sqrt(sum((x-y).^2));
gauss = @(x, c, ro) exp(d(x, c)^2/(-2*ro^2));
realizacoes = 10;
RMSE = zeros(realizacoes, 1);

for k=1:realizacoes
    
   dados = dados(randperm (size(dados, 1)), :); % Embaralha os dados
   x_treino = dados(1:size(dados, 1)-301, :); % Definindo conjunto de treino (700)
   x_teste = dados(size(dados, 1)-299:end, :); % Definindo conjunto de testes (300)
   X = x_teste(:, 1:size(x_teste, 2) - 1);
   D = x_teste(:, 1 + 1:end); 
   
   %[qtd_centroides, abertura] = validacao(dados, qtd_classes, qtd_atributos);
   qtd_centroides = 15; % Obtida com a validação
   abertura = .9; % Obtida com a validação
   i_centroides = randperm(qtd_centroides); %Definindo posicao indices dos centroides
   centroides = X(i_centroides, :); % Definido conjunto de centroides
   % Treinando a rede
   %[qtd_centroides, abertura] = validacao(dados, qtd_classes, qtd_atributos);
   W = RBF (x_treino, 1, 1, centroides, abertura);
    
   MSE = 0;
   Y = zeros();
   for i=1:size(X, 1)
       x_i = X(i,:);
       for j=1:size(centroides, 1);
           Y(i, j) = gauss(x_i, centroides(j,:), abertura);
       end
       h = [-1 Y(i,:)];
       y = h*W;
       MSE = MSE + (D(i) - y)^2;
   end
   fprintf ('REALIZACAO %d\n', k);
   RMSE(k) = sqrt(MSE/i);
end

RMSE_medio = mean(RMSE)
desvio_padrao = std(RMSE)

%% MOSTRANDO DADOS
X = dados(:, 1:size(dados, 2) - 1);
D = dados(:, 1 + 1:end); 
y = zeros();
for i=1:size(X, 1)
   x_i = X(i,:);
   for j=1:size(centroides, 1);
       Y(i, j) = gauss(x_i, centroides(j,:), abertura);
   end
   h = [-1 Y(i,:)];
   y(i) = h*W;
end

scatter (X, y, '.', 'green');
title ('Regressao')
legend('Dados', 'f(x)', 'Aproximacao')
xlabel('x')
ylabel('f(x)')
grid on
hold off