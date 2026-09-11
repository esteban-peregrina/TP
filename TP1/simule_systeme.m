%% transfer functions
F1 = [k1+k0 , b0+b1, m1]
F2 = -[k1, b1];
F3 = F2;
F4 = [k1+k2, b1+b2, m2];
F5 = -[k2, b2];
F6 = F5;
F7 = [k2, b2, m3];

G1 = minreal(1/(F1-(F2F3/(F4-F5*F6/F7))));
G2 = minreal(-F3*G1/(F4-F5*F6/F7));
G3 = minreal(-F6*G2/F7);

t = 0:0.01:8;

alpha = step(G1, t);
vit_alpha = step(G1 * s, t);
acc_alpha = step(G1 * s^2, t);

beta = step(G1, t);
vit_beta = step(G1 * s, t);
acc_beta = step(G1 * s^2, t);

gamma = step(G1, t);
vit_gamma = step(G1 * s, t);
acc_gamma = step(G1 * s^2, t);

f = F1 * alpha + F2 * beta;
