%% TP4 - Identification parametrique en ligne par filtre Kalman
close all;
clc;
clear;

%% Chargement des donnees

load releve_vit_cste_axe2;

%% Parametres connus

kc2 = 0.0525;
N2 = 4.5;

%% Construction du modele

for k=1:length(i2)
    Y(k,:) = [cos(q2(k)) sign(qp2(k)) qp2(k) 1];
    u(k,1) = N2*kc2*i2(k);
end

N = length(u);

%% Identification Offline

theta_LS = Y\u;

disp('Parametres identifies par LS (classique) :');
disp(theta_LS');

%% Initialisation Kalman

% Estimation initiale des parametres
theta = zeros(4,1);

% Covariance initiale
P = 100*eye(4);

% Covariance du bruit de processus
Q = 1e-6*eye(4); % 1e-6 mieux car ca converge vite et reste stable même si e-4 meilleur réulyat mais plus lent et plus d'oscillation

% Covariance du bruit de mesure
%residual = u - Y*theta_LS;
R = 2000 
%meilleur valeur R = 2000 compromis vitesse de convergenve/stabilité  

%% Initialisation des historiques

theta_history = zeros(4,N);

error_history = zeros(N,1);


%% Kalman Algo

for k = 1:N
    Ak = Y(k,:);

    %prediction

    theta_pred = theta;
    P_pred = P + Q;

    % update

    %pre fit error
    e_pre = u(k) - Ak * theta_pred;

    %pre fir covariance
    S = Ak * P_pred * Ak' + R;

    % Optimal Kalman gain
    K = (P_pred * Ak') / S;

    % Updated state estimate
    theta = theta_pred + K * e_pre;

    % Update covariance
    P = (eye(4) - K * Ak) * P_pred;

    % post fit error
    e_post = u(k) - Ak * theta;

    % history
    theta_history(:,k) = theta;
    error_history(k) = e_post;

end

%% Affichage des parametres finaux

disp('Parametres identifies par Kalman :');
disp(theta');

disp('Parametres identifies par LS :');
disp(theta_LS');

%% Evolution des quatre parametres

figure;
for j = 1:4

    subplot(2,2,j);

    plot(theta_history(j,:),'b','LineWidth',1.5);
    hold on;
    yline(theta_LS(j),'r--','LineWidth',1.5);
    grid on;
    xlabel('Echantillon k');
    ylabel(['p',num2str(j)]);
    title(['Evolution du parametre p',num2str(j)]);
    legend('Kalman','Offline LS');

end

sgtitle('Identification parametrique par filtre de Kalman');

%% Evolution de l'erreur

figure;

plot(error_history,'LineWidth',1.2);

grid on;
xlabel('Echantillon k');
ylabel('Erreur');
title('Erreur apres correction Kalman');

%% Affichage des matrices

disp('Matrice Q :');
disp(Q);

disp('Matrice R :');
disp(R);

disp('Covariance finale P :');
disp(P);

%% Sauvegarde des resultats Kalman

save('resultats_Kalman.mat', 'theta_history', 'theta', 'error_history', 'theta_LS');