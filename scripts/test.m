%%%%%
%Script for testing if the output of phaseone is always an optimal BFS
%%%%%
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
L=168;
outliers = [];
results = cell(L+1,4);
results{1,1} = 'L';
results{1,2} = 'T/F';
results{1,3} = 'initialIters';
results{1,4} = 'iters';
for l=1:L
   [L,foo,initialIters,iters] = bfstest(l,TTD,TTS);
   results{l+1,1} = L;
   results{l+1,2} = foo;
   results{l+1,3} = initialIters;
   results{l+1,4} = iters;
   if foo == false
       outliers=[outliers, L];
   end
end