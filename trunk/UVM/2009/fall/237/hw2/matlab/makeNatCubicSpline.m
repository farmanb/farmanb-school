function f = makeNatCubicSpline(X,Y)

a=[];
b=[];
c=[];
d=[];
delta = [];
Delta = [];

n = length(X);

for i=1:n-1
    a = [a;Y(i)];
    delta = [delta; X(i+1) - X(i)];
    Delta = [Delta; Y(i+1) - Y(i)];
end

A = zeros(n);
A(1,1) = 1;
A(n, n) = 1;

res = zeros(n, 1);

for i=2:n-1
    A(i,i) = 2*(delta(i-1) + delta(i));
    A(i,i-1) = delta(i-1);
    A(i,i+1) = delta(i);
    res(i) = 3*((Delta(i)/delta(i)) - (Delta(i-1)/delta(i-1)));
end

c = A\res;

for i=1:n-1
    d = [d;(c(i+1) - c(i))/(3*delta(i))];
    b = [b;Delta(i)/delta(i) - (delta(i)/3)*(2*c(i) + c(i+1))];
end

for i=1:n-1
    f{i}.function = @(x) a(i) + b(i)*(x-X(i)) + c(i)*(x-X(i))^2 + d(i)*(x-X(i))^3;
    f{i}.range = [X(i), X(i+1)];
end

end