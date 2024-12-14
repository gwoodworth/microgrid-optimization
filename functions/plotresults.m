% function plotresults(x,K,L)
%PLOT Plots the results of optimize
%x(vector): K*L vector of generator setpoints
%K (int): Number of generators
%L (int): Number of timestep
% for k=1:K
%     figure;
%     xlabel = k;
%     ylabel = 'setpoint, kW';
%     plot(x(1:k*L),xlabel,ylabel)
%     % hold on
% end
function plotresults(x, K, L, D, S, r)
%PLOTRESULTS Plots the results of optimization
% x (vector): K*L vector of generator setpoints
% K (int): Number of generators
% L (int): Number of timesteps

% Reshape x into a K x L matrix for easier handling
x_matrix = reshape(x, L, K)';

% Loop through each generator and plot its setpoints
for k = 1:K
    figure;
    plot(1:L, x_matrix(k, :), 'LineWidth', 1.5);
    title(['Generator ', num2str(k)]);
    xlabel('Timestep');
    ylabel('Setpoint (kW)');
    grid on;
end
demand = preprocess(D,S,r); %plot demand profile -solar
figure;
plot(1:L,demand,'LineWidth',1.5,'Color','r')
title('Preprocessed Demand Minus Solar');
xlabel('Timestep');
ylabel('Demand (kW)')
end
