%%%%%
%Script for testing if the output of phaseone is always an optimal BFS
%%%%%
L=10;
outliers = [];
results = cell(L+1,4);
results{1,1} = 'L';
results{1,2} = 'T/F';
results{1,3} = 'initialIters';
results{1,4} = 'iters';
for l=1:L
   [L,foo,initialIters,iters] = bfstest(l);
   results{l+1,1} = L;
   results{l+1,2} = foo;
   results{l+1,3} = initialIters;
   results{l+1,4} = iters;
   if foo == false
       outliers=[outliers, L];
   end
end