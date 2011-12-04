function [ft] = lorenzTester
    h = 0.01;
    initialPoints = [0.1 -0.1 0.0];
    t = 1:0.1:100;
    
    ft = zeros(length(t),3);
    
    ft(1,:) = initialPoints;
    
    for i = 2:length(t)
        ft(i,:) = rk4Step(ft(i-1,:),h);
    end
end

function [answer] = rk4Step(x,h)
    % y_n+1 = y_n + 1/6 (e_1 + 2e_2 + 2e_3 + e_4);
    
    xi_1 = xi(x,h);
    xi_2 = xi(x+0.5*xi_1, 0.5*h);
    xi_3 = xi(x+0.5*xi_2, 0.5*h);
    xi_4 = xi(x+xi_3, h);
    
    answer = x + (1/6)*(xi_1 + 2*xi_2 + 2*xi_3 + xi_4);
end

function [answer] = xi(x,h)
    answer = h*lorenzEquations(x);
end

% takes (x1, x2, x3) and t and parameters
% outputs the derivative
function [xPrime yPrime zPrime] = lorenzEquations(x)

    % Lorenz Equations
    sigma = 10;
    beta = 8/3;
    rho = 28;

    xPrime = (sigma*(x(2) - x(1)));
    yPrime = (rho*x(1) - x(2) - x(1)*x(3));
    zPrime = (-beta*x(3) + x(1)*x(2));
    
end