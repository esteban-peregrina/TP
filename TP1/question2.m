clear all;
close all;
clc;

%% Declaration des paramètres
definit_parametres


%% simulation du système
simule_systeme

%quantification
alpha_quantifiee = 0.00001 * round(alpha * 100000);
beta_quantifiee = 0.00001 * round(beta * 100000);
gamma_quantifiee = 0.00001 * round(gamma * 100000);

vit_alpha_quantifiee = 0.0001 * round(vit_alpha * 10000);
vit_beta_quantifiee = 0.0001 * round(vit_beta * 10000);
vit_gamma_quantifiee = 0.0001 * round(vit_gamma * 10000);

acc_alpha_quantifiee = 0.001 * round(acc_alpha * 1000);
acc_beta_quantifiee = 0.001 * round(acc_beta * 1000);
acc_gamma_quantifiee = 0.001 * round(acc_gamma * 1000);

alpha = alpha_quantifiee;
beta = beta_quantifiee;
gamma = gamma_quantifiee;
vit_alpha = vit_alpha_quantifiee;
vit_beta = vit_beta_quantifiee;
vit_gamma = vit_gamma_quantifiee;
acc_alpha = acc_alpha_quantifiee;
acc_beta = acc_beta_quantifiee;
acc_gamma = acc_gamma_quantifiee;

%% identification des paramètres
N = 9; % nombre de mesures
%N = length(t); %bcp de mesure (801)

%on varie les mesures

indice = 1:N; %9 mesures, indice à 0.01s, 0.02s 0.03s
%indice = round(linspace(1, length(t), N)); %9 mesures, indice à 1s, 2s, 3s ,...
%indice = [113 168 206]; %point interresant pour avoir des equations indépendantes et trouver les parametre en seulement 3 mesures


alpha = alpha(indice);
vit_alpha = vit_alpha(indice);
acc_alpha = acc_alpha(indice);

beta = beta(indice);
vit_beta = vit_beta(indice);
acc_beta = acc_beta(indice);

gamma = gamma(indice);
vit_gamma = vit_gamma(indice);
acc_gamma = acc_gamma(indice);

identifie_parametres

parametres_identifie = p_find' ;
parametre_reel = [k0 k1 k2 b0 b1 b2 m1 m2 m3];

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
