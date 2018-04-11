clc; clear all; close all;

%% SETUP INICAL
dados = load('iris.txt');
dados = normalizar(dados);
qtd_classes = 3; 
qtd_atributos = 4;
epocas = 100;
realizacoes = 10;

taxa_de_acerto  = zeros(realizacoes, 1);

for i=1:realizacoes
    %% DEFININDO CONJUNTOS DE TREINAMENTO E TESTE
    dados = dados(randperm(size(dados, 1)), :);
    x_treino = dados(1:size(dados, 1)-30, :); % 120 amostras para treinamento
    x_testes = dados (size(dados, 1)-29:end, :); % 30 amostras para testes
    
    W = Madaline(x_treino, qtd_classes, qtd_atributos, 0.1, epocas);
    acertos = 0;
    
    x_testes = horzcat(-ones(size(x_testes, 1), 1), x_testes);
    x = x_testes(:, 1:size(x_testes, 2)-qtd_classes); % Padroes
    d = x_testes (:,qtd_atributos+2:size(x_testes,2));  % Saidas desejadas
    
    for j=1:size(x_testes, 1)
        y = ativar(W*x(j,:)');
        if (isequal(d(j,:), y))
            acertos = acertos + 1;
        end
    end
    taxa_de_acerto(i) = acertos/(size(x_testes, 1));
    fprintf('Realizacao %d\n', i);
    
end
Acuracia = mean(taxa_de_acerto)
Desvio_padrao = std(taxa_de_acerto)

figure(1)
plot(taxa_de_acerto, '--');
hold on
for i=1:10
   scatter(i, taxa_de_acerto(i), 'o', 'black');
   hold on;
end
title('Taxa de Acertos para "Iris" (OLAM)');
xlabel('Realizações');
ylabel('Taxa de acerto');
hold off;
