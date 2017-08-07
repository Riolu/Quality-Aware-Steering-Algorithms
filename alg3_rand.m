function [ utility ] = alg3_rand(threshold,T,L,M,value,N,...
    variance,location_x,location_y,location)

for i=1:N
    start_x = location_x(i,1);  end_x = location_x(i,T);
    start_y = location_y(i,1);  end_y = location_y(i,T);

    dir_x = sign(end_x - start_x); % 1 for right, -1 for left
    dir_y = sign(end_y - start_y); % 1 for up, -1 for down
 
    dis_x = abs(end_x - start_x);
    dis_y = abs(end_y - start_y);
    
    x=1; y=1;
    x_max = 1+dis_x;
    y_max = 1+dis_y;
    move = dis_x+dis_y;
    for j=1:move
        if x==x_max
            y = y+1;
            location_x(i,j+1) = location_x(i,j);
            location_y(i,j+1) = location_y(i,j)+dir_y*1;
        elseif y==y_max
            x = x+1;
            location_x(i,j+1) = location_x(i,j)+dir_x*1;
            location_y(i,j+1) = location_y(i,j);
        else
            z = randi([1,2]); %1œÚ…œ 2œÚ”“
            if z==1
                y = y+1;
                location_x(i,j+1) = location_x(i,j);
                location_y(i,j+1) = location_y(i,j)+dir_y*1;
            else
                x = x+1;
                location_x(i,j+1) = location_x(i,j)+dir_x*1;
                location_y(i,j+1) = location_y(i,j);
            end
            
        end
        %disp([location_x(i,j+1),location_y(i,j+1)]);
        location(i,j+1) = location_x(i,j+1)+(location_y(i,j+1)-1)*L;
    end
end
%disp(location);
utility = 0;
for t=1:T
    utility = utility+cal_uti(location(:,t),variance,value,threshold,M,N);
end

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