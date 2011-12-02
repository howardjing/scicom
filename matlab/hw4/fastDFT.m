function [transform] = fastDFT(x)
    n = length(x);
    transform = zeros(1,n);
    % base case
    if n == 1
        transform(1) = x(1);
        return
    end
    
    % split into even and odd
    even = x(1:2:n);
    odd = x(2:2:n);
    
    % recursively solve both halves
    even = fastDFT(even);
    odd = fastDFT(odd);
    
    % combine the two solutions
    h = 2*pi/n;
    w = exp(1i*h);
    omega = @(alpha) w^(alpha);

    for k =  1:n/2
        transform(k) = (even(k) + omega(k)*odd(k));
        transform(k + (n/2)) = (even(k) - omega(k)*odd(k));
    end
    return
end