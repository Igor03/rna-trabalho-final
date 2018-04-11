clc; clear all; close all;

%% SETUP INICIAL PARA "IRIS"
dados = load ('iris2.txt');
dados = normalizar (dados);
qtd_classes = 3;
qtd_atributos = 4;
qtd_realizacoes = 10;

%% TREINANDO A REDE
taxa_de_acertos = zeros (qtd_realizacoes, 1);
for i=1:qtd_realizacoes
    
    dados = dados(randperm(size(dados, 1)), :);
    conj_treinamento = dados(1:size(dados, 1)-30, :); % 120 amostras para treinamento
    conj_testes = dados (size(dados, 1)-29:end, :);
    
    qtd_neur_ocultos = validacao(dados, qtd_classes, qtd_atributos);
    [W, M] = ELM(conj_treinamento, qtd_classes, qtd_atributos, qtd_neur_ocultos);
    
    % Calculando taxa de acerto para a i-esima realizacao
    x = conj_testes(:, 1:size(conj_testes, 2) - qtd_classes);
    x = [-ones(size(x, 1), 1) x];
    d = conj_testes (:, qtd_atributos + 1:end);
    acertos = 0;
    
    for j=1:size(conj_testes, 1)
        h = [-1;logsig(W*x(j,:)')];
        y = ativacao(M'*h)';
        if ( isequal(y ,d(j,:)'))
            acertos = acertos + 1;
        end
    end
    fprintf ('Realizacao %d\n', i);
    taxa_de_acertos(i) = (acertos/j);
end
taxa_de_acertos
acuracia = mean(taxa_de_acertos)
desvio_padrao = std(taxa_de_acertos)

figure(1)
plot(taxa_de_acertos, '--');
hold on
for i=1:10
   scatter(i, taxa_de_acertos(i), 'o', 'black');
   hold on;
end
title('Taxa de Acertos para "Iris"');
xlabel('Realizações');
ylabel('Taxa de acerto');
hold off;