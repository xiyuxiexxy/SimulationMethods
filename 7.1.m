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



function [A D]= Server(T, lamda)

	t= 0;
	n = 0;
	na = 0;
	nd = 0;
	td = inf;
	ti = 0;
	is = 0;

	A=[];
	D=[];
	
	ta = t- log(rand(1))/lamda;  #next arrival
	
	while t<T	
		if ta <td 	# enqueue;
			n = n+1;
			na = na +1;	
			t = ta;

			A = [A;t];

			ta = t- log(rand(1))/lamda;  #next arrival

			if n==1 
				td = t +Gamma(3, 40);
				ti = ti +t -is; 	#idle ended
			end
		else        # dequeue

			n = n-1;
			nd = nd +1;
			t = td;
			
			D= [D;t];

			if n==0 
				td = inf; 	
				is = t ;		#idle started

			
			else
				td = t + Gamma(3,40);
			end

		end
	end		

	while n>0
		n = n-1;
		nd = nd +1;
		t = td;
			
		D= [D;t];
		if n==0 
			td = inf; 				
		else
			td = t + Gamma(3,40);
		end
	end

	disp([A D]);

	ticheck = A(1);	
	for iter = 2: length(A)
		ticheck = ticheck + max(A(iter)-D(iter-1),0);
	end

	
	printf("idle time %f, %f\n",ti,ticheck);	


end


[A,D]= Server(9,10);




Tin = 0;
To  = 0;

nSim = 100

for iter = 1:nSim
	[A D] = Server(9,10);

	Tin = Tin+ mean(D-A);
	To  = To +max(0, D(length(D))-9);
end

Tin = Tin /nSim 
To = To /nSim


Tin = 0;
To  = 0;

nSim = 1000

for iter = 1:nSim
	[A D] = Server(9,10);

	Tin = Tin+ mean(D-A);
	To  = To + max(D(length(D))-9,0);
end

Tin = Tin /nSim 
To = To /nSim

###############
#nSim =  100
#Tin =  0.21213
#To =  0.22511
####################
#nSim =  1000
#Tin =  0.20952
#To =  0.20698


	
