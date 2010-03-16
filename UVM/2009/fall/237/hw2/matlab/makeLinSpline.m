function f = makeLinSpline(X,Y)

n = length(X);
m = [];
b = [];

for i=1:n-1
    m = [m;(Y(i+1) - Y(i))/(X(i+1) - X(i))];
    b = [b;Y(i) - m(i)*X(i)];
    f{i}.function = @(x) m(i)*x + b(i);
    f{i}.range = [X(i), X(i+1)];
end

end