clear, clc, close all

%% -------------------------------------------------------------------------
%% Funciones de forma del elemento hexahedrico serendipito de 20 nodos

% Calculo las funciones de forma unidimensionales
syms xi eta zeta 

% Coordenadas de los nodos
%
% Numeracion local:
%      ^ eta             para zeta = -1
%      |
%      |
%  7---6---5
%  |   |   |
%  8---+---4----> xi
%  |   |   |
%  1---2---3
%
% Numeracion local:
%      ^ eta             para zeta = 0
%      |
%      |
% 12---+--11
%  |   |   |
%  +---+---+----> xi
%  |   |   |
%  9---+--10
%
% Numeracion local:
%      ^ eta             para zeta = +1
%      |
%      |
% 19--18--17
%  |   |   |
% 20---+--16----> xi
%  |   |   |
% 13--14--15




nod = [ ...
%  xi   eta  zeta   nodo
   -1   -1   -1   %  1
    0   -1   -1   %  2
    1   -1   -1   %  3
    1    0   -1   %  4
    1    1   -1   %  5
    0    1   -1   %  6
   -1    1   -1   %  7
   -1    0   -1   %  8
   -1   -1    0   %  9
    1   -1    0   % 10
    1    1    0   % 11
   -1    1    0   % 12
   -1   -1    1   % 13
    0   -1    1   % 14
    1   -1    1   % 15
    1    0    1   % 16
    1    1    1   % 17
    0    1    1   % 18
   -1    1    1   % 19
   -1    0    1 ];% 20

% Se calculan las funciones de forma bidimensionales
N = cell(20,1);
for i = 1:20   % se arma el sistema de ecuaciones
   A = zeros(20,20);
   b = zeros(20,1);
   for j = 1:20
      xxi   = nod(j,1);
      eeta  = nod(j,2);
      zzeta = nod(j,3);
      A(j,:) = [ 1 ...
                 xxi eeta zzeta ...
                 xxi^2 xxi*eeta eeta^2 eeta*zzeta zzeta^2 xxi*zzeta ...
                 xxi^2*eeta xxi*eeta^2  eeta^2*zzeta eeta*zzeta^2  xxi*zzeta^2 xxi^2*zzeta  xxi*eeta*zzeta ...
                 xxi^2*eeta*zzeta xxi*eeta^2*zzeta xxi*eeta*zzeta^2 ];
      b(j)   = double(i == j);
   end;
   coef_alpha = A\b;
   N{i} = simple([ 1 ...
                   xi eta zeta ...
                   xi^2 xi*eta eta^2 eta*zeta zeta^2 xi*zeta ...
                   xi^2*eta xi*eta^2  eta^2*zeta eta*zeta^2  xi*zeta^2 xxi^2*zeta  xi*eta*zeta ...
                   xi^2*eta*zeta xi*eta^2*zeta xi*eta*zeta^2 ]*coef_alpha);
end

% Imprimo las funciones de forma
fprintf('Funciones de forma serendipitas del elemento hexahedrico de 20 nodos:\n')
for i = 1:20
   fprintf('\nN%d = %s',i, char(N{i}));
end

% Se calculan las derivadas de las funciones de forma con respecto a xi, eta y 
% zeta y se imprimen (para referencias posteriores):
fprintf('\n\nDerivadas con respecto a xi:\n')
for i = 1:20
   fprintf('\ndN%d_dxi = %s',i, char(simple(diff(N{i},xi))))
end

fprintf('\n\nDerivadas con respecto a eta:\n')
for i = 1:20
   fprintf('\ndN%d_deta = %s',i, char(simple(diff(N{i},eta))))
end

fprintf('\n\nDerivadas con respecto a zeta:\n')
for i = 1:20
   fprintf('\ndN%d_dzeta = %s',i, char(simple(diff(N{i},zeta))))
end
fprintf('\n');

% Grafico las funciones de forma
XXI   = -1:0.05:1;
EETA  = -1:0.05:1;
ZZETA = -1:0.05:1;
[XI,ETA,ZETA] = meshgrid(XXI,EETA,ZZETA);

% Calculo las esferitas
[xsp,ysp,zsp] = sphere;
xsp = 0.025*xsp;
ysp = 0.025*ysp;
zsp = 0.025*zsp;

for i = 1:20
   figure                 % Creo un lienzo
   grid on                % creo la rejilla
   hold on;               % Para que no se sobreescriban los graficos
   
   % con este comando convierto la funcion de forma de tipo simbÃ³lico a
   % tipo funcion
%   funcion_texto = char(N{i});  % convierto la cadena a texto  
%   funcion_texto = strrep(funcion_texto,'*','.*'); % reemplazo * por .*
%   funcion_texto = strrep(funcion_texto,'^','.^'); % reemplazo ^ por .^   

   funcion_texto = vectorize(char(N{i}));  % convierto la formula a cadena
   NN = inline(funcion_texto,'xi','eta','zeta'); % cadena a funcion inline
   % se recomienda aqui mirar la ayuda de la funcion inline y vectorize
   
   xlabel('\xi',  'FontSize',26); % titulo eje X
   ylabel('\eta', 'FontSize',26); % titulo eje Y
   zlabel('\zeta','FontSize',26); % titulo eje Z
   title(sprintf('N_{%d}(\\xi,\\eta,\\zeta)',i),'FontSize',26); % titulo general
   
   xslice = [-1 0 1]; yslice = [-1 0 1]; zslice = [-1 0 1];
   slice(XI,ETA,ZETA,NN(XI,ETA,ZETA),xslice,yslice,zslice)
   line([nod([1 2 3 4 5 6 7 8 1 9 13 14 15 16 17 18 19 20 13],1); NaN; nod([3 10 15],1); NaN; nod([5 11 17],1); NaN; nod([7 12 19],1)], ...
        [nod([1 2 3 4 5 6 7 8 1 9 13 14 15 16 17 18 19 20 13],2); NaN; nod([3 10 15],2); NaN; nod([5 11 17],2); NaN; nod([7 12 19],2)], ...
        [nod([1 2 3 4 5 6 7 8 1 9 13 14 15 16 17 18 19 20 13],3); NaN; nod([3 10 15],3); NaN; nod([5 11 17],3); NaN; nod([7 12 19],3)], ...
        'LineWidth',2);

   shading interp         % se interpolan los colores   
   alpha 0.3              % opacidad de la superficie
   
   % se grafican las esferitas cada una centrada en (xi_j,eta_j,zeta_j)
   for j=1:20
      surf(xsp+nod(j,1), ysp+nod(j,2), zsp+nod(j,3));
      h = text(nod(j,1), nod(j,2), nod(j,3), num2str(j));
      set(h,'Color', [1 0 0], 'FontSize',16);
   end 
   
   axis tight             % ejes apretados
   daspect([1 1 1]);      % similar a axis equal pero en 3D
   view(3);               % vista tridimensional
end;

return %bye, bye!