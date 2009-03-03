function [X] = myCGM(A,b,x0)
    r = b - A*x0;
    d = r;
    q = A*d;
    alpha = (r'*r)/(d'*q);
    X = x0 + alpha*d;
    
    while (1)
        temp = r - alpha*q;
        if (abs(r - temp) < eps)
            break;
        end
        beta = (temp' * temp)/(r' * r);
        r = temp;
        d = r + beta*d;
        q = A * d;
        alpha = (r' * r)/(d' * q);
        X = X + alpha*d;
    end
end