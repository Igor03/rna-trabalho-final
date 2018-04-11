clc; clear all;

taxaDeAcertosIris = [.9667; .9667; .9667; .9667; .9000; .8333; .9667; .9667; .9333; .9667];

figure(1)
plot(taxaDeAcertosIris, '--');
hold on
for i=1:10
   scatter(i, taxaDeAcertosIris(i), 'o', 'black');
   hold on;
end
title('Taxa de Acertos para "Iris"');
xlabel('Realizações');
ylabel('Taxa de acerto');
hold off;

taxaDeAcertosColuna = [.7833; .8; .7833; .7833; .8187; .8333; .8333; .7833; .8333; .8333];

figure(2)
plot(taxaDeAcertosColuna, '--');
hold on
for i=1:10
   scatter(i, taxaDeAcertosColuna(i), 'o', 'black');
   hold on;
end
title('Taxa de Acertos para "Coluna Vertebral"');
xlabel('Realizações');
ylabel('Taxa de acerto');
hold off;

taxaDeAcertosDerma = [1.0000
    0.9063;
    0.9896;
    0.9896;
    1.0000;
    1.0000;
    0.9896;
    0.9063;
    0.9792;
    0.9063];

figure(2)
plot(taxaDeAcertosDerma, '--');
hold on
for i=1:10
   scatter(i, taxaDeAcertosDerma(i), 'o', 'black');
   hold on;
end
title('Taxa de Acertos para "Dermatologia"');
xlabel('Realizações');
ylabel('Taxa de acerto');
hold off;
