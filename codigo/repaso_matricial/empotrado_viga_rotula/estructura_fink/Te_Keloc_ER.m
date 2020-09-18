function [Te,Ke] = Te_Keloc_ER(A, E, I, x1, y1, x2, y2)
% Calcula de la matriz de transformacion T y de la matriz de rigidez 
% local Ke de una barra 
% empotrada a la izquierda y con 
% rotula a la derecha

%% Se calcula la longitud de la barra
L = sqrt((x2-x1)^2 + (y2-y1)^2);  

%% Se calcula la matriz T
c = (x2-x1)/L;   s = (y2-y1)/L;  % sin y cos de la inclinacion

Te = [ c  s  0  0  0
      -s  c  0  0  0
       0  0  1  0  0
       0  0  0  c  s
       0  0  0 -s  c ];

%% Se calcula la matriz K (ver: ls c1_K_elemento_empotrado_rodillo.m)
AE = A*E;  EI = E*I;  L2=L^2;  L3=L^3;

Ke = [  AE/L,           0,           0, -AE/L,           0
           0,   (3*EI)/L3,   (3*EI)/L2,     0,  -(3*EI)/L3
           0,   (3*EI)/L2,    (3*EI)/L,     0,  -(3*EI)/L2
       -AE/L,           0,           0,  AE/L,           0
           0,  -(3*EI)/L3,  -(3*EI)/L2,     0,   (3*EI)/L3 ];
    
return