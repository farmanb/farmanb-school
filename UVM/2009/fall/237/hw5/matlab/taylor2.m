%Args:
%f - y' = f(t,y)
%ft - f_t(t,y)
%fy - f_y(t,y)
%t \\in [t0,tFinal]
%h - step size
%exact - exact solution
function [y,e] = taylor2(f,t0,tFinal,h,y0,ft,fy,exact)

%Calculate time
for i=0:1/h
    t(i+1) = t0 + i*h;
end

%IC and associated error
y(1) = y0;
e(1) = abs(y(1) - exact(t(i)));

%Calculate y_{i+1} and associated error
for i=1 : 1/h
   y(i+1) = y(i) + h*f(t(i),y(i)) + 1/2*h^2*(ft(t(i),y(i)) + fy(t(i),y(i))*f(t(i),y(i)));
   e(i+1) = abs(y(i+1) - exact(t(i+1)));
end

y = y';
e = e';
end