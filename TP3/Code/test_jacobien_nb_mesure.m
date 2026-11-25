clear;
clc;

% Paramètres réels
p_reel = [0.2; 0.3; 0.2; 0.1; -0.1; 0.08; 0.1; 0.03; 0.025; 0.6];

p_reel_libre = [p_reel(2:4); p_reel(6:10)];

% Estimation initiale
p0 = [0.25; 0.25; 0.15; 0.02; 0.05; 0.05; 0.04; 0.4];

% Génération de 50 configurations articulaires
Nmax = 50;
Q = -pi + 2*pi*rand(Nmax,3);

% Mesures cartésiennes sans bruit
Xmes = zeros(3,Nmax);

for k = 1:Nmax
    Xmes(:,k) = modele_geom(Q(k,:)',p_reel);
end

% Ajout du bruit
sigma_xy = 0.001;
sigma_alpha = 0.002;

Xbruite = Xmes;
Xbruite(1:2,:) = Xbruite(1:2,:) + sigma_xy*randn(2,Nmax);
Xbruite(3,:) = Xbruite(3,:) + sigma_alpha*randn(1,Nmax);

% Nombres de mesures testés
liste_N = [3 5 10 20 50];

options = optimoptions('lsqnonlin','Display','off');

erreurs = zeros(length(liste_N),1);

for i = 1:length(liste_N)

    N = liste_N(i);

    Qtest = Q(1:N,:);
    Xtest = Xbruite(:,1:N);

    pest = lsqnonlin(@(p) residus(p,Qtest,Xtest), ...
        p0,[],[],options);

    erreurs(i) = norm(pest-p_reel_libre);

    fprintf('N = %d, erreur = %.6f\n',N,erreurs(i));

end

% Affichage graphique
figure;
plot(liste_N,erreurs,'o-','LineWidth',1.5);
xlabel('Nombre de mesures');
ylabel('Erreur sur les paramètres');
title('Influence du nombre de mesures');
grid on;