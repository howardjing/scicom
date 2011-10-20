
% set up our parameters
step = 0.0001;
n = 1/step;

% set up our x and f(x)
x = zeros(1,n-1);
fx = zeros(1, n-1);
U = zeros(1, n-1);

x = [step:step:n*step - step];
fx = sin(pi*x);
U = -sin(pi*x)/(2*pi^2);

% create the tridiagonal matrix A
mainDiag = zeros(1, n-1);
subDiag = zeros(1, n-2);
A = zeros(n-1,n-1);

mainDiag = -2*ones(1,(n-1));
subDiag = ones(1,(n-2));

A = diag(mainDiag, 0);
A = A + diag(subDiag, 1);
A = A + diag(subDiag, -1);
A = 0.5 * (1/(step^2)) * A;
% AU = fx, so solve for U
appxU = zeros(n-1,1);
appxU = A\fx';

errors = abs(U' - appxU);
norm = norm(errors,2);




