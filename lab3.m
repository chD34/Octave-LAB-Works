disp('Lab 3')

function y = f(x, u)
    y = zeros(2, 1);
    y(1) = u(2);
    y(2) = 2 * u(2) - u(1);
end

function y = analytic_solution(x)
    y = 7 * exp(x-2) - 3 * exp(x-2) * x;
end

% Initial conditions
x0 = 2.0;
y0 = 1.0;
z0 = -2.0;
u0 = [y0; z0];

% Integration interval
x_end = 4.0;

% Integration step
h = 0.2;

function [t_values, y_values] = runge_kutta2(f, u0, x0, x_end, h)
    x = x0;
    u = u0;
    y_values = [u(1)];
    t_values = [x];
    while x < x_end
        k1 = h * f(x, u);
        k2 = h * f(x + h, u + k1);
        u = u + 0.5 * (k1 + k2);
        x = x + h;
        y_values = [y_values; u(1)];
        t_values = [t_values; x];
    end
end

function [t_values, y_values] = runge_kutta3(f, u0, x0, x_end, h)
    x = x0;
    u = u0;
    y_values = [u(1)];
    t_values = [x];
    while x < x_end
        k1 = h * f(x, u);
        k2 = h * f(x + 0.5 * h, u + 0.5 * k1);
        k3 = h * f(x + h, u - k1 + 2 * k2);
        u = u + (1/6) * (k1 + 4 * k2 + k3);
        x = x + h;
        y_values = [y_values; u(1)];
        t_values = [t_values; x];
    end
end

function [t_values, y_values] = runge_kutta4(f, u0, x0, x_end, h)
    x = x0;
    u = u0;
    y_values = [u(1)];
    t_values = [x];
    while x < x_end
        k1 = h * f(x, u);
        k2 = h * f(x + 0.5 * h, u + 0.5 * k1);
        k3 = h * f(x + 0.5 * h, u + 0.5 * k2);
        k4 = h * f(x + h, u + k3);
        u = u + (1/6) * (k1 + 2 * k2 + 2 * k3 + k4);
        x = x + h;
        y_values = [y_values; u(1)];
        t_values = [t_values; x];
    end
end

[t_values_rk2, y_values_rk2] = runge_kutta2(@f, u0, x0, x_end, h);
[t_values_rk3, y_values_rk3] = runge_kutta3(@f, u0, x0, x_end, h);
[t_values_rk4, y_values_rk4] = runge_kutta4(@f, u0, x0, x_end, h);


plot(t_values_rk2, y_values_rk2, 'LineWidth', 2);
hold on;
plot(t_values_rk3, y_values_rk3, 'LineWidth', 2);
plot(t_values_rk4, y_values_rk4, 'LineWidth', 2);
xlabel('x', 'FontSize', 20);
ylabel('y(x)', 'FontSize', 20);
legend('Method 2nd order', 'Method 3rd order', 'Method 4th order', 'FontSize', 20);
title('Solution of the differential equation using Runge-Kutta methods', 'FontSize', 16);
grid on;
set(gca, 'FontSize', 20);
hold off;

error_rk2 = mean(abs(arrayfun(@analytic_solution, t_values_rk2) - y_values_rk2));
error_rk3 = mean(abs(arrayfun(@analytic_solution, t_values_rk3) - y_values_rk3));
error_rk4 = mean(abs(arrayfun(@analytic_solution, t_values_rk4) - y_values_rk4));

fprintf('Error (2nd order): %f\nError (3rd order): %f\nError (4th order): %f\n', error_rk2, error_rk3, error_rk4);
