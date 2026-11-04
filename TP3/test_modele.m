clear all;

%exemple de paramètre
%p = [0.2; 0.3; 0.2; 0.1; -0.1; 0.08; 0.1; 0.03; 0.025; 0.6];
p = [0.2; 0.5; 0.2; 0.5; 0; 0.0; 0.0; 0.00; 0.0; 0.0];

% Exemple de configuration articulaire
%theta = [0.2; 0.4; -0.3];
theta = [0; 0; -0.0];

% Calcul du modele
X = modele_geom(theta, p);

disp('Mesures predites [xm; ym; alpha_m] :');
disp(X);
