
%% TP4 - Comparaison RLS et Kalman
% Comparaison avec Offline Least Squares
close all;
clear;
clc;

%% Chargement des resultats

load('resultats_RLS.mat');

% Sauvegarde des resultats RLS dans des variables distinctes
RLS_history = theta_history;
RLS_final = theta;
LS_final = theta_LS;

RLS_error = error_history;

load('resultats_Kalman.mat');

% Sauvegarde des resultats Kalman
Kalman_history = theta_history;
Kalman_final = theta;

Kalman_error = error_history;


%% Comparaison des quatre parametres
N = size(RLS_history,2);

figure('Name','Comparaison RLS et Kalman');

for j = 1:4

    subplot(2,2,j);

    plot(1:N,RLS_history(j,:), 'b','LineWidth',1.5);
    hold on;
    plot(1:N,Kalman_history(j,:), 'g','LineWidth',1.5);
    yline(LS_final(j),'r--','LineWidth',1.5);
    grid on;
    xlabel('Echantillon k');
    ylabel(['Parametre p',num2str(j)]);
    title(['Comparaison du parametre p',num2str(j)]);
    legend('RLS','Kalman','Offline LS');

end

sgtitle('Comparaison des estimations parametriques');

%% Comparaison des erreurs

figure('Name','Comparaison des erreurs');

subplot(2,1,1);
plot(1:N,RLS_error,'b','LineWidth',1.2);
grid on;
xlabel('Echantillon k');
ylabel('Erreur');
title('Erreur apres correction - RLS');

subplot(2,1,2);

plot(1:N,Kalman_error,'g','LineWidth',1.2);
grid on;
xlabel('Echantillon k');
ylabel('Erreur');
title('Erreur apres correction - Kalman');

%% Calcul des RMSE

RMSE_RLS = sqrt(mean(RLS_error.^2));

RMSE_Kalman = sqrt(mean(Kalman_error.^2));

%% Tableau comparatif des parametres finaux

Comparaison = table( ...
    LS_final(:), ...
    RLS_final(:), ...
    Kalman_final(:), ...
    'VariableNames', ...
    {'Offline_LS','RLS','Kalman'}, ...
    'RowNames', ...
    {'p1','p2','p3','p4'});

disp('======================================');
disp(' COMPARAISON DES PARAMETRES FINAUX');
disp('======================================');

disp(Comparaison);

%% Affichage des erreurs RMSE

disp('======================================');
disp(' COMPARAISON DES ERREURS');
disp('======================================');

fprintf('RMSE RLS    = %.8f\n',RMSE_RLS);

fprintf('RMSE Kalman = %.8f\n',RMSE_Kalman);

%% Comparaison graphique des RMSE

figure('Name','Comparaison RMSE');

bar([RMSE_RLS RMSE_Kalman]);

set(gca,'XTickLabel',{'RLS','Kalman'});

ylabel('RMSE');

title('Comparaison des erreurs quadratiques moyennes');

grid on;

%% Conclusion numerique

if RMSE_RLS < RMSE_Kalman

    disp('Le RLS presente une erreur RMSE plus faible.');

elseif RMSE_Kalman < RMSE_RLS

    disp('Le filtre de Kalman presente une erreur RMSE plus faible.');

else

    disp('Les deux methodes ont la meme erreur RMSE.');

end