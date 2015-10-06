function [A D Tp] = snglsv( T, lam )
% Single-Server Q Simulation 
%  Input T = Total time, with Exp(1/lam) interarrivals
%  Outputs A,D  arrival,departure time arrays, Tp = overtime.
  t = 0; na = 0; nd = 0; n = 0;
  ta = -log(rand)/lam; td = inf;
  while ta <= T % time left for more arrivals
    if ta <= td, t = ta; n = n + 1; % new arrival

      na = na + 1; A(na) = t; ta = t - log(rand)/lam; 


      if n == 1, td = t + G; end, 
    else, t = td; n = n - 1; nd = nd + 1; D(nd) = t; % departure
      if n >  0, td = t + G; else, td = inf; end
    end
  end % no more arrivals, empty the Q
  while n > 0, t = td; nd = nd + 1; D(nd) = t; 
    n = n - 1; td = t + G; 
  end, Tp = max(t-T,0);
% end snglsv
function Y = G;  % Uniform between .2 and .3
   Y =  .2 + .1*rand; 
% end uniform(1,2)
  
