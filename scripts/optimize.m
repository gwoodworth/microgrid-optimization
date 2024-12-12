
%load data, once per session
% TTD = readtimetable(...
%     'data/electrical_load_generic_peak-500kW_1yr_dt-1hr.csv'...
%     ); %Electrical demand as a timetable
% TTS = readtimetable(...
%     'data/normalized_solar_production.csv'...
%     ); %Normalized solar array output for a year

%Set parameters
ratings = [100,150,250]; % Ratings for diesel generators in kW, one for each generator
r = 250; %Total Solar PV array rating
L = 1; %number of timesteps

K = length(ratings); %number of diesel generators
n = K*L; %problem dimension, 

m = L+n; %number of constraints after adding slacks
n = 2*n; %dimension after adding slacks

%Convert to standard form
D = TTD.ElectricalLoad_kW_(1:L); % Trim demand data
S = TTS.NormalizedProduction__(1:L); % Trim solar data
c = findc(ratings,L); % Find c for c^Tx
A = findA(K,L); %Find constraint matrix A
b = findb(D,S,ratings,r,K,L);%Find b for Ax=b

%Find an initial solution
x = [zeros(n-m,1);b]; %non-degenerate basic feasible solution using slack variables

%run simplex
[x,z,iters] = sfsimplex(c,A,b,x,true,10)