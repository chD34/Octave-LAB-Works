pkg load optim

x = [0, 1, 2, 3, 4, 5];
y = [1.3, 5.8, 11.3, 16.6, 27.4, 37.5];

fun = @(params, x) params(1) * exp(params(2) * x) + params(3);

% Початкові значення параметрів
initial_guess = [1, 1, 1];

% МНК
params = lsqcurvefit(fun, initial_guess, x, y);

a = params(1);
b = params(2);
c = params(3);

% Результати
fprintf('a = %f\n', a);
fprintf('b = %f\n', b);
fprintf('c = %f\n', c);

y_pred = a * exp(b * x) + c;

% Обчислення MSE
mse = sum((y - y_pred).^2) / numel(y);

% Обчислення R-squared
SS_res = sum((y - y_pred).^2);
SS_tot = sum((y - mean(y)).^2);
R_squared = 1 - SS_res / SS_tot;

% Виведення результатів
fprintf('MSE = %f\n', mse);
fprintf('R-squared = %f\n', R_squared);

% Графік
xx = linspace(min(x), max(x), 100);
yy = a * exp(b * xx) + c;

figure;
plot(x, y, 'LineWidth', 1.5, 'ko', xx, yy, 'r-', 'LineWidth', 1.5);
xlabel('x');
ylabel('y');
legend('Дані', 'Експоненційна регресія', 'FontSize', 14);


