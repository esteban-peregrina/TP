function J = jacobien(theta, p)
n = length(p);% 10

J = zeros(3, n);

h = 10^-6; %pas de differentiation

for j =1:n 
    %calcul de la deriver numérique f' = f(x-h)-f(x+h)/2h
    p_plus = p;
    p_moins = p;

    p_plus(j) = p_plus(j) + h;
    p_moins(j) = p_moins(j) - h;

    X_plus = modele_geom(theta, p_plus);
    X_moins = modele_geom(theta, p_moins);

    %derivée
    J(:,j) = (X_plus - X_moins)/(2*h);
end


end