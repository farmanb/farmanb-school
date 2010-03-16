function [x, fval] = rangedFcn(from, by, to, f)
%RANGEDFCN Calls a function on a specified range.
%   Calls f starting at 'from' up until 'to' iff
%   the number is an integer multiple of 'by'

%Initialize x, i and fval
x = [];
i = from;

fval = [];

while i <= to
    
    %Check to see if i is divisible by 'by'
    if mod(i, by) == 0
        %Push the fvals and x values into their respective arrays
        fval = [fval; f(i)];
        x = [x;i];
    end
    
    %i++
    i = i+1;

end

end