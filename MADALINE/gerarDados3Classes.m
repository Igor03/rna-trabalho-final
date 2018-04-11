function [ dados, d_classe1, d_classe2, d_classe3 ] = gerarDados3Classes( tipo, qtdAmostras )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    if (tipo == 1)
        for i=1:qtdAmostras*3
            if (i <= qtdAmostras)
                x(i) = rand(1,1)+0.2;
                y(i) = rand(1,1)+1;
                classe1(i) = 0;
                classe2(i) = 0;
                classe3(i) = 1;
            elseif (i>qtdAmostras && i<=qtdAmostras*2)
                x(i) = rand(1,1)+2;
                y(i) = rand(1,1);
                classe1(i) = 0;
                classe2(i) = 1;
                classe3(i) = 0;
            else
                x(i) = rand(1,1)+1.5;
                y(i) = rand(1,1)+3;
                classe1(i) = 1;
                classe2(i) = 0;
                classe3(i) = 0;
            end
        end

        dados = horzcat(x', y');
        dados = normalizar(dados);
        classificacao = horzcat(classe1', classe2', classe3');
        dados = horzcat(dados, classificacao); % Definicao da base de dados
        d_classe1 = dados (1:qtdAmostras, :)';
        d_classe2 = dados (qtdAmostras+1:2*qtdAmostras, :)';
        d_classe3 = dados (2*qtdAmostras+1:3*qtdAmostras, :)';

    elseif (tipo==2)
        for i=1:qtdAmostras*3
            if (i <= qtdAmostras)
                x(i) = rand(1,1)+0.2;
                y(i) = rand(1,1)+1;
                classe1(i) = -1;
                classe2(i) = -1;
                classe3(i) = 1;
            elseif (i>qtdAmostras && i<=qtdAmostras*2)
                x(i) = rand(1,1)+2;
                y(i) = rand(1,1);
                classe1(i) = -1;
                classe2(i) = 1;
                classe3(i) = -1;
            else
                x(i) = rand(1,1)+1.5;
                y(i) = rand(1,1)+3;
                classe1(i) = 1;
                classe2(i) = -1;
                classe3(i) = -1;
            end
        end

        dados = horzcat(x', y');
        dados = normalizar(dados);
        classificacao = horzcat(classe1', classe2', classe3');
        dados = horzcat(dados, classificacao); % Definicao da base de dados
        d_classe1 = dados (1:qtdAmostras, :)';
        d_classe2 = dados (qtdAmostras+1:2*qtdAmostras, :)';
        d_classe3 = dados (2*qtdAmostras+1:3*qtdAmostras, :)';

    end

end

