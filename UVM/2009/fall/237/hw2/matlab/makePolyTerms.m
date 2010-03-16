function terms = makePolyTerms(X)

%Calculate the polynomial terms
%(x-x_k)(x-x_k+1)...(x-x_i)

%Base case: x^0
terms = cell(1,length(X));
terms{1} = @(x)1;

for i=2:length(X)
    %Define the polynomial terms recursively...
    terms{i} = @(x) terms{i-1}(x) * (x-X(i-1));
end

end
