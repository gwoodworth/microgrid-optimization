function A = findA(K,L)
%%%%%%%%%%%%%
    %Function to find constraint matrix A where there are K generators
% L is number of time steps
    %%%%%%%%
    A = eye(L);
    n = K*L;
    for k=2:K
        A = [A eye(L)];
    end
    A = [A zeros(L,n);eye(n) eye(n)];
end