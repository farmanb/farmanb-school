function yprime = F(t,y);


%f = @(x,y,a,b) 1 - (b+1)*x + a*x^2*y
%g = @(x,y,a,b) b*x - a*x^2*y

a=-3; b=-3; c=0; d=1/2; 
yprime(1) = a*y(1)+b*y(2);
yprime(2) = c*y(1)+d*y(2);
yprime = yprime';
