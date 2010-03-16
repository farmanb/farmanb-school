function myPlot(vars1, vars2)

figure;

for i=1:4
    subplot(2,2,i);
    plot(vars1(:,i));
    hold on;
    plot(vars2(:,i), '--');
end

end