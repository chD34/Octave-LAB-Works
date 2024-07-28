disp('Lab 6')
pkg load optim


C = [16 30 17 10 16; 30 27 26 9 23; 13 4 22 3 1; 3 1 5 4 24]';
a = [4 6 10 10];
b = [7 7 7 7 2];


[m, n] = size(C);
A_eq = zeros(m + n, m * n);
b_eq = zeros(m + n, 1);

for i = 1:m
    A_eq(i, (i-1)*n + 1:i*n) = 1;
    b_eq(i) = b(i);
end

for j = 1:n
    A_eq(m+j, j:n:m*n) = 1;
    b_eq(m+j) = a(j);
end

lb = zeros(m * n, 1);
ub = [];
c = [16; 30; 17; 10; 16; 30; 27; 26; 9; 23; 13; 4; 22; 3; 1; 3; 1; 5; 4; 24];

ctype = repmat('S', 1, m + n);
vartype = repmat('C', 1, m * n);

[x, fval, status] = glpk(c, A_eq, b_eq, lb, ub, ctype, vartype, 1);

disp('Plan:');
disp(reshape(x, n, m));
disp('Minimized function: ');
disp(fval);

