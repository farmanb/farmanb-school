function [ A_N, N ] = mytaylor( x )
%MYTAYLOR Calculates error for Taylor Series
%   Returns the first N such that A_N = A_N+1 where
%   A_N = sum(i=1 to N) [(2*x)^i / i!]

%Initialize N, A, A_N
N = 0;
A = [1, 2 * x, 1 + 2 * x]; %[A_N, nth term, A_N+1]
A_N = A(1);

while A(1) ~= A(3)
    %N++
    N = N + 1;
    
    %Calculate A
    A(1) = A(3); %A_N(x)
    A(2) = A(2) * (2 * x) / (N + 1); %Calculate the N+1st term
    A(3) = A(1) + A(2); %Calculate A_N+1(x)
    
    A_N = A(1);
end

end

