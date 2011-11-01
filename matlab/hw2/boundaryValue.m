function [normError errors appxU U A] = boundaryValue(step)
    % takes step size as input (ie 0.01), outputs the norm of the error
    % set up our parameters

    n = 1/step;

    % set up our x and f(x)
    x = zeros(1,n-1);
    fx = zeros(1, n-1);
    U = zeros(1, n-1);

    x = [step:step:1 - step];
    fx = sin(pi*x);
    U = -sin(pi*x)/(pi^2);

    % We will use u(x) = -x^2 + x
    % Then f(x) = -1;
    %fx = -1*ones(1, n-1);
    %U = -x.^2 + x;

    % create the tridiagonal matrix A
    mainDiag = zeros(1, n-1);
    subDiag = zeros(1, n-2);
    A = zeros(n-1,n-1);

    mainDiag = -2*ones(1,(n-1));
    subDiag = ones(1,(n-2));

    A = diag(mainDiag, 0);
    A = A + diag(subDiag, 1);
    A = A + diag(subDiag, -1);
    A = 0.5 * (1/(step^2)) * A;

    %cond(A)
    % AU = fx, so solve for U
    appxU = zeros(n-1,1);
    appxU = A\fx';

    errors = abs(U' - appxU);
    errors = errors';
    
    normerr = 0;
    for i=1:(n-1)
        normerr = errors(i)^2 + normerr;
    end
    normerr = sqrt(normerr);
    %normError = norm(errors, 2)/(n-1);
    normError = normerr/(n-1);
    
end




