

% globel variables:
threshold = 1;
T = 3;

% locations:
L = 5; % square L*L area
M = L*L;
value = randi([1,5],M,1);

% users:
N = 5;
variance = rand(N,1)*4;
location_x = zeros(N,T);
location_y = zeros(N,T);
location = zeros(N,T);

%-----------overall available utility-------------
utility_max = sum(value)*T;



%---------------ALGORITHM-ONE---------------------
%-------------random movements--------------------
utility_alg1_rand3 = alg1_rand_3dir(threshold,T,L,M,value,N,...
    variance,location_x,location_y,location);

utility_alg1_rand5 = alg1_rand_5dir(threshold,T,L,M,value,N,...
    variance,location_x,location_y,location);

%---------------------QASP------------------------
utility_alg1 = alg1(threshold,T,L,M,value,N,...
    variance);

%---------------------QASP-OPT--------------------
utility_alg1_opt = alg1_opt(threshold,T,L,M,value,N,...
    variance);



% %---------------ALGORITHM-TWO---------------------
% %-------------------Prepare for QASP-S------------
% for i = 1:N  %calculate starting location
%    location_x(i,1) = randi([1,L]);
%    location_y(i,1) = randi([1,L]);
%    location(i,1) = location_x(i,1) + L*(location_y(i,1)-1);
% end
% %----------------------random---------------------
% utility_alg2_rand3 = alg2_rand_3dir(threshold,T,L,M,value,N,...
%     variance,location_x,location_y,location);
% 
% utility_alg2_rand5 = alg2_rand_5dir(threshold,T,L,M,value,N,...
%     variance,location_x,location_y,location);
% 
% %---------------------QASP-S----------------------
% gamma = 50;
% utility_alg2 = alg2(threshold,T,L,M,value,N,...
%    variance,location_x,location_y,location,gamma);
% 
% %---------------------QASP-S-OPT------------------
% utility_alg2_opt = alg2_opt(threshold,T,L,M,value,N,...
%    variance,location_x,location_y,location);



% %-------------------Prepare for QASP-SD-----------
% for i = 1:N
%     % calculate starting location
%     location_x(i,1) = randi([1,L]);
%     location_y(i,1) = randi([1,L]);
%     location(i,1) = location_x(i,1) + L*(location_y(i,1)-1);
%     
%     % calculate ending location
%     [location_x(i,T), location_y(i,T)] ...
%         = cal_des(location_x(i,1),location_y(i,1),T,L);
%     location(i,T) = location_x(i,T) + L*(location_y(i,T)-1);
% end
% 
% %----------------------random---------------------
% utility_alg3_rand = alg3_rand(threshold,T,L,M,value,N,...
%     variance,location_x,location_y,location);
% 
% %--------------------QASP-SD----------------------
% psi = 100;
% tic
% utility_alg3 = alg3(threshold,T,L,M,value,N,...
%     variance,location_x,location_y,location,psi);
% toc
% 
% %--------------------QASP-SD-OPT------------------
% utility_alg3_opt = alg3_opt(threshold,T,L,M,value,N,...
%     variance,location_x,location_y,location);









