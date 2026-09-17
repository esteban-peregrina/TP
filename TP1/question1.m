Cclear;
close all;
clc; % Pour la command window 

%% Déclaration des paramètres
definit_parametres

%% Simulation du système
simule_systeme

%% Sélection des mesures
N = 801; % Nombre de mesures
%N = length(t); %bcp de mesure (801)

% On varie les mesures
indice = 1:N; % N mesures, indice vaut 0.01s, 0.02s, 0.03s, ...
%indice = round(linspace(1, length(t), N)); % N mesures, indice vaut 1s, 2s, 3s , ...
%indice = [113 168 206]; % Points remarquables pour avoir des equations indépendantes et trouver les parametre en seulement 3 mesures

% Récupération des mesures
alpha = alpha(indice);
vit_alpha = vit_alpha(indice);
acc_alpha = acc_alpha(indice);

beta = beta(indice);
vit_beta = vit_beta(indice);
acc_beta = acc_beta(indice);

gamma = gamma(indice);
vit_gamma = vit_gamma(indice);
acc_gamma = acc_gamma(indice);

%% Identification des paramètres
identifie_parametres % Appel les mesures en mémoire

%% Affichage des paramètres
parametres_identifie = p_find.' ; % On transpose p_find (écrit en mémoire par identifie_parametres)
parametre_reel = [k0 k1 k2 b0 b1 b2 m1 m2 m3];

% Erreur en pourcentage
erreur = 100 * abs(parametres_identifie - parametre_reel) ./ parametre_reel;

fprintf('Paramètre        reel        identifie       Erreur (%%) \n\n');
fprintf('k0         %f      %f      %f\n', k0, k0_find, erreur(1));
fprintf('k1         %f      %f      %f\n', k1, k1_find, erreur(2));
fprintf('k2         %f      %f      %f\n', k2, k2_find, erreur(3));
fprintf('b0         %f      %f      %f\n', b0, b0_find, erreur(4));
fprintf('b1         %f      %f      %f\n', b1, b1_find, erreur(5));
fprintf('b2         %f      %f      %f\n', b2, b2_find, erreur(6));
fprintf('m1         %f      %f      %f\n', m1, m1_find, erreur(7));
fprintf('m2         %f      %f      %f\n', m2, m2_find, erreur(8));
fprintf('m3         %f      %f      %f\n', m3, m3_find, erreur(9));
