function [ W, M ] = MLP( dados, qtdClasses, qtdAtributos, qtdCamOcultas, taxaAprend, qtdEpocas )

    % Definindo matrizes de pesos aleatorias
    W = rand(qtdCamOcultas, qtdAtributos+1);
    M = rand(qtdClasses, qtdCamOcultas+1);
    
    for t=1:qtdEpocas
        
        dados = dados(randperm(size(dados, 1)), :);
        x = dados(:, 1:size(dados, 2)-qtdClasses);
        x = [-ones(size(x, 1), 1) x];
        d = dados (:,qtdAtributos+1:end);
        
        for i=1:size(x, 1)
            
            h = [-1;logsig(W*x(i,:)')];
            y(i) = (M*h);
            erro = d(i,:)-y(i); % Calculando erro
            
            % Vetor de derivadas de "y"
            yDeriv = calculaDerivada(y);
            % Ajustando os pesos da camada de saida
            M = M + taxaAprend*erro*h';
                  
            mAux = M(:,2:end); % Matriz "M" sem M(0)
            hAux = h(2:end); % Vetor h sem "-1"
            hDeriv = calculaDerivada(hAux); % Vetor de derivadas de "h"
            %hDeriv = (hAux.*(1 - hAux))';

            for j=1:size(mAux, 2)
                ERP(j) = M(:,j)'*(erro); % Erro retropropagado
            end
            ERP = sum(ERP);
            %Ajustando os pesos da camada oculta
            W = W + taxaAprend*(ERP.*hDeriv)'*x(i,:);
        end
    end
    %figure(2)
    plot (x(:,2), d)
end