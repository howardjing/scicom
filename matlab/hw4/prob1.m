function [appxderiv deriv] = prob1
 
    xj = setUpGrid();
    [leny lenx] = size(xj);
        
    fxj = zeros(size(xj));
    derivativexj = zeros(size(xj));
    appx_deriv_xj = zeros(size(xj));
    
    % f(x)
    sin50 = @(x) sin(50*x);
    % f'(x)
    derivative = @(x) 50*cos(50*x);
    % multiplier is 2*pi*i/period
    multiplier = 50*1i;
    for i = 1:leny
        for k = 1:lenx
            fxj(i,k) = sin50(xj(i,k));
            if k <= 2^(3+k) 
                derivativexj(i,k) = derivative(xj(i,k));
            end
        end
        appx_deriv_xj(i,:) = approx(fxj(i,:),multiplier);
    end
    error = abs(appx_deriv_xj - derivativexj);
    max_error = zeros(1,leny);
    for i = 1:leny
        max_error(i) = max(error(i,:));
    end
    
    appxderiv = appx_deriv_xj(1,:);
    deriv = derivativexj(1,:);
end

% find an approximation for the derivative of a function using fft
function [approximation] = approx(fx, multiplier)
    transform = fft(fx);
    alpha = 1:length(fx);
    transformed_deriv = multiplier.*alpha.*transform;
    approximation = ifft(transformed_deriv);
end

% returns the properly set up uniform grid
function [xj] = setUpGrid
    % setup the problem
    temp = 4:10;
    N = 2.^temp;
    j = zeros(7,N(length(N)));
    for i = 1:length(N)
        for k = 1:N(i)
            j(i,k) = k-1;
        end
    end

    h = zeros(1,length(N));
    h = 2*pi./N;

    xj = zeros(size(j));
    for i = 1:length(N)
        for k = 1:length(j)
            xj(i,k) = j(i,k)*h(i);
        end
    end
end