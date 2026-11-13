clear all;
clc;

% Paramètres réels
p_reel = [0.2; 0.3; 0.2; 0.1; -0.1; 0.08; 0.1; 0.03; 0.025; 0.6];


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

N=size(Q,1);
X_mes = zeros(3,N);

for k = 1:N
    X_mes(:, k) = modele_geom(Q(k,:)', p_reel);
end


p_reel_libre = [p_reel(2:4); p_reel(6:10)]; % On fixe I0 (p_reel(1) et theta_O1 p_reel(5)

p0 = [0.25; 0.25; 0.15; 0.02; 0.05; 0.05; 0.04; 0.4]; %estimation initiale diff


% Options de l'optimisation
options = optimoptions('lsqnonlin', 'Display','iter', 'FunctionTolerance',1e-12, 'StepTolerance',1e-12);
%lsquonlin cherche les paramètres minimisant la somme des carré des résidus


% Identification des paramètres
[p_estime,resnorm] = lsqnonlin(  @(p) residus(p,Q,X_mes),  p0,[],[],options);

% Reconstruction du vecteur complet estimé
p_complet = [0.2; p_estime(1:3); -0.1; p_estime(4:8)];

% Affichage des résultats
disp('Paramètres réels :');
disp(p_reel);

disp('Paramètres estimés :');
disp(p_complet);

disp('Erreur entre les paramètres :');
disp(p_complet-p_reel);