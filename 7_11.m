# 11. Suppose that claims are made to an insurance company according to a Poisson
# process with rate 10 per day. The amount of a claim is a random variable that has
# an exponential distribution with mean $1000. The insurance company receives
# payments continuously in time at a constant rate of $11,000 per day. Starting
# with an initial capital of $25,000, use simulation to estimate the probability
# that the firm’s capital is always positive throughout its first 365 days.


function win = Insurance(T, lamda)
	
	t = 0;
	M = 25000;
	
	while t < T

		ta= - log(rand(1))/lamda ;

		t = t+ ta;

		claim = -1000* log(rand(1));	
		payment= ta * 11000;

		M=  M +payment -claim;		
		if(M<0)
			win = 0;
			return ;
		end
	end

	win =1 ;
end

nSim = 1000


	
pwin=0;
for iter = 1:nSim
	pwin = pwin+ Insurance(365, 10);
end

pwin= pwin/nSim

###############
# nSim =  1000
# pwin =  0.89900

