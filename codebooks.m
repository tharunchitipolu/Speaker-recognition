function r = codebooks(d,k)
% Output: r contains the result VQ codebook (k columns, one for each centroids)

e   = .01;
r   = mean(d, 2);%column vector containing the mean of each row
dpr = 10000;

for i = 1:log2(k)
    r = [r*(1+e), r*(1-e)];
    
    while (1 == 1)
        z = euc_dist(d, r);
        [m,ind] = min(z, [], 2);%column vector containing the minimum value of each row
        t = 0;
        for j = 1:2^i
            r(:, j) = mean(d(:, find(ind == j)), 2);
            x = euc_dist(d(:, find(ind == j)), r(:, j));
            for q = 1:length(x)
                t = t + x(q);
            end
        end
        if (((dpr - t)/t) < e) 
            break;
        else
            dpr = t;
        end
   end    
end
