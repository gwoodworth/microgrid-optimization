function outputData = preprocess(D,S,r)
%%%
% Function to prepocess data where D is electrical demand and S is
% normalized solar production, and r is the rating of the solar PV array.
% Performs x = D-S.*r, stores x=max(0,x). Returns leftover electrical
% demand after solar is used. Note: This means curtailing is automatic 
% Args: 
%       D (nx1 matrix): Electrical demand profile, kW
%       S (nx1 matrix): Normalized solar production
%       r (int): Total rating of solar PV array, kW 
% Returns:
%       outputData (nx1 matrix): Preprocessed right hand side of
%       constraints,  kW
%       
%%%
outputData = D-S.*r;
outputData = max(0,outputData);
end

