function [ W ] = Madaline( dados, qtd_classes, qtd_atributos, taxa_apre, epocas )
    %UNTITLED3 Summary of this function goes here
    %   Detailed explanation goes here
    
    dados = horzcat(-ones(size(dados, 1), 1), dados);
    W = rand (qtd_classes, qtd_atributos+1);
    
    for i=1:epocas
        dados = dados(randperm(size(dados, 1)), :);
        x = dados(:, 1:size(dados, 2)-qtd_classes);
        d = dados (:,size(x, 2)+1:size(dados,2));
        
        for j=1:size(x, 1);
            y = ativar(W*x(j, :)');
            erro = (d(j,:)-y);
            W = W + (taxa_apre*erro'*x(j,:));
        end
    end
    % RESOLUCAO COM O OLAM
    % W = (x\d)';
end

