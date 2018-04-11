clc; clear;

% Base de dados
%dados = load('xor.txt');
dados = load('iris.txt');
%dados = load('artificial.txt');

% Setup da rede
qtdAtributos = 4;
qtdClasses = 3;
qtdCamadasOcultas = 5;
taxaAprendizagem = .4;
qtdEpocas = 500;

padroes = dados(:,1:qtdAtributos); 
desejadas = dados (:,qtdAtributos+1:end);

% Definindo conjunto de treinamento
treino = [-ones(size(padroes, 1), 1) padroes];

% Definindo matrizes de pesos
W = rand(qtdCamadasOcultas, qtdAtributos+1);
M = rand(qtdClasses, qtdCamadasOcultas+1);


for tempo=1:qtdEpocas
    
  for i=1:size(treino, 1)
      
      h = [-1;logsig(W*treino(i,:)')];
      y = logsig(M*h);
      erro = desejadas(i,:)'-y;
      yDeriv = calculaDerivada(y);
      % Ajustando os pesos da camada de saida
      M = M + taxaAprendizagem*(yDeriv'.*erro)*h';
      
      ERP = 0;      
      mAux = M(:,2:end);
      hAux = h(2:end);
      hDeriv = calculaDerivada(hAux);
      
      for j=1:size(mAux, 2)
          ERP(j) = mAux(:,j)'*(erro.*yDeriv');
      end
      %Ajustando os pesos da camada oculta
      W = W + taxaAprendizagem*(hDeriv.*ERP)'*treino(i,:);
      
  end

end

count = 0;
for i=1:150
    h = [-1;logsig(W*treino(i,:)')];
    y = calculaSaidaLogistica(M*h)';
    
    if ( isequal(y,desejadas(i,:)))
        count = count+1;
    end
    
end

100*(count/i)

















  