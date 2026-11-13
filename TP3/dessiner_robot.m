function dessiner_robot(theta, p)
% Extraction des paramètres
I0 = p(1);
I1 = p(2);
I2 = p(3);
I3 = p(4);
theta_o1 = p(5);
theta_o2 = p(6);
theta_o3 = p(7);

% Angles absolus
b1 = theta(1) + theta_o1;
b2 = theta(1) + theta_o1 + theta(2) + theta_o2;
b3 = theta(1) + theta_o1 + theta_o2 + theta(3) + theta_o3; % Ajusté selon vos formules

% --- Calcul des points successifs dans R0 ---
% 1. Origine du repère (0,0)
x_orig = 0;
y_orig = 0;

% 2. Fin de l'offset I0 (début du premier segment articulé)
x_base = 0;
y_base = I0;

% 3. Fin du segment I1
x1 = I1 * cos(b1);
y1 = I0 + I1 * sin(b1);

% 4. Fin du segment I2
x2 = x1 + I2 * cos(b2);
y2 = y1 + I2 * sin(b2);

% 5. Fin du segment I3 (Effecteur final) correspondant à x0, y0
x3 = x2 + I3 * cos(b3);
y3 = y2 + I3 * sin(b3);

% Vecteurs de coordonnées pour le tracé
X = [x_orig, x_base, x1, x2, x3];
Y = [y_orig, y_base, y1, y2, y3];

% --- Tracé graphique ---
figure('Name', 'Visualisation du Robot 2D', 'Color', 'white');
plot(X, Y, '-o', 'LineWidth', 3, ...
    'MarkerSize', 8, ...
    'MarkerFaceColor', 'r', ...
    'MarkerEdgeColor', 'k');
hold on;



% Réglage des axes
max_reach = abs(I0) + I1 + I2 + I3 + 0.5;
xlim([-max_reach, max_reach]);
ylim([-max_reach, max_reach]);

xlabel('X_0 (m)');
ylabel('Y_0 (m)');
title('Tracé du robot : I_0 puis I_1, I_2, I_3');

% Annotations
text(x_orig, y_orig, ' (0,0)', 'VerticalAlignment', 'top');
text(x_base, y_base, ' Base (I_0)', 'VerticalAlignment', 'bottom');
text(x3, y3, ' Effecteur (x_0, y_0)', 'VerticalAlignment', 'bottom');

hold off;
end

