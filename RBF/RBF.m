function [ W ] = RBF( dados, qtd_classes, qtd_atributos, centros, abertura)
    %UNTITLED2 Summary of this function goes here
    %   Detailed explanation goes here
    d = @(x, y) sqrt(sum((x-y).^2));
    gauss = @(x, c, ro) exp(d(x, c)^2/(-2*ro^2));
    
    X = dados(:, 1:size(dados, 2) - qtd_classes);
    D = dados(:, qtd_atributos+1:end);
    
    H = zeros(); %Inicializando a saida
    
    for i=1:size(X, 1)
        x_i = X(i, :);
        for j=1:size(centros, 1)
            H(i, j) = gauss(x_i, centros(j, :), abertura);
        end
    end

    H = [-ones(i, 1), H];
    W = H\D;
    
end

