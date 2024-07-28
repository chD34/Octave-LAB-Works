disp('Lab4')

function result = func(x)
    x1 = x(1);
    x2 = x(2);
    result = 2 * x1^2 + 2 * x2^2 + x1 * x2 - 11 * x1 - 8 * x2;
end

start_vector = [-3, 5];

epsilon = 1e-6;
step = 0.01;


x1_range = -5:0.1:5;
x2_range = -5:0.1:5;
[X1, X2] = meshgrid(x1_range, x2_range);
Z = 2 * X1.^2 + 2 * X2.^2 + X1 .* X2 - 11 * X1 - 8 * X2;

current_point = start_vector;

points_x = [current_point(1)];
points_y = [current_point(2)];

while true

    gradient = [4 * current_point(1) + current_point(2) - 11, 4 * current_point(2) + current_point(1) - 8];


    if norm(gradient) < epsilon
        break;
    end


    current_point = current_point - step * gradient;
    points_x = [points_x, current_point(1)];
    points_y = [points_y, current_point(2)];
end

% Результат
minimum_point = current_point;
minimum_value = func(minimum_point);

fprintf('Точка мінімуму: %s\n', num2str(minimum_point));
fprintf('Значення в точці мінімуму: %.2f\n', minimum_value);
fprintf('Похибка: %.7f\n', abs(minimum_value + 94/5));


figure;
contour(X1, X2, Z, 50);
hold on;
plot(points_x, points_y, 'r.-');
xlabel('X1');
ylabel('X2');
title('Метод найшвидшого спуску');
grid on;

