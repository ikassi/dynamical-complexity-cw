%SimulateTrials(10,1010);
%[ps MFRS] = LoadTrials;
nc = importdata('./Q2/NC/nc.mat');
nc = nc(1:100,:)

clf;
h = figure(1);
% Plot neural complexity with p
subplot(2,1,1);
plot(nc(:,1),nc(:,3),'.');
title(['Neural Complexity']);
ylabel('Neural Complexity');
xlabel('Rewiring probability p');  

% Plot small-world-index with p
subplot(2,1,2);
plot(nc(:,2),nc(:,3),'.');
title(['Neural Complexity']);
ylabel('Neural Complexity');
xlabel('Small-world Index \sigma');   

 

saveas( h,'./Q2/neural_complexity.fig', 'fig' );

