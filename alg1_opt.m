function [max_utility] = alg1_opt(threshold,T,L,M,value,...
    N,variance)

max_utility = 0;

num = 0;
for num=0:M^N
    coverage_num = zeros(M,1);
    total_variance = zeros(M,1);
    utility = 0;
    
    tmp = num;
    for i=1:N
        remnant = rem(tmp,M)+1;
        coverage_num(remnant) = coverage_num(remnant)+1;
        total_variance(remnant) = total_variance(remnant)+variance(i);
        tmp = fix(tmp/M);
    end
    
    for l=1:M
        if total_variance(l)/coverage_num(l)^2 <= threshold
            utility = utility + value(l);
        end
    end
                    
	if utility>max_utility
        max_utility = utility;
	end
    
end

max_utility = max_utility*T;
end