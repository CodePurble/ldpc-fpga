function [Ainv] = inv_GF2(A)
dim = size(A);
rows = dim(1);
cols = dim(2);

unity = eye(rows, cols);
Ainv = zeros(rows, cols);
for i = 1:rows
    % ith column of the inverse is the solution to the system of equations
    % Ax = b, where b (in this case) is the ith column of an identity
    % matrix of appropriate dimensions
    % Modulo 2 arithmetic is used everywhere (see what is GF(2))
    %
    % see `help gflineq` for more info
    % PS: this will not work in octave, matlab only
    Ainv(1:rows, i) = gflineq(A, unity(1:rows, i));
end
end

% Test code
n = 16;
k = 4;
A3 = [
    [0,0,1,0];
    [0,0,0,1];
    [0,1,0,0];
    [0,0,0,1];
    [0,0,1,0];
    [1,0,0,0];
    [0,0,0,1];
    [0,1,0,0];
    [1,0,0,0];
    [0,0,1,0];
    [0,1,0,0];
    [1,0,0,0];
];

B3 = [
    [0,0,0,1,0,1,0,0,1,0,0,0];
    [0,0,1,0,1,0,0,0,1,0,0,0];
    [1,0,1,0,0,1,0,0,0,0,0,0];
    [0,1,0,0,0,0,1,0,0,1,0,0];
    [0,0,0,0,1,0,0,0,0,0,1,1];
    [0,1,0,0,1,1,0,0,0,0,0,0];
    [0,0,0,1,0,0,0,1,0,0,1,0];
    [0,1,0,0,0,0,0,1,0,0,0,1];
    [0,0,1,0,0,0,0,0,0,1,0,1];
    [1,0,0,0,0,0,0,1,0,1,0,0];
    [0,0,0,0,0,0,1,0,1,0,1,0];
    [1,0,0,1,0,0,1,0,0,0,0,0];
];

H3 = [A3, B3];

B3_inv = inv_GF2(B3');
G = [eye(k), mod(A3'*B3_inv, 2)]

