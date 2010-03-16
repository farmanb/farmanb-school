fig = figure;

fgen = @(a,b) @(x) ((b+1)*x - 1)/(a*x^2);
ggen = @(a,b) @(x) b/(a*x);

for i=1:4
    subplot(2,2,i);
    hold on
    fplot(fgen(i,i+1),[0,10]);
    fplot(ggen(i,i+1),[0,10]);
    hold off
end