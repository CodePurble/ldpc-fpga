% global col_weight_vec row_weight_vec;
% global max_col_weight max_row_weight;
% global cols_with_ones rows_with_ones;

N = 20;
K = 5;
M = N - K;
Z = 5;
H = [
    [1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    [0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0];
    [0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0];
    [0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0];
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1];

    [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0];
    [0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0];
    [0,0,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0];
    [0,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0];
    [0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1];

    [1,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0];
    [0,1,0,0,0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,0];
    [0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,1,0];
    [0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,1,0,0,0];
    [0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1]
];

%{
N = 11;
K = 5;
M = 5;
%M = N - K;
Z = 5;
H = [
    [1,0,0,0,0,1,1,1,0,0,0],
    [0,1,0,0,0,0,0,0,1,1,1],
    [0,0,1,0,0,1,0,0,1,0,0],
    [0,0,0,1,0,0,1,0,0,1,0],
    [0,0,0,0,1,0,0,1,0,0,1],
];
%}

function [cols_with_ones, rows_with_ones, row_weight_vec, col_weight_vec] = efficient_pcm(N, M, H)
    col_weight_vec = sum(H, 1);
    row_weight_vec = sum(H, 2);
    max_col_weight  = max(col_weight_vec);
    max_row_weight  = max(row_weight_vec);
    rows_with_ones = zeros(N, max_col_weight);
    cols_with_ones = zeros(M, max_row_weight);
    for i_row = 1 : M
        index = 1;
        for i_col = 1 : N
            if H(i_row, i_col)
                cols_with_ones(i_row, index) = i_col;
                index = index + 1;
            endif
        endfor
    endfor

    for i_col = 1 : N
        index = 1;
        for i_row = 1 : M
            if H(i_row, i_col)
                rows_with_ones(i_col, index) = i_row;
                index = index + 1;
            endif
        endfor
    endfor
endfunction

function [codeword] = encode_bits(N, K, M, H, Z, rows_with_ones, cols_with_ones, info_bits)
    col_weight_vec = sum(H, 1);
    row_weight_vec = sum(H, 2);
    max_col_weight  = max(col_weight_vec);
    max_row_weight  = max(row_weight_vec);
    % Does encoding by back substitution
    % Assumes a very specific structure on the partiy check matrix
    codeword = zeros(N, 1);
    codeword(1:K) = info_bits;

    parity = zeros(M, 1);
    for i_row = 1 : M
       for i_col = 1 : max_row_weight
           if (cols_with_ones(i_row, i_col) > 0) && ...
               (cols_with_ones(i_row, i_col) <= K)

               parity(i_row) = parity(i_row) + ...
               codeword(cols_with_ones(i_row, i_col));
           endif
       endfor
   endfor

   parity = mod(parity, 2);

   for i = 1 : Z
       codeword(K + i) = mod(sum(parity(i:Z:end)), 2);
   endfor

   for i_row = 1 : M
       for i_col = 1 : max_row_weight
           if (cols_with_ones(i_row, i_col) > K) && ...
                   (cols_with_ones(i_row, i_col) <= K + Z)

               parity(i_row) = mod(parity(i_row) + ...
               codeword(cols_with_ones(i_row, i_col)), 2);
           endif
       endfor
   endfor

   for i_col = K + Z + 1 : Z: N
        codeword(i_col: i_col + Z - 1) = parity(i_col -  K - Z : i_col - K - 1);

        parity(i_col -  K : i_col - K + Z - 1) = ...
        mod(parity(i_col -  K - Z : i_col - K - 1) + ...
            parity(i_col -  K : i_col + Z - K - 1), 2);
   endfor
endfunction

function [b] = check_codeword(x, M, cols_with_ones, row_weight_vec)
    b = 1;
    for i_check = 1 : M
        c = 0;
        for i_n = 1  : row_weight_vec(i_check)
            c = c + x(cols_with_ones(i_check, i_n));
        endfor
        if mod(c, 2) == 1
            b = 0;
            break;
        endif
    endfor
endfunction


function [decoded_codeword, error_vec] = ...
        decode_llr(
    M, N, row_weight_vec, col_weight_vec, ...
    rows_with_ones, cols_with_ones, input_llr_vec, max_iter, min_sum
    )
    eta = zeros(M, N);
    lasteta = zeros(M, N);
    updated_llr_vec = input_llr_vec;
    error_vec = zeros(max_iter, 1);
    for iter = 1 : max_iter
        for i_m = 1 : M
            for i_n1 = 1 : row_weight_vec(i_m)
                n1 = rows_with_ones(i_m, i_n1);
                if min_sum
                    pr = 100;
                else
                    pr = 1;
                endif
                for  i_n2 = 1 : row_weight_vec(i_m)
                    if i_n1 == i_n2
                        continue;
                    endif
                    n2 = rows_with_ones(i_m, i_n2);
                    l1 = (updated_llr_vec(n2) - lasteta(i_m, n2));
                    l1 = min(l1, 20);
                    l1 = max(l1, -20);
                    if min_sum
                        pr = sign(pr) * sign(l1) * min(abs(l1), abs(pr));
                    else
                        pr = pr * tanh(l1/2);
                    endif
                endfor
                if min_sum
                    eta(i_m, n1) = pr;
                else
                    eta(i_m, n1) = 2 * atanh(pr);
                endif
            endfor
        endfor

        lasteta = eta;

         for i_n = 1 : N
             updated_llr_vec(i_n) = input_llr_vec(i_n);
             for i_m = 1 : col_weight_vec(i_n)
                 m = cols_with_ones(i_n, i_m);
                 updated_llr_vec(i_n) = updated_llr_vec(i_n) + eta(m,i_n);
             endfor
         endfor

         decoded_codeword = (updated_llr_vec < 0);
         if check_codeword(decoded_codeword)
              return;
         else
             error_vec(iter) = 1;
         endif
    endfor
endfunction

[cols_with_ones, rows_with_ones, row_weight_vec, col_weight_vec] = ...
    efficient_pcm(N, M, H);
cols_with_ones
rows_with_ones

info_bits = [1 1 0 0 1]

[codeword] = encode_bits(N, K, M, H, Z, rows_with_ones, cols_with_ones, info_bits);
codeword'

%codeword(1) = codeword(1) & 0

[b] = check_codeword(codeword, M, cols_with_ones, row_weight_vec)
