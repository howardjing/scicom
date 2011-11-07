function [newton newtonCounter broyden broydenCounter nResults bResults] = hw3_q3()

    % Fix sigma = 1, rho = 2, beta = 1
    sigma = 1;
    rho = 2;
    beta = 1;
   
    
    % Find fixed points
    p = sqrt(beta*(rho-1));
    fixedPoint1 = [0 0 0];
    fixedPoint2 = [p p rho-1];
    fixedPoint3 = [-p -p rho-1];
    
    % Starting points
    initial = (-1.5:0.1:1.5)';
    initialPoints = [initial initial zeros(length(initial),1)];
    
    newton = [];
    newtonCounter = [];
    
    % Newton's method
    for i=1:length(initial)
         [a b c] = Newton(sigma, rho, beta, initialPoints(i,:));
         newton = [newton; a];
         newtonCounter = [newtonCounter; b];
    end
    
    broyden = [];
    broydenCounter = [];
    
    % Broyden's method
    for i=1:length(initial)
         [a b] = Broyden(sigma, rho, beta, initialPoints(i,:));
         broyden = [broyden; a];
         broydenCounter = [broydenCounter; b];
    end
    
    % Compare Newton and Broyden for the last starting point calculated
    [a b c] = Newton(sigma, rho, beta, initialPoints(length(initial),:));
    nResults = analyzeError(a, c);
    [a b c] = Broyden(sigma, rho, beta, initialPoints(length(initial),:));
    bResults = analyzeError(a, c);
end

function [answer] = analyzeError(solution, steps)
    answer = [];
    
    for i=1:length(steps)
        residual = abs(solution - steps(i,:));
        answer = [answer; residual];
    end
end

% Multi-dimensional Newton's method
function [answer counter results] = Newton(sigma, rho, beta, initialGuess)

    xk = initialGuess;
    fxk = F(sigma, rho, beta, xk);
    fxk = fxk'*fxk; % use dot product to test if fxk is the zero vector
    
    results = xk; % store every intermediate step
    
    % iterate until the solution is found
    counter = 0;
    while fxk ~= 0
        
        xk = NewtonStep(sigma, rho, beta, xk);
        fxk = F(sigma, rho, beta, xk);
        fxk = fxk'*fxk;
        
        if counter > 50
            break
        end
        
        counter = counter+1;
        
        results = [results; xk];
        
    end
    answer = xk;

end

function [answer] = NewtonStep(sigma, rho, beta, xk)

    f = F(sigma, rho, beta, xk);
    jacobian = JacobianF(sigma, rho, beta, xk);

    answer = (jacobian\(-f+(jacobian*xk')))';
    
end

% Broyden's method
function [answer counter results] = Broyden(sigma, rho, beta, initialGuess)
    AkInverse = JacobianF(sigma, rho, beta, initialGuess);
    xk = initialGuess;
    fxk = F(sigma, rho, beta, xk);
    fxk = fxk'*fxk;
    
    results = xk; % store every intermediate step
    
    counter = 0;
    while fxk ~=0
        
        [xk AkInverse] = BroydenStep(sigma, rho, beta, xk, AkInverse);
        fxk = F(sigma, rho, beta, xk);
        fxk = fxk'*fxk;
        
        if counter > 100
            break
        end
        
        counter = counter+1;
        
        results = [results; xk];
    end
    answer = xk;
    

end

% Use Sherman-Morrison's formula to calculate the next step
function [nextStep nextMatrix] = BroydenStep(sigma, rho, beta, xk, AkInverse)
    sk = -AkInverse*F(sigma, rho, beta, xk);
    xk = xk';
    
    xknext = xk + sk;
    yk = F(sigma, rho, beta, xknext) - F(sigma, rho, beta, xk);
    nextMatrix = AkInverse + ((sk-AkInverse*yk)/(sk'*AkInverse*yk))*sk'*AkInverse;
    nextStep = xknext';
end

% Lorenz equations
function [answer] = F(sigma, rho, beta, xk)
    x = xk(1);
    y = xk(2);
    z = xk(3);
    answer = [sigma*(y-x) rho*x-y-x*z -beta*z+x*y]';
end

% Jacobian of Lorenz equations
function [answer] = JacobianF(sigma, rho, beta, xk)
    x = xk(1);
    y = xk(2);
    z = xk(3);
    answer = [-sigma sigma 0; rho-z -1 -x; y x -beta];
end