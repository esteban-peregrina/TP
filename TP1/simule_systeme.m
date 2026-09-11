s = tf('s');

%% Transfer functions
% Cleaning equations 
F1 = k1+k0 + (b0+b1)*s + m1*s^2;
F2 = -(k1+b1*s);
F3 = F2;
F4 = k1+k2 + (b1+b2)*s + m2*s^2;
F5 = -(k2+b2*s);
F6 = F5;
F7 = k2 + b2*s + m3*s^2;

% Transfer functions
G1 = minreal(1/(F1-(F2*F3/(F4-F5*F6/F7))));
G2 = minreal(-F3*G1/(F4-F5*F6/F7));
G3 = minreal(-F6*G2/F7);

%% Simulations
t = 0:0.01:8;

alpha = step(G1, t);
vit_alpha = step(G1 * s, t);
acc_alpha = step(G1 * s^2, t);

beta = step(G2, t);
vit_beta = step(G2 * s, t);
acc_beta = step(G2 * s^2, t);

gamma = step(G3, t);
vit_gamma = step(G3 * s, t);
acc_gamma = step(G3 * s^2, t);

f = F1 * alpha + F2 * beta;

%% Plotting
subplot(3, 3, 1);
plot(t,alpha);

subplot(3, 3, 2);
plot(t,vit_alpha);

subplot(3, 3, 3);
plot(t,acc_alpha);

subplot(3, 3, 4);
plot(t,beta);

subplot(3, 3, 5);
plot(t,vit_beta);

subplot(3, 3, 6);
plot(t,acc_beta);

subplot(3, 3, 7);
plot(t,gamma);

subplot(3, 3, 8);
plot(t,vit_gamma);

subplot(3, 3, 9);
plot(t,acc_gamma);