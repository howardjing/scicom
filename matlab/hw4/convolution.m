function [fast slow actual] = convolution

    N = 256;
    fast = trapEstimate(@fft, @ifft, N);
    slow = trapEstimate(@iDirectDFT, @directDFT, N);
    actual = directComputation(N);
end

function [hValues] = trapEstimate(myFFT,iMyFFT, N)
    [fValues gValues] = setUp(N);
    fTransform = zeros(N,N);
    
    % fft on f(x_k-m)
    for k = 1:N
        fTransform(k,:) = myFFT(fValues(k,:));
    end
    
    % fft on g(x_m)
    gTransform = myFFT(gValues);
    
    % approximate h_k for k=0:16
    hTransform = (fTransform*gTransform')';
    hValues = iMyFFT(hTransform);
end

function [answer] = directComputation(N)
    [fValues gValues] = setUp(N);
    answer = zeros(1,N);
    % actual answer:
    for k = 1:N
        answer(k) = sum(fValues(:,k).*gValues(:));
    end
    answer = (1/N).*answer;
end

function [fValues gValues] = setUp(N)
    a = 0.95;
    h = 2*pi/N;
    
    f = @(x) (1.-a.*(cos(x).^2)).^(1/2);
    g = @(x) sin(x);
    
    % set up the f grid
    f_points = zeros(N,N);
    for k = 0:(N-1);
        for m = 0:(N-1);
            f_points(k+1,m+1) = k-m;
        end 
    end
    f_grid = f_points.*h;
    
    % since periodic, take the absolute value
    f_grid = abs(f_grid);
    
    % set up the g grid
    g_grid = [0:(N-1)].*h;
    
    % calculate f and g values
    fValues = zeros(N,N);
    for k = 1:N
        fValues(k,:) = f(f_grid(k,:));
    end
    gValues = g(g_grid);
end