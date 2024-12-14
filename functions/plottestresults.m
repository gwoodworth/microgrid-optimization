function plottestresults(results)
%PLOTTESTRESULTS
x = cell2mat(results(2:end,1));
y = cell2mat(results(2:end,3));
figure;
scatter(x,y,'Color','g')
title('Number of Iterations of phaseone versus Number of Timesteps');
xlabel('L');
ylabel('Number of iterations')
end