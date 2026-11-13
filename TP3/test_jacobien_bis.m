
clear;
clc;

% Parametres du robot
%p = [0.2; 0.3; 0.2; 0.1; -0.1; 0.08; 0.1; 0.03; 0.025; 0.6];
p = [0.2; 0.5; 0.2; 0.5; 0; 0.0; 0.0; 0.00; 0.0; 0.0];


% Configuration articulaire
%theta = [0.2; 0.4; -0.3];
theta = [0; 0; -0.0];

% Calcul du Jacobien
J = jacobien(theta,p);

% Petite variation des 10 parametres
dp = 1e-5 * ones(10,1);

% Modele avec les parametres initiaux
X1 = modele_geom(theta,p);

% Modele avec les parametres modifies
X2 = modele_geom(theta,p+dp);

% Variation reelle calculee par le modele
dX_modele = X2-X1;

% Variation predite par le Jacobien
dX_jacobien = J*dp;

% Affichage des resultats
disp('Variation calculee par le modele :');
disp(dX_modele);

disp('Variation calculee par le Jacobien :');
disp(dX_jacobien);

disp('Erreur entre les deux resultats :');
disp(dX_modele-dX_jacobien);

disp('Norme de l erreur :');
disp(norm(dX_modele-dX_jacobien));
