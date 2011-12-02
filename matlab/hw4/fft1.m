function [dinverse1 dexact1] = fft1

m = 4:1:10;
N = 2.^m;
p = 2*pi;

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

% first derivative approximation
multiple1 = ((2*pi*1i)/p)*[0:1:(N(1)-1)];
dapprox1 = func1fft.*multiple1;

multiple2 = ((2*pi*1i)/p)*[0:1:(N(2)-1)];
dapprox2 = func2fft.*multiple2;

multiple3 = ((2*pi*1i)/p)*[0:1:(N(3)-1)];
dapprox3 = func3fft.*multiple3;

multiple4 = ((2*pi*1i)/p)*[0:1:(N(4)-1)];
dapprox4 = func4fft.*multiple4;

multiple5 = ((2*pi*1i)/p)*[0:1:(N(5)-1)];
dapprox5 = func5fft.*multiple5;

multiple6 = ((2*pi*1i)/p)*[0:1:(N(6)-1)];
dapprox6 = func6fft.*multiple6;

multiple7 = ((2*pi*1i)/p)*[0:1:(N(7)-1)];
dapprox7 = func7fft.*multiple7;

% inverse transform
dinverse1 = ifft(dapprox1);
dinverse2 = ifft(dapprox2);
dinverse3 = ifft(dapprox3);
dinverse4 = ifft(dapprox4);
dinverse5 = ifft(dapprox5);
dinverse6 = ifft(dapprox6);
dinverse7 = ifft(dapprox7);



% error
error1 = max(abs(dexact1 - dinverse1));
error2 = max(abs(dexact2 - dinverse2));
error3 = max(abs(dexact3 - dinverse3));
error4 = max(abs(dexact4 - dinverse4));
error5 = max(abs(dexact5 - dinverse5));
error6 = max(abs(dexact6 - dinverse6));
error7 = max(abs(dexact7 - dinverse7));

errorvec = [error1 error2 error3 error4 error5 error6 error7];


plot (N, errorvec)

semilogx(N , errorvec)

end

% 
% 
% function [transform] = fastfourier(x)
%     len = length(x);
%     transform = zeros(1,len);
%     
%     % base case
%     if len == 1
%         transform(1) = x(1);
%         return;
%         
%     % otherwise recurse    
%     else
%         halfLen = len/2;
%         even = zeros(1,halfLen);
%         odd = zeros(1,halfLen);
%         
%         % split the dfs into even and odd parts
%         for i = 0:halfLen-1
%             even(i+1) = x(2*(i+1));
%             odd (i+1) = x(2*(i+1)-1);
%         end
%         
%         % compute partial solutions
%         even = fastfourier(even);
%         odd = fastfourier(odd);
%         
%         % combine solutions
%         for k = 0:halfLen-1
%             omega = exp(-2*pi*i*(k+1)/len);
%             transform(k+1) = even(k+1) + omega * odd(k+1);
%             transform(k+1+halfLen) = even(k+1)- omega * odd(k+1);
%             return;
%         end
%     end
% end



        
      
        
    

    



