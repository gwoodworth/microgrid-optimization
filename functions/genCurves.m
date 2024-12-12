function g = genCurves(x,m,b,K,L)
    %%%%%%%%%%%%%%%%
    %produces generator fuels curves, L/kWh for an array of generators,
    %specified by ratings above, and k is the number of generators
    %%%%%%%%%%
    g = m.*x+b;
    for l=1:L
        sum = 0;
        for k=1:K
            i=l+L*(k-1);
            sum = sum + g(i);
        end
        g(l) = sum;
    end
    g = g(1:L);
end

