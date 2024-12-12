function b = findb(D,S,ratings,r,K,L)
%%%%%%%%%%%%%%%%%%
%Function to find b vector for standard form from the Demand vector, Solar
%array normalized output, r total solar array rating in kW,M vector of maximum load values for the generators and L time steps
%
%%%%%%%%%%%%%%%%
    b = preprocess(D,S,r);
    n = K*L;
    for k=1:K
        for l=1:L
            % i = l + L*(k-1);
            b = [b;ratings(k)];
        end
    end
end