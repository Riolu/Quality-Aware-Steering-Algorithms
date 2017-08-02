

% globel variables:
threshold = 1;
T = 10;

% locations:
L = 20; % square L*L area
M = L*L;
value = randi([1,5],M,1);

% users:
N = 30;
variance = rand(N,1)*4;
location_x = zeros(N,T);
location_y = zeros(N,T);
location = zeros(N,T);

%-----------overall available utility-------------
utility_max = sum(value)*T;

%-------------random movements--------------------
utility_rand = rand_alg(threshold,T,L,M,value,N,...
    variance,location_x,location_y,location);

%---------------------QASP------------------------
utility_alg1 = alg1(threshold,T,L,M,value,N,...
    variance);

%---------------------QASP-S----------------------
%gamma = 50;
%utility_alg2 = alg2(threshold,T,L,M,value,N,...
%    variance,location_x,location_y,location,gamma);

%--------------------QASP-SD----------------------
psi = 100;
tic
utility_alg3 = alg3(threshold,T,L,M,value,N,...
    variance,location_x,location_y,location,psi);
toc









