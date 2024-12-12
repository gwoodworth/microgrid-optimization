function g = genCurves(x,m,b)
    %%%%%%%%%%%%%%%%
    %produces generator fuels curves, L/kWh for an array of generators,
    %specified by ratings above
    %%%%%%%%%%
    g = m.*x+b;
end

