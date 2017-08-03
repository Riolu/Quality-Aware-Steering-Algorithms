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


function [flag] = isrange(x, L)
    if x >=1 && x <=L
        flag = 1;
    else
        flag = 0;
    end
end