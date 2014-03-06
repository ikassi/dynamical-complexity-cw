ps = 0:0.1:0.5;
time = 1000;
ws = 50; % window size - must be greater than or equal to Dmax
ds = 20; % slide window by ds
mkdir('Q1');
mkdir('./Q1/Connectivity');
mkdir('./Q1/Firing_MFR');
f = 1;
for p = ps
    CIJ = BuildTopology(p);
    smi = 1;
    layer = ConnectNetwork(CIJ);    
    firings = Simulate(layer,time);
    MFR = MeanFiringRate(firings,ws,ds);    
    SWI = SmallWorldIndex(CIJ(1:800,1:800));

    % store connectivity matrix
    clf;
    h = figure(1);
    spy(CIJ);  
    title(['Connection Matrix (p = ', num2str(p),', \sigma = ',num2str(SWI),')']);
    xlabel('Neuron Number');
    ylabel('Neuron Number');
   
    saveas( h,['./Q1/Connectivity/CM_' num2str(p) '.fig'], 'fig' );

    sec = 1;
    %Raster plots of firings
    
    
    f = figure(2);
    subplot(2,1,1)
    plot(firings(:,1),firings(:,2),'.')
    title(strcat('p = ',num2str(p),', \sigma = ',num2str(SWI)));
    xlabel(['Time (ms) + ',num2str(sec-1),'s'])
    xlim([0 time])
    ylabel('Neuron number')
    ylim([0 800+1])
    set(gca,'YDir','reverse')
    
    % Plot mean firing rates
    subplot(2,1,2);
    plot(1:ds:time,MFR);
    xlabel(['Time (ms) + ',num2str(sec-1),'s'])
    ylabel('Mean firing rate');    
       
    saveas(f,strcat('./Q1/Firing_MFR/F_MFR_',num2str(p),'.fig'),'fig');   
    close all;
    
end

   