clc; clear all;
close all;

f=@(x) ((sin(x)));

initial = -5; % Faixa inicial para geração dos dados
final = 5; % Faixa final para geração dos dados
step = 0.03; % Passo entre  a faixa inicial e a faixa final

% Inicializando vetores para armazenar os dados
x = zeros(); 
y = zeros();

% Faixas de ruido
a = -.6;
b = .6;

k = 1;
for i=initial:step:final    
    x(k) = i;
    y(k) = f(i)+(b-a)*rand(1) + a;
    k = k + 1;
end

%x = normalize1(x);
dados = normalize1([x' y']);
figure(3)
scatter(dados(:,1), dados(:,2));
%dados = normalizar(dados);

figure(1)
%scatter(dados(:,1), dados(:,2), '.');
hold on
%dados = load('artificial1.txt');

[W, M] = MLP(dados, 1, 1, 15, 0.01, 100);
   
x = dados(:, 1:size(dados, 2)-1);
x = [-ones(size(x, 1), 1) x];
d = dados (:,1+1:end);
tags = x(:,2);


count = 0;
MSE = 0;
for j=1:size(dados, 1) %Quantidade de dados do conjunto de testes
    h = [-1;logsig(W*x(j,:)')];
    y(j) = (M*h);
    MSE = MSE + (d(j)-y(j))^2;
    %scatter(tags(j), y(j), '.', 'black');
    hold on;
end
scatter (tags, y)
RMSE = sqrt(MSE/j);

    %taxaDeAcerto(i) = (count/j);
hold off
% scatter (x(:,2), d);
% 
% figure(5)
% scatter (x(:,2), y);

D = dados (:,1+1:end);
X = dados(:, 1:size(dados, 2)-1);