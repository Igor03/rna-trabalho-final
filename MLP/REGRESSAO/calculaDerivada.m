function [ vetorDeDerivadas ] = calculaDerivada( vetor )
    %UNTITLED2 Summary of this function goes here
    %   Detailed explanation goes here
    vetorDeDerivadas = zeros(1, length(vetor));
    for i=1:length(vetor)
       vetorDeDerivadas(i) = vetor(i)*(1-vetor(i)); 
    end
    
end

