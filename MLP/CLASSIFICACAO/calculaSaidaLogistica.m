function [ y ] = calculaSaidaLogistica( u )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
    
    %sigmoid = @(x) 1/(1+exp(-x));
    y = zeros(length(u), 1);
    max_valor = max(logsig(u));
    for i=1:length(u)
        if (logsig(u(i))<max_valor)
            y(i) = 0;
        else
            y(i) = 1;
        end
    end
    
end

