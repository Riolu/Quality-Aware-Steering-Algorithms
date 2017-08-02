function [ utility ] = alg2(threshold,T,L,M,value,N,...
    variance,location_x,location_y,location,gamma)

location_x(:,1) = randi([1,L],N,1);
location_y(:,1) = randi([1,L],N,1);
location(:,1) = location_x(:,1) + (location_y(:,1)-1) * L;

utility = cal_uti(location(:,1),variance,value,threshold,M,N);

for t = 2:T
    t_tmp1 = location(:,t-1);
    t_tmp2 = location(:,t-1);
    
    for count = 1:gamma
        for i = 1:N
            candidate = cal_candi(t_tmp1(i),L);
            for i_loc = candidate
                t_tmp3 = t_tmp2;
                t_tmp3(i) = i_loc;
                if cal_uti(t_tmp3,variance,value,threshold,M,N) >= ...
                        cal_uti(t_tmp2,variance,value,threshold,M,N)
                    t_tmp2(i) = i_loc;
                end
            end
        end
    end
    location(:,t) = t_tmp2;
    utility = utility + cal_uti(location(:,t),variance,value,threshold,M,N);
end

end

%-----------------------------------------------------------
function [candi] = cal_candi(loc,L)
    
    x = mod(loc,L);
    y = ceil(loc/L);
    
    %left
    x1 = x-1;
    if x1 == 0
        x1 = L;
    end
    a1 = x1 + L*(y-1);
    
    %right
    x2 = x+1;
    if x2 > L
        x2 = 1;
    end
    a2 = x2 + L*(y-1);
    
    %up
    y1 = y+1;
    if y1 > L
        y1=1;
    end
    a3 = x + L*(y1-1);
    
    %down
    y2 = y-1;
    if y2 ==0
        y2=L;
    end
    a4 = x + L*(y2-1);
    
    candi = [loc, a1, a2, a3, a4];
    
end


%-----------------------------------------------------------
function [utility] = cal_uti(loc,variance,value,threshold,M,N)

sum_var = zeros(M,1);
num_cov = zeros(M,1);
utility = 0;

for l = 1:M
    for i = 1:N
        if loc(i) == l
            sum_var(l) = sum_var(l) + variance(i);
            num_cov(l) = num_cov(l) + 1;
        end
    end
    if sum_var(l) / num_cov(l)^2 <= threshold
        utility  = utility + value(l);
    end
end
    
end