function [utility] = alg2_rand_5dir(threshold,T,L,M,value,...
    N,variance,location_x,location_y,location)

%disp(location(:,1));

for i = [1:N]
    for t = [2:T]
        direction = randi([1,4]);
        switch(direction)
            case 1 % go left
                location_x(i,t) = location_x(i,t-1) - 1;
                location_y(i,t) = location_y(i,t-1);
                if location_x(i,t) < 1
                    location_x(i,t) = L;
                end
            case 2 % go right
                location_x(i,t) = location_x(i,t-1) + 1;
                location_y(i,t) = location_y(i,t-1);
                if location_x(i,t) > L
                    location_x(i,t) = 1;
                end
            case 3 % go up
                location_x(i,t) = location_x(i,t-1);
                location_y(i,t) = location_y(i,t-1)+1;
                if location_y(i,t) > L
                    location_y(i,t) = 1;
                end
            case 4 % go down
                location_x(i,t) = location_x(i,t-1);
                location_y(i,t) = location_y(i,t-1)-1;
                if location_y(i,t) < 1
                    location_y(i,t) = L;
                end
            otherwise
                location_x(i,t) = location_x(i,t-1);
                location_y(i,t) = location_y(i,t-1);
        end
    end
end

coverage_num = zeros(M,T);    % number of l in t
total_variance = zeros(M,T);  % total var of l in t
obtain_value = zeros(M,T);    % if the value of l in t is obtained
utility = 0;

for i = [1:N]
    for t = [1:T]
        location(i,t) = location_x(i,t) + L*(location_y(i,t)-1);
    end
end

for t = [1:T]
    for l = [1:M]
        for i = [1:N]
            if location(i,t) == l
                coverage_num(l,t) = coverage_num(l,t) + 1;
                total_variance(l,t) = total_variance(l,t) + variance(i);
            end
        end
        if total_variance(l,t)/coverage_num(l,t)^2 <= threshold
            obtain_value(l,t) = 1;
            utility = utility + value(l);
        end
    end
end

end
