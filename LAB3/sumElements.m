function [sum_array] = sumElements(h, N_range)

    sum_array = zeros(size(N_range));
    h_mid = floor(length(h)/2)+1;

    for i = 1:length(N_range)
        N = N_range(i);
        N_min = max(1, h_mid -N);
        N_max = min(length(h),h_mid +N);
        sum_array(i) = sum(abs(h(N_min:N_max)));
    end
end
