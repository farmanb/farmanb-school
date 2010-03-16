function [x,e] = P432(A,b)

%Get the dimensions of A
[m,n] = size(A);

%QR Factorization
[Q,R] = qr(A);

%Set up Rx = d
d = Q'*b;

%Solve
x = R(1:n,1:n)\d(1:n);

%Calculate the error
e = norm(b - A*x);

end