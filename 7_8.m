# 8. In the model of Section 7.4, suppose that G 1 is the exponential distribution
# with rate 4 and G 2 is exponential with rate 3. Suppose that the arrivals are
# according to a Poisson process with rate 6. Write a simulation program to
# generate data corresponding to the first 1000 arrivals. Use it to estimate
# (a) the average time spent in the system by these customers.
# (b) the proportion of services performed by server 1.
# (c) Do a second simulation of the first 1000 arrivals and use it to answer
# parts (a) and (b). Compare your answers to the ones previously obtained.



function Ta = Poission(n, lamda)

	Ta = zeros(n,1);
	t = 0 ;
	for iter= 1:n
		t = t- log(rand(1))/lamda ;
		Ta(iter) = t;
	end
end



function g = G(x)

	if x == 1
		g = -log(rand(1))/4;
	else
		g = -log(rand(1))/3;
	end
end	
 



function Tin = Server(n, lamda)  

	Ta = Poission(n, lamda); 	# arrival time for the first n client

	
	nServer= 2;

	Tw = zeros(2, 1) ;	# Server working time 

	Td = zeros(n,1);		# Depart time
	
	Sid = zeros(n,1);

	Ts = zeros(n,1);		# Start Servering time

	for iter = 1: n
		iSer= 0;
				
		if(Tw(1)<=Tw(2))			# choose the server end the first
			iSer = 1;
		else
			iSer = 2;
		end

		Sid(iter) = iSer;

		# fprintf("clinet %d choosing  Server  %d\n", iter, iSer);
	
		Ts(iter) = max(Tw(iSer), Ta(iter));   		        # Start when server free or arrived

		Td(iter) = Ts(iter) + G(iSer) ;				# Depart time for client 

		Tw(iSer) = Td(iter); 					# iSer is free at this time
		
	end	

	Tin = mean(Td-Ta)
	pSer2 = sum(Sid-1);
	pSer1 = n-pSer2
	
end


Server(1000,6);


# answer 
# Tin =  1.0449
# pSer1 =  541/1000 

# run again
# Tin =  1.7768
# pSer1 =  578/1000



