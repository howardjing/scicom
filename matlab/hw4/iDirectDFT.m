function [original] = iDirectDFT(transform)
    n = length(transform);
    h = 2*pi/n;
    w = exp(1i*h);
    omega = @(alpha, j) w^(alpha*j);

    original = zeros(1,n);
    for j = 0:(n-1)
        for alpha = 0:(n-1)
            original(j+1) = original(j+1) + transform(alpha+1)*omega(alpha,j);
        end
    end
end