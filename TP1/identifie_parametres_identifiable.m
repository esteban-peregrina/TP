A=[];
Y=[];
% on ne peut plus identifier k1 et b1.
% Comme ils sont grands, les deux premières masses sont "couplées" et leur mouvement presque identique
% On ne peut plus différencier alpha et beta, vit_alpha et vit_beta ni acc_alpha et acc_beta
% Donc les paramètres deviennent x=[k0; k2; b0; b2; m1+m2; m3]
%

phi = @(x) [x(1),  x(4)-x(7),      x(2),  x(5)-x(8),      x(3),        0;
            0   ,  x(7)-x(4),        0,  x(8)-x(5),          0,      x(9)]; %les colonnes de k1 et b1 disparaissent et le lignes associées à m1 et m2 sonr regroupées pour devenir (m1+m2)

for n = 1:N
    x = [alpha(n), vit_alpha(n), acc_alpha(n), beta(n), vit_beta(n), acc_beta(n), gamma(n), vit_gamma(n), acc_gamma(n)];

    A = [A; phi(x)];

    Y = [Y; 1 ; 0];
end 

size(A)
cond(A)

p_find = A \ Y;

k0_find = p_find(1);
k2_find = p_find(2);

b0_find = p_find(3);
b2_find = p_find(4);

m12_find = p_find(5);
m3_find = p_find(6);