% Calculo de las funciones de forma del elemento de viga de Euler-Bernoulli

clear all, clc, close all

syms x xi alpha0 alpha1 alpha2 alpha3 w1 w2 dw_dx1 dw_dx2 L x1 x2

x2 = x1 + L;
xm = (x1+x2)/2;

%%     %%%%%%%%%%%%%%%%%%%%%%%%%% METODO 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('*** Metodo 1 para encontrar las funciones de forma *** \n\n')

%% Resulve el sistema de ecuaciones por alpha0, alpha1, alpha2 y alpha3
% aqui cada una de las lineas es igual a cero
r = solve(w1     - (alpha0 + alpha1*x1 + alpha2*x1^2 + alpha3*x1^3   ),... % = 0
          dw_dx1 - (          alpha1    + 2*alpha2*x1 + 3*alpha3*x1^2),... % = 0
          w2     - (alpha0 + alpha1*x2 + alpha2*x2^2 + alpha3*x2^3   ),... % = 0
          dw_dx2 - (          alpha1    + 2*alpha2*x2 + 3*alpha3*x2^2),... % = 0
          'alpha0','alpha1','alpha2','alpha3');

w = simple(r.alpha0 + r.alpha1*x + r.alpha2*x^2 + r.alpha3*x^3);

% reescribo las funciones de forma en terminos de xi
w = simple(subs(w, x, xi*L/2 + xm));

% Se factorizan w1, dw_dx1, w2, dw_dx2
w = collect(w,w1);
w = collect(w,dw_dx1);
w = collect(w,w2);
w = collect(w,dw_dx2);

% El programa retorno:
%w = 
%((L/2 + (L*xi)/2)^3/L^2 - (L/2 + (L*xi)/2)^2/L)*dw_dx2 + 
%(L/2 + (L*xi)/2 - (2*(L/2 + (L*xi)/2)^2)/L + (L/2 + (L*xi)/2)^3/L^2)*dw_dx1 + 
%((3*(L/2 + (L*xi)/2)^2)/L^2 - (2*(L/2 + (L*xi)/2)^3)/L^3)*w2 + 
%((2*(L/2 + (L*xi)/2)^3)/L^3 - (3*(L/2 + (L*xi)/2)^2)/L^2 + 1)*w1

% es decir:
%N1  = expand(simple((2*(L/2 + (L*xi)/2)^3)/L^3 - (3*(L/2 + (L*xi)/2)^2)/L^2 + 1));
%N1b = expand(simple(L/2 + (L*xi)/2 - (2*(L/2 + (L*xi)/2)^2)/L + (L/2 + (L*xi)/2)^3/L^2));
%N2  = expand(simple((3*(L/2 + (L*xi)/2)^2)/L^2 - (2*(L/2 + (L*xi)/2)^3)/L^3));
%N2b = expand(simple((L/2 + (L*xi)/2)^3/L^2 - (L/2 + (L*xi)/2)^2/L));
%
%N1  = xi^3/4 - (3*xi)/4 + 1/2
%N1b = (L*xi^3)/8 - (L*xi^2)/8 - (L*xi)/8 + L/8  -> falta dividir por L/2
%N2  = - xi^3/4 + (3*xi)/4 + 1/2
%N2b = (L*xi^3)/8 + (L*xi^2)/8 - (L*xi)/8 - L/8  -> falta dividir por L/2

N1  = expand(subs(w, {w1, dw_dx1, w2, dw_dx2} , {1, 0, 0, 0}));
N1b = expand(subs(w, {w1, dw_dx1, w2, dw_dx2} , {0, 1, 0, 0}));
N2  = expand(subs(w, {w1, dw_dx1, w2, dw_dx2} , {0, 0, 1, 0}));
N2b = expand(subs(w, {w1, dw_dx1, w2, dw_dx2} , {0, 0, 0, 1}));

N1b = simple(N1b/(L/2));
N2b = simple(N2b/(L/2));

%% Se muestra finalmente w
% Recuerde que 
% w(x) = N1(x)w1 + N1b(x)dw_dx1 + N2(x)w2 + N2b(x)dw_dx2
% en la siguiente expresion se pueden ver claramente los terminos de N1, N1b, N2 y N2b

