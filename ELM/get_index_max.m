function [ index ] = get_index_max( vetor )
    %UNTITLED4 Summary of this function goes here
    %   Detailed explanation goes here
    max_valor = max (vetor);
    for i=1:length(vetor)
        if (vetor(i) == max_valor)
            index = i;
        end
    end
end

