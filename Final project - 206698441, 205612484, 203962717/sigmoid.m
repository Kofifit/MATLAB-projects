function g = sigmoid( z )

% This function get a vector and calculates the sigmoid function.
% The output is a double vector.

g=1./(1+exp(-z));
