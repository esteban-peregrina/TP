

function J = jacobien(theta,p)

% Parametres geometriques
I0 = p(1);
I1 = p(2);
I2 = p(3);
I3 = p(4);

theta_o1 = p(5);
theta_o2 = p(6);
theta_o3 = p(7);

x_c = p(8);
y_c = p(9);
alpha_c = p(10);

% Angles absolus
b1 = theta(1) + theta_o1;
b2 = theta(1) + theta_o1 + theta(2) + theta_o2;
b3 = theta(1) + theta_o1 + theta(2) + theta_o2 + theta(3) + theta_o3;

% Position dans le repere R0
x0 = I1*cos(b1) + I2*cos(b2) + I3*cos(b3);
y0 = I0 + I1*sin(b1) + I2*sin(b2) + I3*sin(b3);

% Coordonnees dans le repere de mesure
c = cos(alpha_c);
s = sin(alpha_c);

xm = c*(x0-x_c) + s*(y0-y_c);
ym = -s*(x0-x_c) + c*(y0-y_c);

% Matrice de rotation
RT = [c s 0;
    -s c 0;
    0 0 1];

% Initialisation de la Jacobienne
J = zeros(3,10);

% Derivees par rapport aux longueurs
J(:,1) = RT*[0; 1; 0];

J(:,2) = RT*[cos(b1); sin(b1); 0];

J(:,3) = RT*[cos(b2); sin(b2); 0];

J(:,4) = RT*[cos(b3); sin(b3); 0];

% Derivees par rapport aux offsets angulaires
J(:,5) = RT*[-I1*sin(b1)-I2*sin(b2)-I3*sin(b3);
    I1*cos(b1)+I2*cos(b2)+I3*cos(b3);
    1];

J(:,6) = RT*[-I2*sin(b2)-I3*sin(b3);
    I2*cos(b2)+I3*cos(b3);
    1];

J(:,7) = RT*[-I3*sin(b3);
    I3*cos(b3);
    1];

% Derivees par rapport aux coordonnees du repere Rc
J(:,8) = [-c; s; 0];

J(:,9) = [-s; -c; 0];

% Derivee par rapport a l'orientation du repere Rc
J(:,10) = [ym; -xm; -1];

end
