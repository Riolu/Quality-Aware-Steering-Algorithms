function [utility] = alg1(threshold,T,L,M,value,...
    N,variance)

[var_sort, var_index] = sort(variance,'descend');
[value_sort, value_index] = sort(value,'descend');
location_static = zeros(N,1);

C=1;
j=1;

while 1==1 % for every C
    
    wstart = 1;
    while 1==1 % move from right to left
        if wstart > length(var_index) || length(var_index(wstart:end)) < C
            % the remaining users are not enough 
            C = C + 1;
            break;
        end
        
        w_index = var_index(wstart:wstart+C-1);
        w_var = var_sort(wstart:wstart+C-1);
        if check_sat(w_var,threshold)==1
            location_static(w_index)=value_index(j);
            j = j + 1;
            var_index = [var_index(1:wstart-1); var_index(wstart+C:end)];
            var_sort = [var_sort(1:wstart-1); var_sort(wstart+C:end)];
        else
            if wstart+C-1 == length(var_index)
                C = C+1;
                break;
            else
                wstart = wstart +1;
            end
        end
        
    end
    
    if isempty(var_sort) || j > M || C > length(var_sort)
        break;
    end
end

utility = sum(value_sort(1:j-1))*T;
    
end

function [result] = check_sat(w_var,threshold)
    if sum(w_var)/length(w_var)^2 <= threshold
        result = 1;
    else
        result = 0;
    end
end