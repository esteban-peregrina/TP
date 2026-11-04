
clear;
clc;

% Parametres du robot
p = [0.2; 0.3; 0.2; 0.1; -0.1; 0.08; 0.1; 0.03; 0.025; 0.6];

% Dix configurations articulaires (en radians)
Q = [
    0       0       0;
    pi/6    pi/6    pi/6;
    pi/4   -pi/6    pi/3;
    -pi/4    pi/3   -pi/6;
    pi/2    0      -pi/4;
    -pi/3   -pi/4    pi/2;
    pi/3    pi/2   -pi/3;
    -pi/2    pi/6    pi/4;
    pi/6   -pi/2   -pi/3;
    -pi/3    pi/4    pi/6
    ];

% Construction du Jacobien global
N = size(Q,1);
Jglobal = zeros(3*N,10);

for k = 1:N
    lignes = 3*k-2:3*k;
    Jglobal(lignes,:) = jacobien(Q(k,:)',p);
end

% Affichage
disp('Dimension du Jacobien global :');
disp(size(Jglobal));

% Calcul du rang
s = svd(Jglobal);
disp('Valeurs singulieres :');
disp(s);

tol = 1e-8*s(1);
rang = sum(s > tol);

disp('Rang avec tolerance relative :');
disp(rang);

