function [ nc ] = NeuralComplexity(S)
  
  % Find integration
  H_X = 0;
  N = size(S, 1);
  
  for i = 1:N    
    H_X = H_X + find_entropy(S(i, :));
  end

  Integration = H_X - find_entropy(S);
  
  % Find Interaction Complexity
  
  IC = 0;
  
  for i = 1:N
    IC = IC + Mutual_information(i,S);
  end

  IC = IC - Integration;

  nc = IC;
end

