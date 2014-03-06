function [firings] = Simulate(layer,time)

    N1 = layer{1}.rows;
    M1 = layer{1}.columns;
    MN = M1*N1;

    N2 = layer{2}.rows;
    M2 = layer{2}.columns;

    Dmax = 20; % maximum propagation delay
    Tmax = time; % simulation time per episode
    
    % Initialise layers
    for lr=1:length(layer)
       layer{lr}.v = -65*ones(layer{lr}.rows,layer{lr}.columns);
       layer{lr}.u = layer{lr}.b.*layer{lr}.v;
       layer{lr}.firings = [];
    end
    
    % SIMULATE
    for t = 1:Tmax
      % Display time every 10ms
      if mod(t,10) == 0
         t
      end
      
      % Deliver a Poisson spike stream
      lambda = 0.01; % was 0.001
      layer{1}.I = 15*(poissrnd(lambda,N1,M1) > 0);
      layer{2}.I = zeros(N2,M2);
      
      % Deliver a single spike to a single neuron
      if t == 1
         i = ceil(rand*N1);
         j = ceil(rand*M1);
         layer{1}.I(i,j) = 15;
      end
      
      % Update all the neurons
      for lr=1:length(layer)
         layer = IzNeuronUpdate(layer,lr,t,Dmax);
      end 
    end         
    firings = layer{1}.firings;
end
