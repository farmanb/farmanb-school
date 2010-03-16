function [N,C] = part4(A, image_1_vec, image_2_vec)
Q = @(A,mu) A + mu*speye(266);

N = [];
C = [];
for i=-9:-1
    N = [N; norm((Q(A,10^i) \ image_2_vec) - (A \ image_1_vec))];
    C = [C;condest(Q(A,10^i))];
end 

end