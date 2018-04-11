clc; clear; close all;

f=@(x) exp(x);

initial = -5; % Faixa inicial para geração dos dados
final = 5; % Faixa final para geração dos dados
step = 0.01; % Passo entre a faixa inicial e a faixa final

qtd_cam_ocultas = 500;

qtd_classes = 1;
qtd_atributos = 1;

% Inicializando vetores para armazenar os dados
x = zeros(); 
y = zeros();

% Faixas de ruido
a = -4.5+rand(1);
b = 4.5+rand(1);

k = 1;
for i=initial:step:final    
    x(k) = i;
    y(k) = f(i)+(b-a).*rand(1) + a;
    k = k + 1;
end

dados = [x' y'];
figure(3)
scatter(dados(:,1), dados(:,2));
dados = normalizar(dados);

qtd_padroes = size(dados, 1);

figure(1)
scatter(dados(:,1), dados(:,2), '.');
hold on

W = rand(qtd_cam_ocultas, 1+1);
%ones(qtd_cam_ocultas, 2);
M = rand(1, qtd_cam_ocultas+1)

X = dados(:, 1:size(dados, 2)-qtd_classes);
X = [-ones(size(X, 1), 1) X];
D = dados (:,qtd_atributos+1:end);



H = zeros(1, qtd_cam_ocultas+1);

% Ida (FeedForward)
for i=1:size(dados, 1)
    h = [-1; logsig(W*X(i,:)')];
    H = vertcat(H, h');
end

H =  H(2:end, :);

M = H\D;

x = X(:,2);

for i=1:size(dados, 1)
    y = (M'*H(i,:)');
    scatter (x(i), y, '.', 'black')
    erro = D(i)-y
    hold on;
end

