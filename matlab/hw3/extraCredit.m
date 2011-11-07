function [varyBeta counterB determinantB errorB1 errorB2 varyRho counterR determinantR errorR1 errorR2] = extraCredit()

    % Fix sigma = 1, rho = 2, beta = 1
    sigma = 1;
    rho = 2:-0.1:1;
    beta = 1:-0.1:0;
    
    varyBeta = [1 1 1];
    counterB = [0];
    
    fixedB = [];
    % get the actual answer
    for i=1:length(beta)
        fixedB = [fixedB; findFixedPoint(rho(1), beta(i))];
    end
    
    fixedR = [];
    for i=1:length(rho)
        fixedR = [fixedR; findFixedPoint(rho(i), beta(1))];
    end
    fixedB
    fixedR
    
    % We know that initially there is a solution at (1,1,1)
    for i=2:length(beta)
        
        [a b] = Newton(sigma, rho(1), beta(i), varyBeta(i-1,:));
        varyBeta = [varyBeta; a];
        counterB = [counterB; b];

    end
    
    determinantB = [];
    % calculate the determinant of the jacobian
    for i=1:length(varyBeta)
        temp = det(JacobianF(sigma, rho(1), beta(i), varyBeta(i,:)));
        determinantB = [determinantB; temp];
    end
    
    % compare residuals of beta=0.9 and beta=0
    [a b c] = Newton(sigma, rho(1), beta(2), varyBeta(1,:));
    errorB1 = analyzeError(findFixedPoint(2,0.9), c);
    temp = length(varyBeta)-1;
    [a b c] = Newton(sigma, rho(1), 0, varyBeta(temp,:));
    errorB2 = analyzeError(findFixedPoint(rho(1),0),c);
    
    % Repeat same study but on rho
    varyRho = [1 1 1];
    counterR = [0];
    for i=2:length(rho)
        
        [a b] = Newton(sigma, rho(i), beta(1), varyRho(i-1,:));
        varyRho = [varyRho; a];
        counterR = [counterR; b];
        
    end
    
    determinantR = [];
    for i=1:length(varyRho)
        temp = det(JacobianF(sigma, rho(i), beta(1), varyRho(i,:)));
        determinantR = [determinantR; temp];
    end
    
    [a b c] = Newton(sigma, rho(2), beta(1), varyRho(1,:));
    errorR1 = analyzeError(findFixedPoint(rho(2), beta(1)), c);
    [a b c] = Newton(sigma, rho(length(rho)), beta(1), varyRho(length(rho)-1,:));
    errorR2 = analyzeError(findFixedPoint(rho(length(rho)), (beta(1))), c);
end

function[answer] = findFixedPoint(rho, beta)
    answer = [sqrt(beta*(rho-1)) sqrt(beta*(rho-1)) rho-1];
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
        
        if counter > 100
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