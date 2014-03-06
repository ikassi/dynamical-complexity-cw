function [] = SimulateTrials(n,time)
%SimulateTrials Produces and stores MFR for n trials 
%   Takes number of trials n and time per trial
assert(time>1000);
if nargin < 3
    i = 1;
end
j = i+ n -1;
mkdir('Q2');
mkdir('./Q2/NC');
if exist('./Q2/NC/nc.mat')
    nc = importdata('./Q2/NC/nc.mat');
else
    nc = [];
end

ps = rand(1,n)*0.4 + 0.1;
indices = i:j;
nuc = zeros(1,n);
swi = zeros(1,n);
parfor i = 1:n
    p = ps(i);    
    CIJ = BuildTopology(p);
    layer = ConnectNetwork(CIJ);    
    firings = Simulate(layer,time);        
    MFR = MeanFiringRate(firings,50,20);          
    DMFR = MFR(:,51:length(MFR));      
    % double deferencing to make it covariance stationary
    SMFR = aks_diff(aks_diff(DMFR));     
    nuc(i) = NeuralComplexity(SMFR);
    swi(i) = SmallWorldIndex(CIJ(1:800,1:800));
    prb(i) = p;
end
nc = [nc ; [prb' swi' nuc']];
save(['./Q2/NC/nc.mat'],'nc');


end
