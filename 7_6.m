# 5. Consider a single-server queueing model in which customers arrive according
# to a nonhomogeneous Poisson process. Upon arriving they either enter service
# if the server is free or else they join the queue. Suppose, however, that each
# customer will only wait a random amount of time, having distribution F,
# in queue before leaving the system. Let G denote the service distribution.
# Define variables and events so as to analyze this model, and give the updating
# procedures. Suppose we are interested in estimating the average number of lost
# customers by time T , where a customer that departs before entering service is
# considered lost.

# 6. Suppose in Exercise 5 that the arrival process is a Poisson process with rate
# 5; F is the uniform distribution on (0, 5); and G is an exponential random
# variable with rate 4. Do 500 simulation runs to estimate the expected number
# of lost customers by time 100. Assume that customers are served in their order
# of arrival.




function Ta = Poission(T, lamda)

	Ta = [];
	t =- log(rand(1))/lamda ;
	while t < T
		Ta= [Ta;t];
		t = t- log(rand(1))/lamda ;
	end
end


function nleft = Server(T, lamda)

	Ta = Poission(T, lamda); 	# arrival time		

	n  = length(Ta);
			
	Ts = zeros(n,1);		# Server Start time

	Td = zeros(n,1);		# Depart time
	
	Ti = zeros(n,1);		# Idle time


	Ts(1) = Ta(1);

	G = -log(rand(1))/4;

	Td(1) = Ts(1)+G;

	Ti(1) = Ta(1);

	Tw(1) =0;

	left = zeros(n,1);
	for iter = 2:n
		Ts(iter) = max(Td(iter-1), Ta(iter));

		Tw(iter) = Ts(iter)- Ta(iter);

		F = 5*rand(1);

		if Tw(iter) > F
			#fprintf("client %d Waiting Time %f, Queueing Time  %f are leaving \n",iter, F, Tw(iter));
			Td(iter) = Td(iter-1);
			left(iter) =1;
		else 		
			G = -log(rand(1))/4;
			Td(iter) = Ts(iter) + G;

		end
	
	end

	#fprintf("total client  %d left %d\n", n, sum(left));
	
	nleft = sum(left);
end


	
nSim = 500
	
avgleft = 0;

for iter = 1:nSim
	avgleft = avgleft + Server(100,5);
end	

avgleft = avgleft /nSim 
	
# answer 

# nSim = 500
# avgleft =  120.22




