# 1. Write a program to generate the desired output for the model of Section 7.2.
# Use it to estimate the average time that a customer spends in the system and
# the average amount of overtime put in by the server, in the case where the
# arrival process is a Poisson process with rate 10, the service time density is
# g(x) = 20e−40x (40x)2 , x > 0
# and T = 9. First try 100 runs and then 1000.


# 2. Suppose in the model of Section 7.2 that we also wanted to obtain information
# about the amount of idle time a server would experience in a day. Explain how
# this could be accomplished.




function Y= Gamma(n, lamda)
	Y= 0;
	for iter = 1:n
		Y = Y -log(rand(1))/lamda;
	end

	
end



function Ta = Poission(T, lamda)

	Ta = [];
	t =- log(rand(1))/lamda ;
	while t < T
		Ta= [Ta;t];
		t = t- log(rand(1))/lamda ;
	end
end


function [Tin To]= Server(T, lamda)


	Ta = Poission(T, lamda); 	# arrival time		

	n  = length(Ta);
			
	Ts = zeros(n,1);		# Server Start time

	Td = zeros(n,1);		# Depart time
	
	Ti = zeros(n,1);		# Idle time


	Ts(1) = Ta(1);

	Td(1) = Ts(1) + Gamma(3, 40);

	Ti(1) = Ta(1);


	for iter = 2:n
		Ts(iter) = max(Td(iter-1), Ta(iter));
		Td(iter) = Ts(iter) + Gamma(3,40) ;

		Ti(iter) = Ts(iter)- Td(iter-1);
	end

	Tin = mean(Td-Ta);
	To = Td(n)-T;

	#fprintf("Tin %f, To %f, Td(n) %f\n", Tin, To, Td(n) );
	
	# disp([Ta Td Ti])
	
	
end 

	
nSim = 1000 
	
avgTin = 0;
avgTo = 0; 
for iter = 1:nSim
	[Tin To] = Server(9,10);	
	
	
	avgTin = avgTin + Tin;
	avgTo = avgTo + To;
end

avgTin = avgTin /nSim 
avgTo = avgTo /nSim

# answer 

# nSim =  100
# avgTin =  0.19499
# avgTo =  0.12490

# nSim =  1000
# avgTin =  0.20564
# avgTo =  0.13217



	
			
	
