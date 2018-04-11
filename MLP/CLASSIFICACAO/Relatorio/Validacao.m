clc; clear all;

dados = load('coluna_vertebral.dat');
qtdClasses = 3; 
qtdAtributos = 6;
qtdEpocas = 80;

dados = dados(randperm(size(dados, 1)), :); %Embaralhando os dados
dados = normalizar(dados);
grade = zeros(5);

%dados = dados(randperm(size(dados, 1)), :);
%conjTreinamento = dados(1:size(dados, 1)-30, :); % 500 amostras para treinamento

%Perferct!!!!!!!!!!!!

% fold1 = dados(1:size(dados, 1)-120, :);
% fold2 = dados(31:size(dados, 1)-90, :);
% fold3 = dados(61:size(dados, 1)-60, :);
% fold4 = dados(91:size(dados, 1)-30, :);
% fold5 = dados(121:size(dados, 1)-0, :);

fold1 = dados((size(dados, 1)/5)*0+1:size(dados, 1)-(size(dados, 1)-1*(size(dados, 1)/5)),:);
fold2 = dados((size(dados, 1)/5)*1+1:size(dados, 1)-(size(dados, 1)-2*(size(dados, 1)/5)),:);
fold3 = dados((size(dados, 1)/5)*2+1:size(dados, 1)-(size(dados, 1)-3*(size(dados, 1)/5)),:);
fold4 = dados((size(dados, 1)/5)*3+1:size(dados, 1)-(size(dados, 1)-4*(size(dados, 1)/5)),:);
fold5 = dados((size(dados, 1)/5)*4+1:size(dados, 1)-(size(dados, 1)-5*(size(dados, 1)/5)),:);

size(fold1)
size(fold2)
size(fold3)
size(fold4)
size(fold5)


for i=1:size(grade, 1)
    for j=1:size(grade, 1)
        acuracia = zeros(5, 1);
        for k=1:5 
            if (k==1)
                foldTeste = fold1;
                foldTrain = vertcat(fold2, fold3, fold4, fold5);
            elseif(k==2)
                foldTeste = fold2;
                foldTrain = vertcat(fold1, fold3, fold4, fold5);
            elseif(k==3)
                foldTeste = fold3;
                foldTrain = vertcat(fold2, fold1, fold4, fold5);
            elseif(k==4)
                foldTeste = fold4;
                foldTrain = vertcat(fold2, fold3, fold1, fold5);
            else
                foldTeste = fold5;
                foldTrain = vertcat(fold2, fold3, fold4, fold1);
            end
            [W, M] = MLP(foldTrain, qtdClasses, qtdAtributos, 2*j, i/10, qtdEpocas);
            
            %% CALCULANDO ACURÁCIA
            x = foldTeste(:, 1:size(foldTeste, 2)-qtdClasses);
            x = [-ones(size(x, 1), 1) x];
            d = foldTeste (:,qtdAtributos+1:end);
            count = 0;
            for m=1:size(foldTeste, 1)
                h = [-1;logsig(W*x(m,:)')];
                y = calculaSaidaLogistica(M*h)';
                if ( isequal(y,d(m,:)))
                    count = count+1;
                end
            end
            acuracia(k) = (count/m);
        end
        grade(i, j) = mean(acuracia);
    end
end

[taxaApren, qtdCamadasOcultas] = getMaxIndex(grade);
qtdCamadasOcultas = qtdCamadasOcultas*2;
taxaApren = taxaApren/10;

% for k=1:5
%     
%     acuracia=0;
%     
%     if (i==1)
%         foldTeste = fold1;
%         foldTrain = vertcat(fold2, fold3, fold4, fold5);
%     elseif(i==2)
%         foldTeste = fold2;
%         foldTrain = vertcat(fold1, fold3, fold4, fold5);
%     elseif(i==3)
%         foldTeste = fold3;
%         foldTrain = vertcat(fold2, fold1, fold4, fold5);
%     elseif(i==4)
%         foldTeste = fold4;
%         foldTrain = vertcat(fold2, fold3, fold1, fold5);
%     else
%         foldTeste = fold5;
%         foldTrain = vertcat(fold2, fold3, fold4, fold1);
%     end
%     
% end
