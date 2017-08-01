fid = fopen('trip_data_2.csv'); %第一行 第六列开始读
title = textscan(fid, '%s %s %s %s %s %s %s %s %s %s %s %s %s %s',1,'delimiter', ',');
data = textscan(fid, '%s %s %s %s %s %s %s %d32 %d32 %d32 %d32 %d32 %d32 %d32','delimiter', ',');
fclose(fid);
disp(title{1});
%--------------------纽约------------------------
% [m,n] = size(X);
% map = zeros(m,n-3); %pickup_longitude  pickup_latitude  dropoff_longitude  dropoff_latitude
% 
% datetime = zeros(m,2); %记录pickup和dropoff_datetime的datenum
% min_i = 0; %记录datenum最小的序号
% min_datenum = datenum('2017/1/1 0:00:00','yyyy/mm/dd HH:MM:SS'); %记录最小的datenum
% 
% for i = 1:m
%     date_time = cell2mat(X(i,1));
%     datetime(i,1) = datenum(date_time,'yyyy/mm/dd HH:MM:SS');
%     if datetime(i,1)<min_datenum
%         min_datenum = datetime(i,1);
%         min_i = i;
%     end
% end
% 
% T = 0.5*1000/(70/3.6); %假设纽约街道500m 出租车70km/h
% turn = zeros(m,2); %计算是第几个周期
% 
% for i = 1:m
%     sub = datetime(i,1)-min_datenum;
%     sub_vec = datevec(sub);
%     datetime(i,1) = sub_vec(6)*1 + sub_vec(5)*60 + sub_vec(4)*3600 + sub_vec(3)*3600*24; %不会超过月
%     turn(i,1) = round(datetime(i,1)/T);
%     datetime(i,2) = datetime(i,1)+cell2mat(X(i,3));
%     turn(i,2) = round(datetime(i,2)/T);
% end
% 
% 
% 
% 
% 
% 
% 
% min_longitude = 360;
% max_longitude = -360;
% min_latitude = 360;
% max_latitude = -360;
% 
% 
% for i = 1:m
%     longitude_s = cell2mat(X(i,4));
%     longitude_t = cell2mat(X(i,6));
%     max_longitude = max(max_longitude, max(longitude_s,longitude_t)); 
%     min_longitude = min(min_longitude, min(longitude_s,longitude_t)); 
%     
%     latitude_s = cell2mat(X(i,5));
%     latitude_t = cell2mat(X(i,7));
%     max_latitude = max(max_latitude, max(latitude_s,latitude_t)); 
%     min_latitude = min(min_latitude, min(latitude_s,latitude_t)); 
% end
% 
% for i = 1:m
%     map(i,1) = (cell2mat(X(i,4))-min_longitude) * 111* 0.766; %千米
%     map(i,3) = (cell2mat(X(i,6))-min_longitude) * 111* 0.766;
%     map(i,2) = (cell2mat(X(i,5))-min_latitude) * 111;
%     map(i,4) = (cell2mat(X(i,7))-min_latitude) * 111;
% end
% 
% disp(max_longitude);
% disp(min_longitude);
% disp(max_latitude);
% disp(min_latitude);
% 
% %(max_latitude-min_latitude)*111
% %(max_longitude-min_longitude)*111* 0.766
% 
% length = 0.5;   %假定纽约街道500m
% grid = ceil((max_latitude-min_latitude)*111/length); %多少乘多少个格子  
% width = (max_longitude-min_longitude)*111*0.766/grid;
% 
% 
% position = zeros(m,n-3); %记录第几行第几个
% for i = 1:m
%     position(i,1) = floor(map(i,1)/width)+1; %第几个
%     position(i,3) = floor(map(i,3)/width)+1; 
%     position(i,2) = floor(map(i,2)/length)+1; %第几行
%     position(i,4) = floor(map(i,4)/length)+1;
% end
% 
% L = grid+1; %grid是格子数量 
% t1 = turn(:,1);
% t2 = turn(:,2);
% x1 = position(:,1);
% y1 = position(:,2);
% x2 = position(:,3);
% y2 = position(:,4);
% l1 = (y1-1)*L+x1;
% l2 = (y2-1)*L+x2;
% 
% save(['New_York_8_7.mat'],'L','t1','t2','x1','y1','x2','y2','l1','l2');

