clear;
clc;

p_reel = [0.2; 0.3; 0.2; 0.1; -0.1; 0.08; 0.1; 0.03; 0.025; 0.6];

p_reel_libre = [p_reel(2:4); p_reel(6:10)];

p0 = [0.25; 0.25; 0.15; 0.02; 0.05; 0.05; 0.04; 0.4];

N = 30;

% Cas 1 : les trois angles varient
Q1 = -pi + 2*pi*rand(N,3);

% Cas 2 : seul theta1 varie
Q2 = zeros(N,3);
Q2(:,1) = -pi + 2*pi*rand(N,1);

% Cas 3 : theta1 et theta2 varient
Q3 = zeros(N,3);
Q3(:,1:2) = -pi + 2*pi*rand(N,2);

options = optimoptions('lsqnonlin','Display','off');

% Boucle sur les trois cas
Qliste = {Q1,Q2,Q3};


p_complet = p_reel;
for c = 1:3

    Qtest = Qliste{c};

    Xtest = zeros(3,N);

    for k = 1:N
        Xtest(:,k) = modele_geom(Qtest(k,:)',p_reel);
    end

    % Ajout du bruit cartésien
    Xtest(1:2,:) = Xtest(1:2,:) + 0.001*randn(2,N);
    Xtest(3,:) = Xtest(3,:) + 0.002*randn(1,N);

    % Identification
    pest = lsqnonlin(@(p) residus(p,Qtest,Xtest), p0,[],[],options);

    erreur = norm(pest-p_reel_libre);

    % Calcul de la Jacobienne réduite
    J = zeros(3*N,8);

    for k = 1:N
        Jlocal = jacobien(Qtest(k,:)',p_complet);

        J(3*k-2:3*k,:) = Jlocal(:,[2 3 4 6 7 8 9 10]);
    end

    rangJ = rank(J);

    fprintf('Cas %d : erreur = %.6f, rang = %d\n', c ,erreur,rangJ);

end