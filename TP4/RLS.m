%% TP4 - Identification parametrique en ligne par RLS
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


%% Initilisiation RLS

lambda = 0.99;
sigma = 100;
P = sigma * eye(4); % initial covariance matrix
theta = zeros(4,1);
theta_history = zeros(4,N);

error_history = zeros(N,1);

%% Algo RLS
%u(k) = model output

for k = 1:N

    Ak = Y(k,:);

    % pre fit error
    e_pre = u(k) - Ak * theta;

    % RLS gain
    K = P * Ak' / (lambda + Ak * P * Ak');

    % pre fit covariance
    P = (1/lambda) * (eye(4) - K * Ak) * P;

    % Update state estimate
    theta = theta + K * e_pre;

    % Post fit error
    e_post = u(k) - Ak * theta;

    % Sauvegarde
    theta_history(:,k) = theta;
    error_history(k) = e_post;

end

%% Affichage des parametres finaux

disp('Parametres identifies par RLS :');
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
    title(['Evolution du parametre theta',num2str(j)]);
    legend('RLS','Offline LS');

end

sgtitle('Identification en ligne par RLS');

%% Evolution de l'erreur

figure;

plot(error_history,'LineWidth',1.2);
grid on;
xlabel('Echantillon k');
ylabel('Erreur');
title('Erreur apres correction RLS');

%% Comparaison des resultats

disp('Comparaison LS / RLS :');

disp('       LS          RLS');
disp([theta_LS theta]);
