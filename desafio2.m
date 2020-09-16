clc, clear all, close all

disp('Algoritmo para projeto de compensadores - Metódo do "Ganho Critico"');

disp('Informe os coeficientes da planta');
num = input('Numerador (entre colchetes): ');
den = input('Denominador (entre colchetes): ');

disp('A planta é a seguinte: ');
g = tf(num, den)

[gm,Pm,w_crit,Wcp] = margin(g);

t_crit = 2*pi/w_crit;

disp('Escolha o compensador');
n = input('1-P 2-PI 3-PID: ');
switch n
    case 1
       kp = 0.5*gm;
       ti = Inf;
       td = 0;
    case 2
        kp = 0.45*gm;
        ti = t_crit/1.2;
        td = 0;
    case 3
        kp = 0.6*gm;
        ti = t_crit/2;
        td = t_crit/8;
end

syms s

disp('A função de transferencia do compensador é a seguinte: ')
c = tf([kp*td kp kp/ti], [1 0])

figure(1)
step(g)
title('Resposta ao degrau sem compensador');
xlabel('Tempo (segundos)');
ylabel('y(t)');

h = series(g, c);
j = feedback(h, 1);

figure(2)
step(j)
title('Resposta ao degrau com compensador');
xlabel('Tempo (segundos)');
ylabel('y(t)');