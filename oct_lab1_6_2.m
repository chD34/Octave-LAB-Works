
% вхідні дані
n = 23;
s_0 = sqrt(23);
v = 125;
l = 23;
fi = pi * 23 / 25;


disp('INPUT DATA');
disp(['n = ', num2str(n)]);
disp(['s_0 = ', num2str(s_0)]);
disp(['v = ', num2str(v)]);
disp(['l = ', num2str(l)]);
disp(['fi = ', num2str(fi)]);


% стартові координати човна
x_1 = 0;
x_2 = 0;

N = 10000
tau = (l / v) / N;
disp(['tau = ', num2str(tau)]);

x_1_values = zeros(1, N+1);
x_2_values = zeros(1, N+1);

function [u_1, u_2] = calculate_control(x_1, x_2, s_0, v, l, fi, tau)

    % формула для λ
    lambda = sqrt((l*cos(fi) - x_1 - s_0 * x_2 * tau)^2 +
    (l*sin(fi) - x_2)^2) * v * tau - v^2 * tau^2;

    % формули для u1, u2
    u_1 = ((l*cos(fi) - x_1 - s_0 * x_2 * tau) * v * tau) / (lambda + v^2 * tau^2);
    u_2 = ((l*sin(fi) - x_2) * v * tau) / (lambda + v^2 * tau^2);
end



for i = 1:N

    [u_1, u_2] = calculate_control(x_1, x_2, s_0, v, l, fi, tau);

    % формули для x1, x2
    x_1 = x_1 + (s_0 * x_2 + v * u_1) * tau;
    x_2 = x_2 + v * u_2 * tau;

    x_1_values(i+1) = x_1;
    x_2_values(i+1) = x_2;
end



k = 1300
for i = 1:k

    [u_1, u_2] = calculate_control(x_1_values(N), x_2_values(N), s_0, v, l, fi, tau);

    % формули для x1, x2
    x_1 = x_1 + (s_0 * x_2 + v * u_1) * tau;
    x_2 = x_2 + v * u_2 * tau;

    x_1_values(i+N+1) = x_1;
    x_2_values(i+N+1) = x_2;
end

time = l/v/N*(N+k);

% графік
plot(x_1_values, x_2_values, 'g.-', 'DisplayName', ['Траекторія з параметрами: s_0 = ', num2str(s_0), ' v = ', num2str(v), ' l = ', num2str(l), ' fi = ', num2str(fi), ', час: ', num2str(time)]);
hold on;
plot(l*cos(fi), l*sin(fi), 'b', 'MarkerSize', 12, 'DisplayName', ['Фінальна точка']);
xlabel('X_1', 'FontSize', 20);
ylabel('X_2', 'FontSize', 20);
title('Траєкторія переміщення човна', 'FontSize', 20);
grid on;
set(gca, 'FontSize', 16);
legend('show');

