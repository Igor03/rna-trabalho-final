function [ qtd_neur_ocultos ] = validacaoR( dados, qtd_classes, qtd_atributos )
    %UNTITLED3 Summary of this function goes here
    %   Detailed explanation goes here
    
    grade = zeros (1, 20); % Vetor de 10 posicoes
    
    for i=1:length(grade)
        
       RMSE = zeros (1, 20);
       
       dados = dados(randperm(size(dados, 1)), :); %Embaralhando os dados

       
        % Separando os folds
       fold1 = dados((size(dados, 1)/5)*0+1:size(dados, 1)-(size(dados, 1)-1*(size(dados, 1)/5)),:);
       fold2 = dados((size(dados, 1)/5)*1+1:size(dados, 1)-(size(dados, 1)-2*(size(dados, 1)/5)),:);
       fold3 = dados((size(dados, 1)/5)*2+1:size(dados, 1)-(size(dados, 1)-3*(size(dados, 1)/5)),:);
       fold4 = dados((size(dados, 1)/5)*3+1:size(dados, 1)-(size(dados, 1)-4*(size(dados, 1)/5)),:);
       fold5 = dados((size(dados, 1)/5)*4+1:size(dados, 1)-(size(dados, 1)-5*(size(dados, 1)/5)),:);
       
       for k=1:5 %quantidade de folds de folds
           if (k==1)
               fold_teste = fold1;
               fold_train = vertcat(fold2, fold3, fold4, fold5);
           elseif(k==2)
               fold_teste = fold2;
               fold_train = vertcat(fold1, fold3, fold4, fold5);
           elseif(k==3)
               fold_teste = fold3;
               fold_train = vertcat(fold2, fold1, fold4, fold5);
           elseif(k==4)
               fold_teste = fold4;
               fold_train = vertcat(fold2, fold3, fold1, fold5);
           else
               fold_teste = fold5;
               fold_train = vertcat(fold2, fold3, fold4, fold1);
           end
           
           [W, M] = ELM(fold_train, qtd_classes, qtd_atributos, 2*i);
    
           % Calculando taxa de acerto para a i-esima realizacao
           x = fold_teste(:, 1:size(fold_teste, 2) - qtd_classes);
           x = [-ones(size(x, 1), 1) x];
           d = fold_teste (:, qtd_atributos + 1:end);
           MSE = 0;
           
           for j=1:size(fold_teste, 1)
               h = [-1;logsig(W*x(j,:)')];
               y = (M'*h)';
               MSE = MSE + (d(j)-y)^2;
           end
           RMSE(k) = sqrt(MSE/j);
       end
       grade(i) = mean(RMSE);
    end
    qtd_neur_ocultos = get_index_max(grade)*2
end

