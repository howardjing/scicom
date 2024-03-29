function [] = lorenzTester

    h = 0.01;
    initialPoints1 = [0.1 -0.1 0.0];
    initialPoints2 = [0.10001 -0.10002 0.0];
    
    lorenz1 = lorenzSolver(initialPoints1, h);
    lorenz2 = lorenzSolver(initialPoints2, h);
    
    %plotAll(lorenz1);
    %hold on
    %plotAll(lorenz2);
    
    plot(lorenz1(:,1), lorenz1(:,2), 'r');
    hold on
    plot(lorenz2(:,1), lorenz2(:,2));
    hold off
    
    % plot the difference
    figure
    plot(0:h:100, findDifference(lorenz1, lorenz2))
    
end

% finds the difference between the two slightly perturbed initial values
function [difference] = findDifference(lorenz1, lorenz2)
    difference = (lorenz1 - lorenz2);
end

% solves the lorenz equations based on initial points, and timestep
function [ft] = lorenzSolver(initialPoints, h)
    t = 0:h:100;
    
    ft = zeros(length(t),3);
    
    ft(1,:) = initialPoints;
    
    for i = 2:length(t)
        ft(i,:) = rk4Step(ft(i-1,:),h);
    end
end

% plots the lorenz points
function [] = plotAll(ft)

    % plot lorenz1
    %X Y plot
    subplot(2,2,1)
    plot(ft(:,1), ft(:,2), 'r') 

    %X Z plot
    subplot(2,2,2)
    plot(ft(:,1), ft(:,3), 'r') 

    %Z Y plot
    subplot(2,2,3)
    plot(ft(:,3), ft(:,2), 'r') 

    % X Y Z plot.
    subplot(2,2,4)
    plot3(ft(:,1), ft(:,2), ft(:,3),'r') 
    
end

% one step of runge-kutta 4
function [answer] = rk4Step(x,h)
    % y_n+1 = y_n + 1/6 (e_1 + 2e_2 + 2e_3 + e_4);
    
    xi_1 = h*lorenzEquations(x);
    xi_2 = h*lorenzEquations(x+xi_1/2);
    xi_3 = h*lorenzEquations(x+xi_2/2);
    xi_4 = h*lorenzEquations(x+xi_3);
    
    answer = x + (xi_1 + 2*xi_2 + 2*xi_3 + xi_4)/6;
end

% takes (x1, x2, x3) as parameters
% outputs the derivative
function [deriv] = lorenzEquations(x)

    % Lorenz Equations
    sigma = 10;
    beta = 8/3;
    rho = 28;
    
    xPrime = -sigma*x(1) + sigma*x(2);
    yPrime = rho*x(1) - x(2) - x(1)*x(3);
    zPrime = x(1)*x(2)-beta*x(3);
    deriv = [xPrime yPrime zPrime];    
end