function [ W, M ] = ELM( dados, qtd_classes, qtd_atributos, qtd_neur_ocultos )
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
        
    % O "W" eh iniciado aleatoriamente
    W = rand(qtd_neur_ocultos, qtd_atributos+1);

    X = dados(:, 1:size(dados, 2)-qtd_classes);
    X = [-ones(size(X, 1), 1) X];
    D = dados (:,qtd_atributos+1:end);
    
    H = zeros(1, qtd_neur_ocultos + 1);
      
    % Ida (Feedforward)
    for i=1:size(dados, 1)
       h = [-1; logsig(W*X(i,:)')];
       H = vertcat(H, h');
    end
    
    % Removendo a linha inicial
    H = H(2:end, :);
  
    % Solucao otima usando OLAM
    M = H\D;
    
end

