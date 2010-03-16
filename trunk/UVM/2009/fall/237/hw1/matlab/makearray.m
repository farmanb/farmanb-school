%function [x, N, exp2x, A_N, err_abs, err_rel]  = makearray()
function [retVal] = makearray(from, by, to, f)
%MAKEARRAY Make an array with error information.
%   Generates an array with the x values, when successive terms in the 
%   Taylor series are equivalent, 'real' function values, the value of the 
%   Nth term in the Taylor series when the Nth = the N+1st, absolute error 
%   and relative error for the provided function.  X values are those
%   between 'from' and 'to' divisible by 'by.'
format short e

A_N = [];
N = [];
err_abs = [];
err_rel = [];

%Generate the x's and exp2x
[x, fval] = rangedFcn(from, by, to, f);

%Inline functions to calculate the abs and rel err

%Absolute Error:
%(lambda (x) (abs (- actual approx)))
absHandle = @(actual, approx) abs(actual - approx);

%Relative Error:
%(lambda (x) (/ (abs (- actual approx)) (abs approx))))
relHandle = @(actual, approx) abs(actual - approx) / abs(actual);

%For each x in X calculate A_N(x) and N, then
%calculate the rel and abs errors.
for i = 1:length(x)
    
    [temp1, temp2] = mytaylor(x(i));
    A_N = [A_N; temp1];
    N = [N; temp2];
    err_abs = [err_abs; absHandle(fval(i), temp1)];
    err_rel = [err_rel; relHandle(fval(i), temp1)];
    
end

retVal = [x, N, fval, A_N, err_abs, err_rel];

end