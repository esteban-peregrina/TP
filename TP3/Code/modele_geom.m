function X = modele_geom(theta,p)
%paramètres
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

%angle absolu
b1 = theta(1) + theta_o1;
b2 = theta(1) + theta_o1 + theta(2) + theta_o2;
b3 = theta(1) + theta_o1 + theta(2) + theta_o2 + theta(3) + theta_o3;

%position du point terminal dans R0
x0 = I1*cos(b1) + I2*cos(b2) + I3*cos(b3) ;
y0 = I0 + I1*sin(b1) + I2*sin(b2) + I3*sin(b3);

%passage dans Rc
xm = cos(alpha_c)*(x0-x_c) + sin(alpha_c)*(y0-y_c);
ym = -sin(alpha_c)*(x0-x_c) + cos(alpha_c)*(y0-y_c);
alpha_m = b3 - alpha_c;


X = [xm; ym; alpha_m];

end
