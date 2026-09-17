clear all;
close all;
clc;

%% Déclaration des paramètres
definit_parametres
% Écrasement des paramètres par défaut
k1 = 5000;
b1 = 400;

%% Simulation du système
simule_systeme

%% Quantification
% Déclaration des pas de quantification
pas_pos = 0.00001;
pas_vit = 0.0001;
pas_acc = 0.001;

% Quantification virtuelle
alpha_quantifiee = pas_pos * round(alpha * 100000);
beta_quantifiee = pas_pos * round(beta * 100000);
gamma_quantifiee = pas_pos * round(gamma * 100000);

vit_alpha_quantifiee = pas_vit * round(vit_alpha * 10000);
vit_beta_quantifiee = pas_vit * round(vit_beta * 10000);
vit_gamma_quantifiee = pas_vit * round(vit_gamma * 10000);

acc_alpha_quantifiee = pas_acc* round(acc_alpha * 1000);
acc_beta_quantifiee = pas_acc * round(acc_beta * 1000);
acc_gamma_quantifiee = pas_acc * round(acc_gamma * 1000);

% Écrasement des mesures réelles
alpha = alpha_quantifiee;
beta = beta_quantifiee;
gamma = gamma_quantifiee;

vit_alpha = vit_alpha_quantifiee;
vit_beta = vit_beta_quantifiee;
vit_gamma = vit_gamma_quantifiee;

acc_alpha = acc_alpha_quantifiee;
acc_beta = acc_beta_quantifiee;
acc_gamma = acc_gamma_quantifiee;

%% Filtrage
% Choix du filtre
u = 0.8; % À déterminer expérimentalement

% Filtrage
f_alpha = filtfilt([1 u-1], u, alpha_quantifiee);
f_beta  = filtfilt([1 u-1], u, beta_quantifiee);
f_gamma = filtfilt([1 u-1], u, gamma_quantifiee);

f_vit_alpha = filtfilt([1 u-1], u, vit_alpha_quantifiee);
f_vit_beta  = filtfilt([1 u-1], u, vit_beta_quantifiee);
f_vit_gamma = filtfilt([1 u-1], u, vit_gamma_quantifiee);

f_acc_alpha = filtfilt([1 u-1], u, acc_alpha_quantifiee);
f_acc_beta  = filtfilt([1 u-1], u, acc_beta_quantifiee);
f_acc_gamma = filtfilt([1 u-1], u, acc_gamma_quantifiee);

% Comparaison graphique des signaux filtrés et quantifiés
figure;

subplot(3,1,1)
plot(t,alpha_quantifiee)
hold on
plot(t,f_alpha)
legend('Quantifié','Filtré')
title('Position alpha')

subplot(3,1,2)
plot(t,vit_alpha_quantifiee)
hold on
plot(t,f_vit_alpha)
legend('Quantifié','Filtré')
title('Vitesse alpha')

subplot(3,1,3)
plot(t,acc_alpha_quantifiee)
hold on
plot(t,f_acc_alpha)
legend('Quantifié','Filtré')
title('Accélération alpha')

%% Sélection des mesures
N = 801; % Nombre de mesures
%N = length(t); %bcp de mesure (801)

% On varie les mesures
indice = 1:N; % N mesures, indice vaut 0.01s, 0.02s, 0.03s, ...
%indice = round(linspace(1, length(t), N)); % N mesures, indice vaut 1s, 2s, 3s , ...
%indice = [113 168 206]; % Points remarquables pour avoir des equations indépendantes et trouver les parametre en seulement 3 mesures

% Récupération des mesures
alpha = f_alpha(indice);
vit_alpha = f_vit_alpha(indice);
acc_alpha = f_acc_alpha(indice);

beta = f_beta(indice);
vit_beta = f_vit_beta(indice);
acc_beta = f_acc_beta(indice);

gamma = f_gamma(indice);
vit_gamma = f_vit_gamma(indice);
acc_gamma = f_acc_gamma(indice);

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

erreur_moyenne = mean(erreur);
fprintf('Erreur Moyenne : %f\n', erreur_moyenne);