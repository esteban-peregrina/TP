N = 9;

A=[];
Y=[];

phi = @(x) [x(1),  x(1)-x(4),          0,  x(2),  x(2)-x(5),          0,     x(3),        0,        0;
               0,  x(4)-x(1),  x(4)-x(7),     0,  x(5)-x(2),  x(5)-x(8),        0,     x(6),        0;
               0,          0,  x(7)-x(4),     0,          0,  x(8)-x(5),        0,        0,     x(9)   ];

for n = 1:N
    x = [alpha(n), vit_alpha(n), acc_alpha(n), beta(n), vit_beta(n), acc_beta(n), gamma(n), vit_gamma(n), acc_gamma(n)];

    A = [A; phi(x)];

    Y = [Y; 1 ; 0 ; 0];
end 

size(A)
cond(A)

p_find = A \ Y;

k0_find = p_find(1)
k1_find = p_find(2)
k2_find = p_find(3)

b0_find = p_find(4)
b1_find = p_find(5)
b2_find = p_find(6)

m1_find = p_find(7)
m2_find = p_find(8)
m3_find = p_find(9)