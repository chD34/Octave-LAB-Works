
disp('Lab1')

% матриці A і B
A = [9 2 1; 1 3 2; 1 2 3; 10 2 1];
B = [12; 12; 12; 12];

% Перша трансформація Гауса
A_transposed = A' * A;
B_transposed = A' * B;

% Розв'язання
X = A_transposed \ B_transposed;

disp("Розв'язок системи:");
disp(X);


AX = A * X;

% похибка
error = norm(AX - B);

disp('Похибка обчислень:');
disp(error);

