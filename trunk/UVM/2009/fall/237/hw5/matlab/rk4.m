%Args:
%f - y' = f(t,y)
%t \\in [t0,tFinal]
%h - step size
%exact - exact solution
function [y,e] = rk4(f,t0,tFinal,h,y0,exact)

%Calculate time
for i=0:1/h
    t(i+1) = t0 + i*h;
end

%ICs & Associated error
y(1) = y0;
e(1) = abs(y(1) - exact(t(1)));

for i=1 : 1/h
    %t = t0 + i*h;
    
    s(1) = f(t(i),y(i));
    s(2) = f(t(i) + h/2, y(i) + h/2*s(1));
    s(3) = f(t(i) + h/2, y(i) + h/2*s(2));
    s(4) = f(t(i) + h, y(i) + h*s(3));
    
    y(i+1) = y(i) + h/6*(s(1) + 2*s(2) + 2*s(3) *s(4));
    e(i+1) = abs(y(i+1) - exact(t(i+1)));
end

y = y';
e = e';

end