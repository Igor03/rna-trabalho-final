clc; clear all;

%% SETUP INICIAL PARA "COLUNA VERTEBRAL"
dados = load('coluna_vertebral.dat');
dados = normalizar(dados);
qtdClasses = 3; 
qtdAtributos = 6;
qtdEpocas = 100;
realizacoes = 10;

%% DEFININDO CONJUNTOS DE TREINAMENTO E TESTE
dados = dados(randperm(size(dados, 1)), :); %Embaralhando os dados
conjTreinamento = dados(1:size(dados, 1)-60, :); % 250 amostras para treinamento
conjTestes = dados (size(dados, 1)-59:end, :); % 60 amostras para testes

%% TREINANDO A REDE
taxaDeAcerto = zeros(realizacoes, 1);
for i=1:realizacoes %Realizacoes
    
    fprintf ('Realizacao %d\n', i);

    [qtdCamOcultas, taxaAprend] = validacaoEmGrade(conjTreinamento, qtdClasses, qtdAtributos, qtdEpocas);
    [W, M] = MLP(conjTreinamento, qtdClasses, qtdAtributos, qtdCamOcultas, taxaAprend, qtdEpocas);
    
    % Calculando acuracia
    x = conjTestes(:, 1:size(conjTestes, 2)-qtdClasses);
    x = [-ones(size(x, 1), 1) x];
    d = conjTestes (:,qtdAtributos+1:end);
    
    count = 0;
    for j=1:size(conjTestes, 1) %Quantidade de dados do conjunto de testes
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