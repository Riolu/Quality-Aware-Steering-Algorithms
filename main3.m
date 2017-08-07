

% globel variables:
threshold = 1;
T = 3;

% locations:
L = 10; % square L*L area
M = L*L;
value = randi([1,5],M,1);

% users:
N = 1;
variance = rand(N,1)*4;
location_x = zeros(N,T);
location_y = zeros(N,T);
location = zeros(N,T);

%-----------overall available utility-------------
utility_max = sum(value)*T;


tic


%-------------------Prepare for QASP-SD-----------
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

%----------------------random---------------------
%utility_alg3_rand = alg3_rand(threshold,T,L,M,value,N,...
%    variance,location_x,location_y,location);

%--------------------QASP-SD----------------------
psi = 1;

utility_alg3 = alg3(threshold,T,L,M,value,N,...
    variance,location_x,location_y,location,psi);
toc

%--------------------QASP-SD-OPT------------------
%utility_alg3_opt = alg3_opt(threshold,T,L,M,value,N,...
%    variance,location_x,location_y,location);









