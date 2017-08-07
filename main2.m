
% globel variables:
threshold = 1;
T = 5;
L = 10; % square L*L area
M = L*L;
N = 3;

utalg2 = 0;
utopt = 0;
utmax = 0;
utr3 = 0;
utr5 = 0;

ITER = 3;
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

%---------------ALGORITHM-TWO---------------------
%-------------------Prepare for QASP-S------------
for i = 1:N  %calculate starting location
   location_x(i,1) = randi([1,L]);
   location_y(i,1) = randi([1,L]);
   location(i,1) = location_x(i,1) + L*(location_y(i,1)-1);
end
%----------------------random---------------------
utility_alg2_rand3 = alg2_rand_3dir(threshold,T,L,M,value,N,...
    variance,location_x,location_y,location);

utility_alg2_rand5 = alg2_rand_5dir(threshold,T,L,M,value,N,...
    variance,location_x,location_y,location);

%---------------------QASP-S----------------------
gamma = 50;
utility_alg2 = alg2(threshold,T,L,M,value,N,...
   variance,location_x,location_y,location,gamma);

%---------------------QASP-S-OPT------------------
utility_alg2_opt = alg2_opt(threshold,T,L,M,value,N,...
   variance,location_x,location_y,location);

utalg2 = utalg2 + utility_alg2;
utopt = utopt + utility_alg2_opt;
utmax = utmax + utility_max;
utr3 = utr3 + utility_alg2_rand3;
utr5 = utr5 + utility_alg2_rand5;

end

utalg2 = utalg2/ITER;
utopt = utopt/ITER;
utmax = utmax/ITER;
utr3 = utr3/ITER;
utr5 = utr5/ITER;

toc