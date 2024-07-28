disp('Lab 2');

function result = enter_real(text)
    while true
        num = input(text, 's');
        if isempty(num)
            disp('Пустий ввід. Введіть щось...');
        else
            num = strrep(num, ',', '.');
            result = str2num(num);
            if ~isnan(result)
                break;
            else
                disp('Будь ласка, введіть коректне дійсне число використовуючи кому (,)');
            end
        end
    end
end

function validated_integer = enter_int(text)
    while true
        input_str = input(text, 's');
        input_num = str2double(input_str);

        if ~isnan(input_num) && floor(input_num) == input_num && input_num > 0
            validated_integer = input_num;
            break;
        else
            fprintf('Будь ласка, введіть коректне ціле число більше 0.\n');
        end
    end
end

function result = f(x)
    result = -x / (3 * tan(3 * x)) + (1 / 9) * log(sin(3 * x));
end

function result = f2(x)
    result = x / ((sin(3 * x)) ^ 2);
end


function result = lagrange_differentiation(n, h, val)
    result = [(1 / (2 * h)) * (-3 * val(1) + 4 * val(2) - val(3))];
    for i = 2:(n-1)
        result = [result, (1 / (2 * h)) * (val(i + 1) - val(i - 1))];
    end
    result = [result, (1 / (2 * h)) * (val(n - 2) - 4 * val(n - 1) + 3 * val(n))];
end

a = enter_real('Введіть значення нижньої межі - а: ');
b = enter_real('Введіть значення верхньої межі - b: ');
n = enter_int('Введіть значення кількості розбиттів - n: ');
h = 0.04;

h = (b - a) / n;
t = linspace(a, b, n);
values = arrayfun(@(t) f(t), t);
diff_values = arrayfun(@(t) f2(t), t);

integral_sum = f2(a) + f2(b);


for i = 1:(n/2 - 1)
    x = a + 2 * i * h;
    integral_sum = integral_sum + 4 * f2(x);
end

for i = 1:(n/2)
    x = a + (2 * i - 1) * h;
    integral_sum = integral_sum + 2 * f2(x);
end


integral_value = (h / 3) * integral_sum;


lst = lagrange_differentiation(n, h, values)

printf("Точка розбиття (x)\t Похідна (f'(x))\t Похибка\n");
for i = 1:(n)
    printf("%0.3f\t\t\t%0.5f\t\t\t%0.5f\n", t(i), lst(i), abs(abs(lst)-abs(diff_values))(i));
end

fprintf('\nЗначення інтегралу: %f', integral_value);
fprintf('\nПохибка обчислення інтегралу: %f\n', abs(f(b)-f(a)-integral_value));
