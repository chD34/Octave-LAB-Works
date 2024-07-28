x1 = [3.1; 3.1; 3.1; 3.2; 3.6; 3.6];
x2 = [1.4; 1.5; 1.5; 1.7; 1; 1];
y = [1157; 1160; 1161; 1260; 1040; 1039];

X = [ones(size(x1)) x1 x2];

% Обчислення методом МНК
beta =  inv(X'*X) * X' * y;

% Результати
disp('Параметри:');
disp(beta);


y_predicted = X * beta;
y_mean = mean(y);
SS_total = sum((y - y_mean).^2);
SS_regression = sum((y_predicted - y_mean).^2);
R_squared = SS_regression / SS_total;
disp('');
disp(['Коефіцієнт детермінації R^2: ', num2str(R_squared)]);
