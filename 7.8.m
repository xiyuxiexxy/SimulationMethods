# 8. In the model of Section 7.4, suppose that G 1 is the exponential distribution
# with rate 4 and G 2 is exponential with rate 3. Suppose that the arrivals are
# according to a Poisson process with rate 6. Write a simulation program to
# generate data corresponding to the first 1000 arrivals. Use it to estimate
# (a) the average time spent in the system by these customers.
# (b) the proportion of services performed by server 1.
# (c) Do a second simulation of the first 1000 arrivals and use it to answer
# parts (a) and (b). Compare your answers to the ones previously obtained.

function t = G1()
	t = -log(rand(1))/4;
end

function t = G2()
	t = -log(rand(1))/3;
end



function t = G(x)
	if x ==1
		t= G1();
	else
		t = G2();
	end;
end

function [T P1]= Server(N, lamda)


	t= 0;
	n = 0;
	na = 0;
	nd = 0;

	c = zeros(2,1);


	tds = ones(2,1);
	tds = tds*inf;



	
	A=[];
	D=[];
	S=[];
	
	ta = t- log(rand(1))/lamda;  #next arrival

		
	
	while na < N
		
		td = min(tds);
		sid = find(tds ==td)(1);

		

		if ta <td 	# enqueue;
			n = n+1;
			na = na +1;	
			t = ta;

			A = [A;t];

			

			if c(1)==0 
				tds(1) = t +G1();
				c(1) = c(1)+1;
			else
				if c(2) == 0	
					tds(2) = t +G2();
					c(2) = c(2) +1;
				end

			end
		
			ta = t- log(rand(1))/lamda;  #next arrival

		else        # dequeue

			n = n-1;
			nd = nd +1;
			t = td;
			D= [D;t];
			S =[S;sid];
			c(sid) =c(sid)-1;


		

			if n<2
				tds(sid) = inf; 	

			else
				tds(sid) = t + G(sid);
				c(sid) =c(sid)+1;
			end

			

		end
	end		

	
	while n>0

		td = min(tds);
		sid = find(tds ==td)(1);

		n = n-1;
		nd = nd +1;
		t = td;
			
		
		D= [D;t];
		S =[S;sid];
		c(sid) =c(sid)-1;


		if n<2
			tds(sid) = inf; 	

		else
			tds(sid) = t + G(sid);
			c(sid) =c(sid)+1;
		end
	end

	printf("length of A %d length of D%d, na %d, nd %d\n, n%d\n",length(A),length(D),na, nd, n);
	T = mean(D-A);

	P1 = length(find(S==1))/N;
end

[T,P1]=Server(1000,6)

[T,P1]=Server(1000,6)


###############
# T =  0.84445
# P1 =  0.56300
###################
# T =  0.92040
# P1 =  0.59600






