function [c,p] = findc(ratings,L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Preprocessing function to produce c and b for use with simplex. 
% Only c is necessary, but p might be useful at the end to get back to the
% actual value of the objective function.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    K = length(ratings);
    n = K*L;
    [m,yInt] = genSlopeYint(ratings);
    c = zeros(n,1);
    p = zeros(n,1);
    for k=1:K
        for l=1:L
            i = l + L*(k-1);
            c(i) = m(k);
            p(i) = yInt(k);
        end
    end
end