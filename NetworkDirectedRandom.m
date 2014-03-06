function CIJ = NetworkDirectedRandom(N,C)
% Creates a random network with N nodes and C randomly assigned one-way connections
CIJ = zeros(N,N);
for i = 1:C
    f = 0;
    t = 0;
    while f == t || CIJ(f,t) == 1
        f = randi(N);
        t = randi(N);
    end
    CIJ(f,t) = 1;
end