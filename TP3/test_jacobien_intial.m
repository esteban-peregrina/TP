clear;
clc;
rng(1);

% Paramètres réels
p_reel = [0.2; 0.3; 0.2; 0.1; -0.1; 0.08; 0.1; 0.03; 0.025; 0.6];

p_reel_libre = [p_reel(2:4); p_reel(6:10)];

% 30 configurations articulaires
N = 30;
Q = -pi + 2*pi*rand(N,3);

% Mesures cartésiennes
Xmes = zeros(3,N);

for k = 1:N
    Xmes(:,k) = modele_geom(Q(k,:)',p_reel);
end

% Ajout du bruit
Xmes(1:2,:) = Xmes(1:2,:) + 0.001*randn(2,N);
Xmes(3,:) = Xmes(3,:) + 0.002*randn(1,N);

% Options d'optimisation
options = optimoptions('lsqnonlin','Display','off');

% Nombre de tentatives
nb_essais = 20;

resultats = zeros(8,nb_essais);
couts = zeros(nb_essais,1);

for i = 1:nb_essais

    % Estimation initiale aléatoire
    p0 = p_reel_libre .* (0.5 + rand(8,1));

    % Identification
    [pest,resnorm] = lsqnonlin( ...
        @(p) residus(p,Q,Xmes),p0,[],[],options);

    resultats(:,i) = pest;
    couts(i) = resnorm;

    fprintf('Essai %d : cout = %.12f\n',i,resnorm);

end

% Affichage des résultats
disp('Paramètres réels :');
disp(p_reel_libre);

disp('Paramètres estimés pour chaque essai :');
disp(resultats);

disp('Valeurs du coût :');
disp(couts);