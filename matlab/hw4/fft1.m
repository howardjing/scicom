function [error] = fft1

m = 4:1:10;
N = 2.^m;

% steps
j1 = 0:1:N(1)-1;
j2 = 0:1:N(2)-1;
j3 = 0:1:N(3)-1;
j4 = 0:1:N(4)-1;
j5 = 0:1:N(5)-1;
j6 = 0:1:N(6)-1;
j7 = 0:1:N(7)-1;

% step size
h1 = 2*pi/N(1);
h2 = 2*pi/N(2);
h3 = 2*pi/N(3);
h4 = 2*pi/N(4);
h5 = 2*pi/N(5);
h6 = 2*pi/N(6);
h7 = 2*pi/N(7);

% uniform grid
x1 = j1*h1;
x2 = j2*h2;
x3 = j3*h3;
x4 = j4*h4;
x5 = j5*h5;
x6 = j6*h6;
x7 = j7*h7;


% f(x) = sin(50x) -> f'(x) = 50*cos(50x)

% value of function at sampled points
func1 = sin(50*x1);
func2 = sin(50*x2);
func3 = sin(50*x3);
func4 = sin(50*x4);
func5 = sin(50*x5);
func6 = sin(50*x6);
func7 = sin(50*x7);

% exact first derivatives
dexact1 = 50*cos(50*x1);
dexact2 = 50*cos(50*x2);
dexact3 = 50*cos(50*x3);
dexact4 = 50*cos(50*x4);
dexact5 = 50*cos(50*x5);
dexact6 = 50*cos(50*x6);
dexact7 = 50*cos(50*x7);

% fourier transform of sampled points
func1fft = fft(func1);
func2fft = fft(func2);
func3fft = fft(func3);
func4fft = fft(func4);
func5fft = fft(func5);
func6fft = fft(func6);
func7fft = fft(func7);

% fourier transform of approximation
% NOT SURE ABOUT THIS PART
multiplier = 50*1i.*j1;
dapprox1 = ifft(multiplier.*func1fft);
error = abs(dapprox1 - dexact1);
end


function [transform] = myfft(x)
    len = length(x);
    transform = zeros(1,len);
    
    % base case
    if len == 1
        transform(1) = x(1);
        return;
        
    % otherwise recurse    
    else
        halfLen = len/2;
        even = zeros(1,halfLen);
        odd = zeros(1,halfLen);
        
        % split the dfs into even and odd parts
        for i = 1:halfLen
            % shift everything up one
            even(i) = x(2*(i)-1);
            odd (i) = x(2*(1));
        end
        
        % compute partial solutions
        even = fft(even);
        odd = fft(odd);
        
        % combine solutions
        for k = 1:halfLen
            omega = exp(2*pi*i*(k-1)/len);
            transform(k) = (even(k) + odd(k)*omega)/2;
            transform(k+halfLen) = (even(k) - odd(k)*omega)/2;
            return;
        end
    end
end



        
      
        
    

    



