clc, clear all, close all

disp('Algoritmo para projeto de compensadores - Metódo "A curva de reação"');

disp('Informe os coeficientes da planta');
num = input('Numerador (entre colchetes): ');
den = input('Denominador (entre colchetes): ');

disp('A planta é a seguinte: ');
g = tf(num, den)

disp('Trace a reta tangente a curva (Voce tem 40 segundos para isso)');
step(g)
pause on
pause(40)
disp('Agora escolha os pontos (Primeiro o inferior, depois o superior)');
pontos = ginput(2)

l = pontos(1,1);
tal = pontos(2,1) - l;
a = pontos(2,2);
r = a/tal;

disp('Escolha o compensador');
n = input('1-P 2-PI 3-PID: ');
switch n
    case 1
       kp = 1/(r*l);
       ti = 0;
       td = 0;
    case 2
        kp = 0.9/(r*l);
        ti = l/0.3;
        td = 0;
    case 3
        kp = 1.2/(r*l);
        ti = 2*l;
        td = 0.5*l;
end

syms s

disp('A função de transferencia do compensador é a seguinte: ')
c = tf([kp*td kp kp/ti], [1 0])

figure(1)
step(g)
title('Resposta ao degrau sem compensador');
xlabel('Tempo');
ylabel('y(t)');

h = series(g, c);
j = feedback(h, 1);

figure(2)
step(j)
title('Resposta ao degrau com compensador');
xlabel('Tempo');
ylabel('y(t)');

