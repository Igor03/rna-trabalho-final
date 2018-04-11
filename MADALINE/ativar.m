function [ y ] = ativar( u )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    
    y = zeros(1, size(u, 1));
    max_valor = max(u);
    for i=1:size(u, 1)
        if (u(i)==max_valor)
            y(i) = 1;
        else
            y(i) = 0;
        end
    end
     
end

