function [k,readable] = part2(A,b,omega,x)

k = 0;
readable = 0;
n = length(b);
%intial guess
xprev = x';


while (1)
    for i=1:n
   
        sigma = 0;
    
        for j = 1:i-1
            sigma = sigma + A(i,j)*xprev(j);
        end
    
        for j = i+1:n
            sigma = sigma + A(i,j)*xprev(j);
        end
    
        x(i) = (1-omega)*xprev(i) + (omega/A(i,i))*(b(i) - sigma);
    
    end
    
    if (mod(k,100) == 0 && ~readable)
        imagesc(reshape(x,7,38));
        axis image; 
        readable = input('Readable? (0/1)');
        if (readable)
            readable = k;
        end
    end
    
    k = k+1;
    
    if norm(A*x - b) < 0.5*10^(-2)
        return;
    end
    
    xprev = x;

end

end