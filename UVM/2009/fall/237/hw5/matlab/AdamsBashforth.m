%Args:
%f - y' = f(t,y)
%t \\in [t0,tFinal]
%h - step size
%exact - exact solution
function [y,e] = AdamsBashforth(f,t0,tFinal,h,y0,exact)

%Calculate time
for i=0:1/h
    t(i+1) = t0 + i*h;
end

t = t';

%Initial condition
y(1) = y0;
e(1) = abs(exact(t(1)) - y(1));

%Trapezoid step
y(2) = y(1) + h/2*(f(t(1),y(1)) + f(t(1)+h, y(1) + h*f(t(1),y(1))));

%Calc the error for y_1
e(2) = abs(exact(t(2)) - y(2));

%Calculate y_{i+1} and associated error
for i=2:1/h
    y(i+1) = y(i) + h*(3/2*f(t(i),y(i)) - 1/2*f(t(i-1), y(i-1)));
    e(i+1) = abs(exact(t(i+1)) - y(i+1));
end

y = y';
e = e';
end