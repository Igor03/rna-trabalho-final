clc; clear all; close all;
warning('off','all');

%% GERANDO OS DADOS
f = @(x) sin(x);

% Faixas para geracao dos dados
inicial = -5; 
final = 5;
passo = 0.01;

x = zeros(); 
y = zeros();
y_real = zeros();

% Faixas de ruido
a = -.5;
b = .5;

k = 1;
for i=inicial:passo:final    
    x(k) = i;
    y(k) = f(i)+(b-a).*rand(1) + a;
    y_real(k) = f(i);
    k = k + 1;
end

% Conjunto de dados
x = normalizar1(x);
dados_real = [x' y_real'];
dados =  [x' y'];
y_real = normalizar(y_real);
dados = dados(randperm(size(dados, 1)), :);
scatter(dados(:,1), dados(:,2), '.', 'r');
hold on;
% ##################################################################

%% SETUP INICIAL PARA A BASE ARTIFICIAL
qtd_classes = 1;
qtd_atributos = 1;
qtd_realizacoes = 10;

RMSE = zeros(1, qtd_realizacoes);

for i=1:qtd_realizacoes
   
    fprintf ('REALIZACAO %d\n', i);
    
    dados = dados(randperm(size(dados, 1)), :);
    conj_treinamento = dados(1:size(dados, 1)-301, :); % 700 amostras para treinamento
    conj_testes = dados (size(dados, 1)-299:end, :); % 300 amostras para testes
    
    %qtd_neur_ocultos = validacaoR(conj_treinamento, qtd_classes, qtd_atributos);
    [W, M] = ELM(conj_treinamento, qtd_classes, qtd_atributos, 20);
    
    x = conj_testes(:, 1:size(conj_testes, 2) - qtd_classes);
    x = [-ones(size(x, 1), 1) x];
    d = conj_testes (:, qtd_atributos + 1:end);
    
    %% CALCULANDO ERROS
    MSE = 0;
    y_k = zeros(1, size(conj_testes, 1));
    for j=1:size(conj_testes)
        h = [-1;logsig(W*x(j,:)')];
        y_k(j) = (M'*h)';
        MSE = MSE + (d(j)-y_k(j))^2;
    end
    RMSE(i) = sqrt(MSE/j);
end

%% PLOTANDO DADOS
x = dados(:, 1:size(dados, 2) - qtd_classes);
x = [-ones(size(x, 1), 1) x];
y_k = zeros(1, size(dados, 1));

for i=1:size(dados, 1)
    h = [-1;logsig(W*x(i,:)')];
    y_k(i) = (M'*h)';
end

scatter (x(:,2), y_k, '.', 'black');
scatter(dados_real(:,1), dados_real(:,2), '.', 'b');
grid on;
legend ('Dados inicial', 'Reta que aproxima', 'sen(x)')
xlabel('x');
ylabel('y(x)');
RMSE_medio = mean(RMSE)
desvio_padrao = std(RMSE)







