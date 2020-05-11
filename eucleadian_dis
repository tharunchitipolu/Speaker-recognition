function d = euc_dist(x, y)
%The Euclidean distance D between two vectors X and Y is:
%D = sum((x-y).^2).^0.5
[R1, C1] = size(x);
[R2, C2] = size(y); 

if (R1 ~= R2)
    error('Matrix dimensions do not match.')
end

d = zeros(C1, C2);

if (C1 < C2)
    extra = zeros(1,C2);
    for n = 1:C1
        d(n,:) = sum((x(:, n+extra) - y) .^2, 1);
    end
else
    extra = zeros(1,C1);
    for p = 1:C2
        d(:,p) = sum((x - y(:, p+extra)) .^2, 1)';
    end
end

d = d.^0.5;
end
