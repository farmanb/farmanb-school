function f = makePolynomial(X, Y)


%Calculate the coeffs
%F[x_1, x_2, ..., x_i] = M[i,i]
%i.e. the coefficients are along the diagonal
%in the memoized array.
M = calcNewtonCoeffs(X,Y);

%Make the handles for the polynomial terms
polyTerms = makePolyTerms(X);

%Make and return the handle for the actual polynomial...
%Base case
f = @(x)polyTerms{1}(x) * M(1,1);

%Calculate the rest of the polynomial.
for i=2:length(X)
    f = @(x) f(x) + M(i,i)*polyTerms{i}(x);
end

end