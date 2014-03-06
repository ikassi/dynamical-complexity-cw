function [ CIJ ] = BuildTopology(p)
%BuildTopology creates the topology of the ex with rewiring probability p
CIJ = [];
% create 8 modules of 100 excitatory neurons 
% (with 1000 randomly assigned 1-way connections)
for i=1:8
    n = NetworkDirectedRandom(100,1000);
    CIJ = ExpandNetwork(CIJ,n);
end
% rewire
CIJ = RewireNetwork(CIJ,8,p);
% create 1 module of 200 inhibitory neurons (disconnected)
CIJ = ExpandNetwork(CIJ,zeros(200,200));

% excitatory-to-inhibitory
% each inhibitory neuron has connections from four excitatory neurons
% (all from the same module)
for j= 801:1000
    md = randi([0,7]);
    rs = randi([1,100],1,4);
    while (length(unique(rs)) ~= length(rs))
        rs = randi([1,100],1,4);
    end
    i = md*100*ones(1,4) + rs;
    CIJ(i,j) = 1;
end
assert(sum(sum(CIJ(1:800,801:1000))) == 800);
% -- DIFFUSE -- 
% every inhibitory neuron projects to every neuron in the whole network
CIJ(801:1000,1:1000) = 1;
end

