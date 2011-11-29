function [answer] = hw3_q1()

    len = 5;

    % Newton's method with x0 = 0.5
    newton1 = zeros(1,len);
    newton1(1) = 0.5;
    for i=2:length(newton1)
        newton1(i) = step(newton1(i-1));
    end
    
    plot(1:length(newton1), newton1)
    title('Newtons Method Iterations with x0=0.5')
    xlabel ('Number of Iterations')
    ylabel ('x_(k+1)')
    
    % Newton's method with x0 = 1.5
    newton2 = zeros(1,len);
    newton2(1) = 1.5;
    for i=2:length(newton2)
        newton2(i) = step(newton2(i-1));
    end
    
    figure
    plot(1:length(newton2), newton2)
    title('Newtons Method Iterations with x0=1.5')
    xlabel ('Number of Iterations')
    ylabel ('x_(k+1)')
    answer = newton2;
end

% our chosen function
function [answer] = f(x)
    answer = x / sqrt(1+x^2);
end

% the derivative of our chosen function
function [answer] = fPrime(x)
    answer = 1 / (1+x^2)^(3/2);
end

% one iteration of Newton's method
function [answer] = step(x)
    answer = x - f(x)/fPrime(x);
end