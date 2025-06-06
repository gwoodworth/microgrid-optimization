%load data, once per session
if exist('TTD','var') == 0
    TTD = readtimetable(...
        'data/electrical_load_generic_peak-500kW_1yr_dt-1hr.csv'...
        ); %Electrical demand as a timetable
end
if exist('TTS','var') == 0
    TTS = readtimetable(...
        'data/normalized_solar_production.csv'...
        ); %Normalized solar array output for a year
end
%Set parameters
ratings = [100,150,250]; % Ratings for diesel generators in kW, one for each generator
r = 250; %Total Solar PV array rating
L = 168; %number of timesteps

K = length(ratings); %number of diesel generators
n = K*L; %problem dimension, 

m = L+K*L; %number of constraints after adding slacks
n = 2*n; %dimension after adding slacks

%Convert to standard form
D = TTD.ElectricalLoad_kW_(1:L); % Trim demand data
S = TTS.NormalizedProduction__(1:L); % Trim solar data
[c,p] = findc(ratings,L); % Find c for c^Tx and p, z=c^Tx+p
A = findA(K,L); % Find constraint matrix A
b = findb(D,S,ratings,r,K,L);% Find b for Ax=b

%Find an initial solution
xBFS = phaseone(A,b);
%run simplex
[x,z,iters] = sfsimplex(c,A,b,xBFS,false,10);

%Convert x and z back to original problem
x_og = b(L+1:m)-x(n/2+1:n);
z_og = z+sum(p);