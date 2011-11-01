function hw2_prob11
    n = [10:900:10000];
    steps = 1./n;
    errors = zeros(1, length(steps));
    errors = arrayfun(@boundaryValue2, n);

    slopecheck = (steps).^2;
    
    figure
    loglog(steps, errors);
    title('Convergence Study of Second Order Method')
    xlabel('\Delta x')
    ylabel('Error(\Delta x)')
    hold on
    loglog(steps, slopecheck, 'r');
    legend('Error','Slope check with m = 2')
    hold off
end
