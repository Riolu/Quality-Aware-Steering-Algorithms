function [ max_utility ] = alg2_opt(threshold,T,L,M,value,N,...
    variance,location_x,location_y,location)

%utility = cal_uti(location(:,1),variance,value,threshold,M,N);

enum = zeros(5^(T-1)*N,T);

for p=1:N  %第p个人
    enum(1+(p-1)*5^(T-1),1) = location(p,1);
end

for t=2:T
    for p=1:N
        for row=1:5^(T-1)
            i = row+(p-1)*5^(T-1);
            if enum(i,t-1)~=0
                x = mod(enum(i,t-1)-1,L);
                y = fix((enum(i,t-1)-1)/L);

                %left
                x1 = x-1;
                if x1 < 0
                    x1 = L-1;
                end
                enum(i+0*5^(T-t),t) = x1 + L*y +1;

                %right
                x2 = x+1;
                if x2 == L
                    x2 = 0;
                end
                enum(i+1*5^(T-t),t) = x2 + L*y +1;

                %up
                y1 = y+1;
                if y1 == L
                    y1=0;
                end
                enum(i+2*5^(T-t),t) = x + L*y1 +1;

                %down
                y2 = y-1;
                if y2 <0
                    y2=L-1;
                end
                enum(i+3*5^(T-t),t) = x + L*y2 +1;

                %stay
                enum(i+4*5^(T-t),t) = enum(i,t-1);
            end
        end
    end
end

for t=1:T
    for p=1:N        
        for row=1:5^(T-1)
            i = row+(p-1)*5^(T-1);
            if enum(i,t)==0
                enum(i,t) = enum(i-1,t);
            end
        end
    end
end

max_utility=0;
num = 0;
for num=0:(5^(T-1))^N
    locate = zeros(N,T); %枚举所有人的路径
    
    tmp = num;
    for p=1:N
        remnant = rem(tmp,5^(T-1))+1;
        locate(p,:) = enum(remnant+(p-1)*5^(T-1),:);
        tmp = fix(tmp/5^(T-1));
    end
    
    utility = 0;
    for t=1:T
        utility = utility+cal_uti(locate(:,t),variance,value,threshold,M,N);
    end
    
    if utility>max_utility
        max_utility = utility;
    end
    
end
%disp(enum);
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