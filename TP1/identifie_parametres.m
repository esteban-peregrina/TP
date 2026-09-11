N = length(t);

A=[];
Y=[];

phi = @(x) [x(1), x(1)-x(4),          0,     0, x(2)-x(5),         0,       x(3),        0,        0;
            0   , x(4)-x(1),  x(4)-x(7),     0, x(5)-x(2), x(5)-x(8),          0,     x(6),        0;
            0   ,         0,  x(7)-x(4),     0,         0, x(8)-x(5),          0,        0,      x(9)];

for n = 1:N
    x = [alpha(n), vit_alpha(n), acc_alpha(n), beta(n), vit_beta(n), acc_beta(n), gamma(n), vit_gamma(n), acc_gamma(n)];

    A = [A; phi(x)];

    Y = [Y; 1 ; 0 ; 0];
end 

size(A)
cond(A)

p_find = A \ Y;

k0_find = x_find(0);
k1_find = x_find(1);
k2_find = x_find(2);

b0_find = x_find(3);
b1_find = x_find(4);
b2_find = x_find(5);

m1_find = x_find(6);
m2_find = x_find(7);
m3_find = x_find(8);