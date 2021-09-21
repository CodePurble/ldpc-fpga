function [G] = pchk2gen(H, n, k)
A = H(1:end, 1:k);
B = H(1:end, (k+1):end);

B_trans_inv_gf2 = inv_GF2(B');
G = [eye(k), mod(A' * B_trans_inv_gf2, 2)];
end
