function [transform] = directDFT(fx)
    % direct implementation of the discrete fourier transform
    n = length(fx);
    h = 2*pi/n;
    w = exp(1i*h);
    omega = @(alpha, j) w^(-alpha*j);
    
    transform = zeros(1,n);
    for alpha = 0:(n-1)
        for j = 0:(n-1)
            transform(alpha+1) = transform(alpha+1) + (fx(j+1)*omega(alpha,j));
        end
        transform(alpha+1) = transform(alpha+1)/n;
    end 
end