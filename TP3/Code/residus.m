function r = residus(p_libre,Q,Xmes)

% Paramètres fixés
I0 = 0.2;
theta_o1 = -0.1;

% Reconstruction du vecteur complet
p = [I0; p_libre(1:3); theta_o1; p_libre(4:8)];

N = size(Q,1);
r = zeros(3*N,1);

for k = 1:N

    % Valeurs prédites par le modèle
    Xpred = modele_geom(Q(k,:)',p);

    % Calcul des résidus
    lignes = 3*k-2:3*k;
    r(lignes) = Xmes(:,k) - Xpred;

end

end