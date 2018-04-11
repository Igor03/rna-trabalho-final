clc; clear all;

%% SETUP INICIAL PARA "DERMATOLOGIA"
dados = load('dermatologia.txt');?
dados = normalizar(dados);
qtdClasses = 6; 
qtdAtributos = 34; 
qtdEpocas = 70;
realizacoes = 10;

%% TREINANDO A REDE
taxaDeAcerto = zeros(realizacoes, 1);
for i=1:realizacoes %Realizacoes
    
    %% DEFININDO CONJUNTOS DE TREINAMENTO E TESTE
    dados = dados(randperm(size(dados, 1)), :); %Embaralhando os dados
    conjTreinamento = dados(1:size(dados, 1)-96, :); % 270 amostras para treinamento
    conjTestes = dados (size(dados, 1)-95:end, :); % 96 amostras para testes

    fprintf ('Realizacao %d\n', i);

    [qtdCamOcultas, taxaAprend] = validacaoEmGrade(conjTreinamento, qtdClasses, qtdAtributos, qtdEpocas);
    [W, M] = MLP(conjTreinamento, qtdClasses, qtdAtributos, qtdCamOcultas, taxaAprend, qtdEpocas);
    
    % Calculando acuracia
    x = conjTestes(:, 1:size(conjTestes, 2)-qtdClasses);
    x = [-ones(size(x, 1), 1) x];
    d = conjTestes (:,qtdAtributos+1:end);
    
    % Calculando a acuracia
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