% Efficiencies:
% * Use Date (date = datevec(out{1});)
% * Don't round temp
%
%% ================ Part 1: Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
fid = fopen('train.csv');
train_raw = textscan(fid,'%*s%n%n%n%n%n%n%n%n%n%n%n%n','collectoutput',1,'delimiter',',','headerlines',1);
fclose(fid);

% ignore date column (column 1)
X = train_raw{1}(:,[2:9]);
y = train_raw{1}(:,12);

m = length(y);

% Print out some data points
fprintf('First 10 examples from the dataset: \n');
fprintf(' x = [%d, %d, %d, %d, %d, %d, %d, %d], y = %d \n', [X(1:10,:) y(1:10,:)]');

fprintf('Program paused. Press enter to continue.\n');
pause;

% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');

[X mu sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];


%% ================ Part 2: Gradient Descent ================

% ====================== YOUR CODE HERE ======================
% Instructions: We have provided you with the following starter
%               code that runs gradient descent with a particular
%               learning rate (alpha). 
%
%               Your task is to first make sure that your functions - 
%               computeCost and gradientDescent already work with 
%               this starter code and support multiple variables.
%
%               After that, try running gradient descent with 
%               different values of alpha and see which one gives
%               you the best result.
%
%               Finally, you should complete the code at the end
%               to predict the price of a 1650 sq-ft, 3 br house.
%
% Hint: By using the 'hold on' command, you can plot multiple
%       graphs on the same figure.
%
% Hint: At prediction, make sure you do the same feature normalization.
%

fprintf('Running gradient descent ...\n');

% Choose some alpha value
alpha = 0.03;
num_iters = 400;

% Init Theta and Run Gradient Descent 
theta = zeros(size(X, 2), 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');

% % Estimate the price of a 1650 sq-ft, 3 br house
% % ====================== YOUR CODE HERE ======================
% % Recall that the first column of X is all-ones. Thus, it does
% % not need to be normalized.
% price = 0; % You should change this

% x = [1650 3];              % Data
% x = (x - mu) ./ sigma;  % Apply normalization.
% x = [ones(1, 1) x];       % Upgrade to design matrix.
% price = x * theta;        % Make the predication.

% %price = sum([1 featureNormalize([1650 3])] * theta);
% % ============================================================

% fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
%          '(using gradient descent):\n $%f\n'], price);

% fprintf('Program paused. Press enter to continue.\n');
% pause;

% %% ================ Part 3: Normal Equations ================

% fprintf('Solving with normal equations...\n');

% % ====================== YOUR CODE HERE ======================
% % Instructions: The following code computes the closed form 
% %               solution for linear regression using the normal
% %               equations. You should complete the code in 
% %               normalEqn.m
% %
% %               After doing so, you should complete this code 
% %               to predict the price of a 1650 sq-ft, 3 br house.
% %

% %% Load Data
% data = csvread('ex1data2.txt');
% X = data(:, 1:2);
% y = data(:, 3);
% m = length(y);

% % Add intercept term to X
% X = [ones(m, 1) X];

% % Calculate the parameters from the normal equation
% theta = normalEqn(X, y);

% % Display normal equation's result
% fprintf('Theta computed from the normal equations: \n');
% fprintf(' %f \n', theta);
% fprintf('\n');


% % Estimate the price of a 1650 sq-ft, 3 br house
% % ====================== YOUR CODE HERE ======================
% price = 0; % You should change this

% price = sum([1 1650 3] * theta);
% % ============================================================

% fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
%          '(using normal equations):\n $%f\n'], price);

