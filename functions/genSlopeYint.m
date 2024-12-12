function [m, b] = genSlopeYint(ratings)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Produces slope and y-intercept for generator ratings array 
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b = 0.0940.*(ratings.^-0.2735);
m = 0.4234.*(ratings.^-0.1012);
end