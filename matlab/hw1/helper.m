function [answer] = helper()
    x = (0:.001:1);
    centeredDifferenceError = zeros(length(x));
    forwardDifferenceError = zeros(length(x));
    for i=1:length(centeredDifferenceError)
        centeredDifferenceError(i) = f(x(i));
        forwardDifferenceError(i) = g(x(i));
    end
    
    % semilogy(x, centeredDifferenceError, 'r-');
    plot(x, centeredDifferenceError, 'r-');
    hold on
    % semilogy(x, forwardDifferenceError, 'g--');
    plot(x, forwardDifferenceError, 'g--');
    hold end
    answer = 0;
    return;
end

function [answer] = f(x) % error of centered difference 
    % answer = x*(x/2)^(-1/3) + (x/2)^(2/3);
    answer = ( .1/x ) + x^2;
    return;
end

function [answer] = g(x) % error of single difference
    % answer = 2*sqrt(x);
    answer = ( .1/x) + x;
    return;
end