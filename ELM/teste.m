clc; clear all; close all;

dados  = load('iris.txt');
dataset_inf = dados(1,:);
dados = normalizar(dados(2:end,:));

qtd_classes = dataset_inf(1);
qtd_atributos = dataset_inf(2);
qtd_padroes = dataset_inf(3);
qtd_cam_ocultas = 6;

W = rand(qtd_cam_ocultas, qtd_atributos+1);
M = rand(qtd_classes, qtd_cam_ocultas+1);

X = dados(:, 1:size(dados, 2)-qtd_classes);
X = [-ones(size(X, 1), 1) X];
D = dados (:,qtd_atributos+1:end);



H = zeros(1, qtd_atributos+1);

% Ida (FeedForward)
for i=1:qtd_padroes
    U = logsig(W*X(i,:)')
    h = (W\U)';
    H = vertcat(H, h);
end

H = horzcat(-ones(qtd_padroes, 1), H(2:end, :));

M = H\D
M'*H(1,:)'
M'*H(2,:)'

count = 0;
for i=1:qtd_padroes
    y = ativacao (M'*H(i,:)')
    if (isequal(y, D(i,:)))
        count = count+1;
    end
end
taxa = count/qtd_padroes
