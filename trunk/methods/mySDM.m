function [X] = mySDM(A, b, x0)
    r = b - A*x0;
    alpha = (r'*r)/(r'*A*r);
    X = alpha*r + x0;
    
    while (1)
        r = b - A*X;
        if r == 0
            break;
        end
        alpha = (r'*r)/(r'*A*r);
        X = alpha*r + X;
    end
end