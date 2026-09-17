A=[];
Y=[];

%% Data concatenation
% Defining concatenation matrix
phi = @(X) [X(1),   X(1)-X(4),           0,   X(2),   X(2)-X(5),           0,   X(3),      0,       0;
               0,   X(4)-X(1),   X(4)-X(7),      0,   X(5)-X(2),   X(5)-X(8),      0,   X(6),       0;
               0,           0,   X(7)-X(4),      0,           0,   X(8)-X(5),      0,      0,   X(9)];

% Adding data
for n = 1:N
    % Data vector (depends on parameters)
    X = [alpha(n), 
     vit_alpha(n), 
     acc_alpha(n), 
          beta(n), 
      vit_beta(n), 
      acc_beta(n), 
         gamma(n), 
     vit_gamma(n), 
     acc_gamma(n)];

    % Data vector
    A = [A; phi(X)];

    % Output vector
    Y = [Y; 1 ; 0 ; 0];
end 

size(A)
cond(A)

%% Solving
p_find = A \ Y;

k0_find = p_find(1);
k1_find = p_find(2);
k2_find = p_find(3);

b0_find = p_find(4);
b1_find = p_find(5);
b2_find = p_find(6);

m1_find = p_find(7);
m2_find = p_find(8);
m3_find = p_find(9);