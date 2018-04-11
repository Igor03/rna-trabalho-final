clc; clear all;

%% SETUP INICIAL PARA "IRIS"
dados = load('iris.txt');
dados = normalizar(dados);
qtdClasses = 3; 
qtdAtributos = 4;
qtdEpocas = 70;
realizacoes = 10;

%% DEFININDO CONJUNTOS DE TREINAMENTO E TESTE
dados = dados(randperm(size(dados, 1)), :);
conjTreinamento = dados(1:size(dados, 1)-30, :); % 120 amostras para treinamento
conjTestes = dados (size(dados, 1)-29:end, :); % 30 amostras para testes

%% TREINANDO A REDE
taxaDeAcerto = zeros(realizacoes, 1);
for i=1:realizacoes %Realizacoes
    
    fprintf ('Realizacao %d\n', i);

    %[qtdCamOcultas, taxaAprend] = validacaoEmGrade(conjTreinamento, qtdClasses, qtdAtributos, qtdEpocas);
    [W, M] = MLP(conjTreinamento, qtdClasses, qtdAtributos, 15, 0.1, qtdEpocas);
    
    % Calculando acuracia
    x = conjTestes(:, 1:size(conjTestes, 2)-qtdClasses);
    x = [-ones(size(x, 1), 1) x];
    d = conjTestes (:,qtdAtributos+1:end);
    count = 0;
    for j=1:30 % Quantidade de dados do conjunto de testes
        h = [-1;logsig(W*x(j,:)')];
        y = calculaSaidaLogistica(M*h)';
        if ( isequal(y,d(j,:)))
            count = count+1;
        end
    end
    taxaDeAcerto(i) = (count/j);
end

%% RESULTADOS
acuracia = mean(taxaDeAcerto)
desvio_padrao = std(taxaDeAcerto)
