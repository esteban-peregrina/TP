function y = model_example_1(x)
p = [.5;.5]; % hidden from us!
A = [x(1) -x(2); -x(1) x(3)*x(4)];
y = A*p;
end