disp('w(xi) = '); pretty(w)

disp('es decir:');

disp('w(xi) = ')
pretty(N1)
disp('*w1 + ')
pretty(N1b)
disp('(L/2)*dw_dx1 + ')
pretty(N2)
disp('*w2 + ')
pretty(N2b)
disp('(L/2)*dw_dx2')

disp(' ')
disp('Siendo las funciones de forma:');
disp('N1  = '); pretty(N1)
disp('N1b = '); pretty(N1b)
disp('N2  = '); pretty(N2)
disp('N2b = '); pretty(N2b)

%%     %%%%%%%%%%%%%%%%%%%%%%%%%% METODO 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n\n*** Metodo 2 para encontrar las funciones de forma *** \n\n')
clear % borro la memoria para enfatizar que es un procedimiento diferente

syms xi L E I q

% Planteo el sistema de ecuaciones y encuentro los coeficientes
x1 = -1; 
x2 =  1;
A = [ 1 x1 x1^2   x1^3              %x = [alpha0; alpha1; alpha2; alpha3];
      0  1 2*x1 3*x1^2
      1 x2 x2^2   x2^3
      0  1 2*x2 3*x2^2 ];
   
b = eye(4,4);

% cada columna de la solucion son los coeficientes de una de las funciones
% de forma
alpha = A\b;

%% Defino las funciones de forma
N = cell(4,1);
disp('Las funciones de forma son =')
nombre = {'N_1(xi)' 'Nb_1(xi)' 'N_2(xi)' 'Nb_2(xi)' };
for i = 1:4   
   N{i} = alpha(1,i) + alpha(2,i)*xi + alpha(3,i)*xi^2 + alpha(4,i)*xi^3;
   fprintf('%s = \n', nombre{i}); pretty(N{i});
end
   
%% Grafico las funciones de forma
XI  = -1:0.05:1;

figure % creo un lienzo
for i = 1:4   
      subplot(2,2,i);        % Divido el lienzo en 2x2 dibujos
      grid on                % creo la rejilla
      hold on;               % Para que no se sobreescriban los graficos   
      
      % con este comando convierto la funcion de forma de tipo simbolico a
      % tipo funcion
      NN = inline(vectorize(char(N{i})),'xi');
      % funcion simbolica a cadena y cadena a funcion inline
      % se recomienda aqui mirar la ayuda de las funciones 
      % char, inline y vectorize
      
      xlabel('\xi', 'FontSize',26); % titulo eje X
      title(strrep(nombre{i},'xi','\xi'), 'FontSize', 26);
      plot(XI, NN(XI),'LineWidth',2); % malla de alambre
      axis equal tight
end;


%% Calculo la matriz de funciones de forma y su derivada primera y segunda con respecto a xi
NN        = [N{1}   N{2}*L/2   N{3}   N{4}*L/2];
dNN_dxi   = diff(NN,xi);
dNN2_dxi2 = diff(NN,xi,2);
dNN3_dxi3 = diff(NN,xi,3);
disp('N = ');         pretty(NN);
disp('dNN_dxi = ');   pretty(dNN_dxi);
disp('dNN2_dxi2 = '); pretty(dNN2_dxi2);
disp('dNN3_dxi3 = '); pretty(dNN3_dxi3);

%% Calculo de la matriz Bf
Bf = simple(dNN2_dxi2*(4/L^2));
disp('Bf = '); pretty(Bf);

%% Calculo de la matriz K
K = simple(int(Bf.'*E*I*Bf*L/2,xi,-1,1));
disp('K = (E*I/L^3)*'); pretty(K/(E*I/L^3));

%% Calculo del vector de fuerzas nodales equivalentes por fuerzas masicas
f = simple(int(NN.'*q*L/2,xi,-1,1));
disp('f = q*L*'); pretty(f/(q*L));

%% Calculo de la matriz de masa consistente
syms rho A
M = simple(int(rho*A*NN.'*NN*L/2,xi,-1,1));
disp('M = rho*A*L/420*'); pretty(M/(rho*A*L/420));

return %bye, bye!
