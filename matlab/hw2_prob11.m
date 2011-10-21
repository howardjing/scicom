function hw2_prob11
    steps = [0.0001:0.01:0.1];
    errors = zeros(1, length(steps));
    errors = arrayfun(@boundaryValue, steps);
    checkErrors = steps;
    checkErrors2 = (steps).^2;
    %expSteps2 = exp(2*steps);
    %expcheckError = exp(errors);
    %loglog(steps, errors);
    %hold on
    %loglog(steps, checkErrors, 'r');
    %loglog(steps, checkErrors2, 'g');
    %hold off
    figure
    plot(steps,errors)
end
