clear
P = @(v) v*v'/(v'*v);

A = [2 4; 0 -1; 2 -1; 1 3];
b = [-1 3 2 1]';
[m,n] = size(A);

x = A(:,1);

%Get the opposite sign of the first component of X.
sign = -1 * x(1) / norm(x(1));

w = zeros(size(x));
w(1) = sign*norm(x);

v = w - x;

H1 = eye(size(P(v))) - 2*P(v);

temp = H1*A;

x = temp(2:m,2);

w = zeros(size(x));
w(1) = norm(x);

v = w - x;
temp = eye(size(P(v))) - 2*P(v);
H2 = [1 0 0 0; 
    0 temp(1,1:3);
    0 temp(2,1:3);
    0 temp(3,1:3);];

R = H2*H1*A
Q = H1*H2

d = Q'*b;

x = R\d

error = norm(b-A*x)