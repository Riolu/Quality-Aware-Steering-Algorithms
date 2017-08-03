
% globel variables:
threshold = 1;
T = 3;
L = 1; % square L*L area
M = L*L;
N = 1;

umax = 0;
ur3 = 0;
ur5 = 0;
ualg1 = 0;
ualgopt = 0;
ITER = 1000;

tic
parfor count = 1:ITER
    
% locations:
value = randi([1,5],M,1);

% users:
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


umax = umax + utility_max;
ur3 = ur3 + utility_alg1_rand3;
ur5 = ur5 + utility_alg1_rand5;
ualg1 = ualg1 + utility_alg1;
ualgopt = ualgopt + utility_alg1_opt;

end

umax = umax/ITER;
ur3 = ur3/ITER;
ur5 = ur5/ITER;
ualg1 = ualg1/ITER;
ualgopt = ualgopt/ITER;

toc