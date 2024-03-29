%Args:
%f - y' = f(t,y)
%t \\in [t0,tFinal]
%h - step size
%exact - exact solution
function [y,e] = forwardEuler(f,t0,tFinal,h,y0,exact)

%Calculate time
for i=0:1/h
    t(i+1) = t0 + i*h;
end

%Init vars
y(1) = y0;
e(1) = abs(exact(t(1) - y(1)));

%Calculate y_{i+1} and associated error
for i = 1 : 1/h
    y(i+1) = y(i) + h*f(t0 + i*h,y(i));
    e(i+1) = abs(exact(t(i+1)) - y(i+1));
end

%Return as col vec instead of row vec
y = y';
e = e';
end