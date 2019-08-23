clear, clc, close all
%% -------------------------------------------------------------------------
%% Funciones de Forma Lagrangianas de dos nodos

% Calculo las funciones de forma
syms xi
N1 = factor(poly2sym(polyfit([-1 1],[1 0],1),xi));
N2 = factor(poly2sym(polyfit([-1 1],[0 1],1),xi));

% Imprimo las funciones de forma
fprintf('\n\nFunciones de Forma Lagrangianas de DOS nodos:\n')
fprintf('\n\nN1 = '), pretty(N1)
fprintf('\n\nN2 = '), pretty(N2)

% Grafico las funciones de forma
figure                 % Creo un lienzo
grid on                % creo la rejilla
hold on;               % Para que no se sobreescriban los graficos
h1 = ezplot(N1, [-1 1]); set(h1, 'Color', 'r', 'LineWidth', 2);   
h2 = ezplot(N2, [-1 1]); set(h2, 'Color', 'b', 'LineWidth', 2);   
legend('N1(\xi)','N2(\xi)','Location','Best'); % Caja de dialogo
title('Funciones de Forma Lagrangianas de DOS nodos')
xlabel('\xi'); 
ylabel('N_i(\xi)');
plot([-1 1],[0 0], 'ko', [-1 1],[1 1], 'ko') % grafico los nodos

%% -------------------------------------------------------------------------
%% Funciones de Forma Lagrangianas de tres nodos

% Calculo las funciones de forma
syms xi
N1 = factor(poly2sym(polyfit([-1 0 1],[1 0 0],2),xi)); % = xi*(xi-1)/2
N2 = factor(poly2sym(polyfit([-1 0 1],[0 1 0],2),xi)); % = (1+xi)*(1-xi)
N3 = factor(poly2sym(polyfit([-1 0 1],[0 0 1],2),xi)); % = xi*(xi+1)/2

% Imprimo las funciones de forma
fprintf('\n\nFunciones de Forma Lagrangianas de TRES nodos:\n')
fprintf('\n\nN1 = '), pretty(N1)
fprintf('\n\nN2 = '), pretty(N2)
fprintf('\n\nN3 = '), pretty(N3)

% Grafico las funciones de forma
figure                 % Creo un lienzo
grid on                % creo la rejilla
hold on;               % Para que no se sobreescriban los graficos
h1 = ezplot(N1, [-1 1]); set(h1, 'Color', 'r', 'LineWidth', 2);   
h2 = ezplot(N2, [-1 1]); set(h2, 'Color', 'b', 'LineWidth', 2);   
h3 = ezplot(N3, [-1 1]); set(h3, 'Color', 'c', 'LineWidth', 2);    
legend('N1(\xi)','N2(\xi)','N3(\xi)','Location','Best'); % Caja de dialogo
title('Funciones de Forma Lagrangianas de TRES nodos')
xlabel('\xi'); 
ylabel('N_i(\xi)');
plot([-1 0 1],[0 0 0], 'ko', [-1 0 1],[1 1 1], 'ko') % grafico los nodos

%% -------------------------------------------------------------------------
%% Funciones de Forma Lagrangianas de cuatro nodos

% Calculo las funciones de forma
syms xi
N1 = factor(poly2sym(polyfit([-1 -1/3 1/3 1],[1 0 0 0],3),xi));
N2 = factor(poly2sym(polyfit([-1 -1/3 1/3 1],[0 1 0 0],3),xi));
N3 = factor(poly2sym(polyfit([-1 -1/3 1/3 1],[0 0 1 0],3),xi));
N4 = factor(poly2sym(polyfit([-1 -1/3 1/3 1],[0 0 0 1],3),xi));

% Imprimo las funciones de forma
fprintf('\n\nFunciones de Forma Lagrangianas de CUATRO nodos:\n')
fprintf('\n\nN1 = '), pretty(N1);  fprintf('\n\nN2 = '), pretty(N2)
fprintf('\n\nN3 = '), pretty(N3);  fprintf('\n\nN4 = '), pretty(N4)

% Grafico las funciones de forma
figure                 % Creo un lienzo
grid on                % creo la rejilla
hold on;               % Para que no se sobreescriban los graficos
h1 = ezplot(N1, [-1 1]); set(h1, 'Color', 'r', 'LineWidth', 2);   
h2 = ezplot(N2, [-1 1]); set(h2, 'Color', 'b', 'LineWidth', 2);   
h3 = ezplot(N3, [-1 1]); set(h3, 'Color', 'c', 'LineWidth', 2);    
h4 = ezplot(N4, [-1 1]); set(h4, 'Color', 'm', 'LineWidth', 2);    
legend('N1(\xi)','N2(\xi)','N3(\xi)','N4(\xi)','Location','Best');
title('Funciones de Forma Lagrangianas de CUATRO nodos')
xlabel('\xi'); 
ylabel('N_i(\xi)');
plot([-1 -1/3 1/3 1],[0 0 0 0], 'ko', [-1 -1/3 1/3 1],[1 1 1 1], 'ko')
axis([-1 1 -0.4 1.2])
