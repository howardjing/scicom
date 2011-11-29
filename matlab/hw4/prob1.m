function [max_error] = prob1
 
    xj = setUpGrid();
    [rowMax colMax] = size(xj);
        
    fxj = zeros(size(xj));
    derivative_xj = zeros(size(xj));
    appx_deriv_xj = zeros(size(xj));
    
    % f(x)
    sin50 = @(x) sin(50.*x);
    % f'(x)
    derivative = @(x) 50*cos(50.*x);
    % period of f(x)
    period = 2*pi/50;

    % do the various calculations
    for i = 1:rowMax
        len = 2^(i+3);
        fxj(i,1:len) = sin50(xj(i,1:len));
        derivative_xj(i,1:len) = derivative(xj(i,1:len));
        appx_deriv_xj(i,1:len) = approx(fxj(i,1:len), period);
    end
    
    % find errors
    error = abs(appx_deriv_xj - derivative_xj);
    max_error = zeros(1,rowMax);
    
    for i = 1:rowMax
        len = 2^(i+3);
        max_error(i) = max(error(i,1:len));
    end
    
    appxderiv = appx_deriv_xj(1,1:16);
    deriv = derivative_xj(1,1:16);
end

% find an approximation for the derivative of a function using fft
function [approximation] = approx(fx, period)
    multiplier = 2*pi*1i/period;
    transform = fft(fx);
    alpha = 0:(length(fx)-1);
    transformed_deriv = multiplier.*alpha.*transform;
    approximation = ifft(transformed_deriv);
end

% returns the properly set up uniform grid
function [xj] = setUpGrid
    % sets up the problem
    temp = 4:10;
    N = 2.^temp;
    j = zeros(7,N(length(N)));
    for i = 1:length(N)
        j(i,1:N(i)) = 0:N(i)-1;
    end

    h = zeros(1,length(N));
    h = 2*pi./N;

    xj = zeros(size(j));
    for i = 1:length(N)
        xj(i,1:N(i)) = j(i,1:N(i))*h(i);
    end
end