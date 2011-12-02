function [g maxError] = solution
    n = 128;
    n = 2^4;
    x = linspace(0,2*pi, n+1);
    x = x(1:n);
    fp = 50*cos(50*x);
    F = fft(sin(50*x));
    k = [0:(n/2-1) (-n/2):-1];
    g = ifft(1i*k.*F);
    error = abs(fp-g);
    maxError = max(error);
end