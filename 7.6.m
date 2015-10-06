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

function x = F()
	x= 5*rand(1);
end

function x= G()
	x = -log(rand(1))/4;
end


function nleft = Server(T, lamda)

	t= 0;
	n = 0;
	na = 0;
	nd = 0;
	td = inf;
	

	A=[];
	D=[];
	
	
	ta = t- log(rand(1))/lamda;  #next arrival
	
	while t<T

		if ta <td 	
			n = n+1;
			na = na +1;	
			t = ta;

			A = [A;t];

			ta = t- log(rand(1))/lamda;  #next arrival

			if n==1 
				td = t +G();
			end
		else
			n = n-1;
			nd = nd +1;
			t = td;
			
			D= [D;t];

			
			while n > 0
					
				tw = A(nd+1)+ F();
				#printf("client arrival at %f, wait %f, now %f \n",A(nd+1),tw, t);
					
				if tw <t

					#printf("client quited \n");
					n = n-1;
					nd = nd +1;
					D= [D;-1];
					
				else
					#printf("Client waiting is serverd\n");
					td = t + G();
					break;
					
				end
			end
			if n==0 
				td = inf; 
			end

		end
	end		

	while n>0
		n = n-1;
		nd = nd +1;
		t = td;	
		D= [D;t];

		
		while n>0
					
			tw = A(nd+1)+ F();
			#printf("client arrival at %f, wait %f, now %f \n",A(nd+1),tw, t);
	
			if tw <t

				#printf("client quited \n");
				n = n-1;
				nd = nd +1;
				D= [D;-1];
					
			else
				#printf("Client waiting is serverd\n");
				td = t + G();
				
				break;
			end
		end
		if n==0 
			td = inf; 
		end
	end


	

	nleft = length(find(D==-1));

end

nleft =Server(100,5);

	
nSim = 500
	
avgleft = 0;

for iter = 1:nSim
	avgleft = avgleft + Server(100,5);
end	

avgleft = avgleft /nSim 


####################
# nSim =  500
# avgleft =  119.59
###########################
