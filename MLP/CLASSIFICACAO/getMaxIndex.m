function [ linha, coluna ] = getMaxIndex( matriz )
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    
    linha = 1;
    coluna = 1;
    maxValor = matriz(linha, coluna);
    
    for i = 1:size(matriz, 1)
        for j = 1:size(matriz, 2)
            if (matriz(i, j)>maxValor)
                linha = i;
                coluna = j;
                maxValor=matriz(i, j);
            end
        end
    end
end

