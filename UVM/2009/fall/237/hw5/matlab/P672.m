%a
[y,Error] = AdamsBashforth(@(t,y) t+y,0,1,1/4,0,@(t) exp(t) - t - 1)
%b
[y,Error] = AdamsBashforth(@(t,y) t-y,0,1,1/4,0,@(t) exp(-t) + t -1)
%c
[y,Error] = AdamsBashforth(@(t,y) 4*t-2*y,0,1,1/4,0,@(t) exp(-2*t) +2*t - 1)