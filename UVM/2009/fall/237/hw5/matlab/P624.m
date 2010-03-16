%t0 < t < tFinal
t0 = 0;
tFinal = 1;

%y(0) = 1
y0 = 1;

%h
h = 1/4;

%y' = t
f = @(t,y) t;
%f_t(t,y)
ft = @(t,y) 1;
%f_y(t,y)
fy = @(t,y) 0;
%exact
y = @(t) 1 + t^2/2;
[Y,Error] = taylor2(f,t0,tFinal,h,y0,ft,fy,y)

%y' = t^2y
f = @(t,y) t^2*y;
%f_t(t,y)
ft = @(t,y) 2*t*y;
%f_y(t,y)
fy = @(t,y) t^2;
%exact
y = @(t) exp(t^3/3);
[Y,Error] = taylor2(f,t0,tFinal,h,y0,ft,fy,y)

%y' = 2(t+1)y
f = @(t,y) 2*(t+1)*y;
%f_t(t,y)
ft = @(t,y) 2*y;
%f_y(t,y)
fy = @(t,y) 2*(t+1);
%exact
y = @(t) exp(t^2 + 2*t);
[Y,Error] = taylor2(f,t0,tFinal,h,y0,ft,fy,y)

%y' = 5t^4y
f = @(t,y) 5*t^4*y;
%f_t(t,y)
ft = @(t,y) 20*t^3*y;
%f_y(t,y)
fy = @(t,y) 5*t^4;
%exact
y = @(t) exp(t^5);
[Y,Error] = taylor2(f,t0,tFinal,h,y0,ft,fy,y)

%y' = 1/y^2
f = @(t,y) 1/(y^2);
%f_t(t,y)
ft = @(t,y) 0;
%f_y(t,y)
fy = @(t,y) -2/y^3;
%exact
y = @(t) (3*t +1)^(1/3);
[Y,Error] = taylor2(f,t0,tFinal,h,y0,ft,fy,y)

%y' = t^3/y^2
f = @(t,y) t^3/(y^2);
%f_t(t,y)
ft = @(t,y) 3*t^2/y^2;
%f_y(t,y)
fy = @(t,y) 2*t^3/y^3;
%exact
y = @(t) ((3*(t^(4))/4) + 1)^(1/3);
[Y,Error] = taylor2(f,t0,tFinal,h,y0,ft,fy,y)
