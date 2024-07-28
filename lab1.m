disp("Gauss Method");

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


n = enter_int('Введіть розмірність матриці: ')

A = zeros(n, n);
b = zeros(n, 1);

for i = 1:n
    for j = 1:n
        A(i, j) = enter_real(sprintf('Введіть елемент A(%d,%d): ', i, j));
        while i == j && A(i, j) == 0
          disp("Елемент головної діагоналі не має дорівнювати 0, інакше система нерозв'язна")
          A(i, j) = enter_real(sprintf('Введіть елемент A(%d,%d): ', i, j));
        end
    end
end

for i = 1:n
    b(i) = enter_real(sprintf('Введіть елемент b(%d): ', i));
end

Ab =[A b];
disp("\nВведена розширена матриця системи: ")
disp(Ab)

disp("\nРозв'язок методом Гауса... ")


% algorithm gauss
for i = 1: n
  Ab(i, :) = Ab(i, :) ./ Ab(i, i);
  for j = 1: n
    if j != i
      ratio = Ab(j, i) ./ Ab(i, i);
      Ab(j, :) = Ab(j, :) - ratio * Ab(i, :);
    endif
  endfor
endfor

disp("\nРезультатуюча матриця системи: ")
disp(Ab)

disp("\nРозв'язки: ")
b = Ab(:, n + 1);

for i = 1:n
    fprintf('x(%d) = %f\n', i, b(i));
end

disp('\nПохибка методу:')
error = norm(b - [38370094/2608217; -69077923/2608217; -5296054/ 2608217]);
disp(error)
