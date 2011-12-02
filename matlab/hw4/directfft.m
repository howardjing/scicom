function [transform] = directDFT(x)
    % direct implementation of the discrete fourier transform
    % runs in O(n^2) time
    % input: a vector x
    % output: the fourier coefficients
    
    n = length(x);
    omega = exp(2*pi*1i/n);
    alpha = 0:(n-1);
    transform = zeros(1,n);
    
    transform(1) = x(1);
    for j = 1:n
        for k = 1:j
            transform(j) = omega^(-alpha(j)*k)*x(k);
        end
        transform(j) = (1/n).*transform(j);
    end
    
end