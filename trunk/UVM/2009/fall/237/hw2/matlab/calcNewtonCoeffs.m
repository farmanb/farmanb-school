function M = calcNewtonCoeffs(X, Y)


%Init M
M = zeros(length(X));

%Base Case:
%M(i,i) = Y(i)
for i=1:length(X)
    %Fill in the left vertical...
    M(i,1) = Y(i);
end

for i=2:length(X)
    for j=i:length(X)
        %Recurrence
        %M(ROW, COL)
        M(j,i) = (M(j,i-1) - M(j-1,i-1)) / (X(j) - X(j-(i-1)));
    end
end

end