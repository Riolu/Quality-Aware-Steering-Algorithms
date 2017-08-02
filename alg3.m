function [ utility ] = alg3(threshold,T,L,M,value,N,...
    variance,location_x,location_y,location,psi)

for i = 1:N
    % calculate starting location
    location_x(i,1) = randi([1,L]);
    location_y(i,1) = randi([1,L]);
    location(i,1) = location_x(i,1) + L*(location_y(i,1)-1);
    
    % calculate ending location
    [location_x(i,T), location_y(i,T)] ...
        = cal_des(location_x(i,1),location_y(i,1),T,L);
    location(i,T) = location_x(i,T) + L*(location_y(i,T)-1);
end

P_opt = zeros(N,T);

for count = 1:psi
    %disp(['alg3 ',num2str(count),' iteration']);
    P = zeros(N,T);
    order = randperm(N);
    for i = order
        p_i = cal_path(i,location_x(i,1),location_y(i,1),...
            location_x(i,T),location_y(i,T),P,variance,value,L,M,N,T,threshold);
        P(i,:) = p_i;
    end
    
    if cal_path_uti(P,threshold,N,M,T,variance,value)...
            > cal_path_uti(P_opt,threshold,N,M,T,variance,value)
        P_opt = P;
    end
end

utility = cal_path_uti(P_opt,threshold,N,M,T,variance,value);

end

%-------------------------------------------------------------
function [flag] = isrange(x, L)
    if x >=1 && x <=L
        flag = 1;
    else
        flag = 0;
    end
end

%-------------------------------------------------------------
function [end_x, end_y] = cal_des(start_x, start_y, T, L)

dis_x = randi([1,T-1]);
dis_y = T-1 - dis_x;

candi = [   start_x + dis_x, start_y + dis_y;
            start_x + dis_x, start_y - dis_y; 
            start_x - dis_x, start_y + dis_y;
            start_x - dis_x, start_y - dis_y; ];

for temp = 1:4
    if isrange(candi(temp,1),L) && isrange(candi(temp,2),L)
        end_x = candi(temp,1);
        end_y = candi(temp,2);
        break;
    end
end

end

%--------------------------------------------------------------
function [path] = cal_path(index,start_x,start_y,end_x,end_y,...
    P,variance,value,L,M,N,T,threshold)

dir_x = sign(end_x - start_x); % 1 for right, -1 for left
dir_y = sign(end_y - start_y); % 1 for up, -1 for down

dis_x = abs(end_x - start_x);
dis_y = abs(end_y - start_y);

uti = zeros(dis_x+1, dis_y+1);

for i = 1 : dis_x+1
    for j = 1 : dis_y+1
        temp_i = start_x + dir_x * (i-1);
        temp_j = start_y + dir_y * (j-1);
        % to calculate a marginal-value matrix for sensing area
        round = i+j-1;
        uti(i,j) = utility_point(index,temp_i,temp_j,round,variance,...
            value,P,threshold,N,L);
    end
end

obtained = uti;
pre_x = zeros(dis_x+1, dis_y+1);
pre_y = zeros(dis_x+1, dis_y+1);

for i = 1 : dis_x+1
    for j = 1 : dis_y+1
        if i == 1 && j == 1
            obtained(i,j) = obtained(i,j);
            pre_x(i,j) = 1;
            pre_y(i,j) = 1;
        elseif i == 1 % row 1
            obtained(i,j) = obtained(i,j-1) + obtained(i,j);
            pre_x(i,j) = i;
            pre_y(i,j) = j-1;
        elseif j == 1 % column 1
            obtained(i,j) = obtained(i-1,j) + obtained(i,j);
            pre_x(i,j) = i-1;
            pre_y(i,j) = j;
        else
            if obtained(i,j-1) > obtained(i-1,j)
                obtained(i,j) = obtained(i,j-1) + obtained(i,j);
                pre_x(i,j) = i; pre_y(i,j) = j-1;
            else
                obtained(i,j) = obtained(i-1,j) + obtained(i,j);
                pre_x(i,j) = i-1; pre_y(i,j) = j;
            end
        end
    end
end

path_x = zeros(1,T); path_y = zeros(1,T);
path = zeros(1,T);

temp1 = dis_x+1; temp2 = dis_y+1;
for t = 1:T
    path_x(T-t+1) = temp1;
    path_y(T-t+1) = temp2;
    temp3 = pre_x(temp1,temp2); 
    temp4 = pre_y(temp1,temp2);
    temp1 = temp3;
    temp2 = temp4;
end

for t = 1:T
    temp_i = start_x + dir_x * (path_x(t)-1);
    temp_j = start_y + dir_y * (path_y(t)-1);
    path(t) = temp_i + L * (temp_j - 1);
end

end

%--------------------------------------------------------------
function [utility] = utility_point(index,x,y,round,variance,...
    value,P,threshold,N,L)

sum_var = 0;
num_cov = 0;
for i = 1:N
    if P(i,round)==(x+L*(y-1))
        sum_var = sum_var + variance(i);
        num_cov = num_cov + 1;
    end
end

if num_cov == 0 || sum_var / num_cov^2 > threshold
    sum_var = sum_var + variance(index);
    num_cov = num_cov + 1;
    if sum_var / num_cov^2 > threshold
        utility = 0;
    else
        utility = value(x+L*(y-1));
    end
else
    utility = 0;
end

end

%--------------------------------------------------------------
function [utility] = cal_path_uti(location,threshold,N,M,T,variance,value)

utility = 0;

for t = 1:T
    for l = 1:M
        sum_var = 0;
        num_cov = 0;
        for i = 1:N
            if location(i,t) == l
                sum_var = sum_var + variance(i);
                num_cov = num_cov + 1;
            end
        end
        if num_cov > 0 && sum_var / num_cov^2 <= threshold
            utility = utility + value(l);
        end
    end
end


end

















