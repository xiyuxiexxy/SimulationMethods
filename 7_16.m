# 16. Messages arrive at a communications facility in accordance with a Poisson
# process having a rate of 2/hour. The facility consists of three channels, and an
# arriving message will either go to a free channel if any of them are free or else
# will be lost if all channels are busy. The amount of time that a message ties up
# a channel is a random variable that depends on the weather condition at the
# time the message arrives. Specifically, if the message arrives when the weather
# is “good,” then its processing time is a random variable having distribution
# function
# F(x) = x, 0 < x < 1
# whereas if the weather is “bad” when a message arrives, then its processing
# time has distribution function
# F(x) = x^3 , 0 < x < 1
# Initially, the weather is good, and it alternates between good and bad periods—
# with the good periods having fixed lengths of 2 hours and the bad periods
# having fixed lengths of 1 hour. (Thus, for example, at time 5 the weather
# changes from good to bad.)
# Suppose we are interested in the distribution of the number of lost messages
# by time T = 100.
# (a) Define the events and variables that enable us to use the discrete event
# approach.
# (b) Write a flow diagram of the above.
# (c) Write a program for the above.
# (d) Verify your program by comparing an output with a hand calculation.
# (e) Run your program to estimate the mean number of lost messages in the
# first 100 hours of operation.

function t = G(x)

	if  mod(x,3) <2 	# good
		t = rand(1);	# F(x)=x
	else			# bad	
		t = rand(1)^(1/3);	# F(x)= x^3
	end
end


function nl = Channel(T, lamda)

	t = 0;
	c = zeros(3,1);
	nl =0;
	
	tds= ones(3,1);
	tds= tds*inf;

	ta = t-log(rand(1))/lamda;


	while t < T 

		td = min(tds);
		cid= find(tds==td)(1);

		if ta < td
			
			t = ta;
			
			if(length(find(c==0)) == 0)  # no free channel
				printf("no free channel, msg lost\n");
				nl = nl+1;
			else
				cid = find(c==0)(1);
				c(cid)= c(cid)+1;
				tds(cid) = t + G(t);
			end

			ta = t-log(rand(1))/lamda;
		else	
			
			t = td;
			c(cid) =c(cid)-1;
			tds(cid) = inf;
		end
	end
end

nl = Channel(100,2)
			
		
				
		









	
