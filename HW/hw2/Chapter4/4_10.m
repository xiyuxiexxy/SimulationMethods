#10. The negative binomial probability mass function with parameters (r, p), where
# r is a positive integer and 0 < p < 1, is given by

# (a) Use the relationship between negative binomial and geometric random
# variables and the results of Example 4d to obtain an algorithm for
# simulating from this distribution.


#  Negative binomial is number of trails when r success happened
#  So generate r Geometric random value, the sum of them is the Negative binomial


function g = Geo(p)
	q= 1-p;
	u =rand(1);
	g= floor(log(u)/log(q))+1;	
end


function neg = NegBin(r, p)
	neg = 0;
	for iter = 1: r
		neg = neg + Geo(p);
	end
end

#(b) Verify the relation

#	See attached sheet

#(c) Use the relation in part (b) to give a second algorithm for generating
# negative binomial random variables.
	

function neg = NegBin2(r, p)
	j = r ;
	pr= p^r;	  

	F = pr; 
	u = rand(1);

	while u >= F
		alpha = j*(1-p)/(j+1-r) ;  
		pr = alpha *pr;
		F = F+ pr;
		j = j+1;
	end
	neg =j
end

# n = NegBin2(1, 0.4);	
	

#(d) Use the interpretation of the negative binomial distribution as the number
#of trials it takes to amass a total of r successes when each trial
#independently results in a success with probability p, to obtain still another
#approach for generating such a random variable.

# generate sequence of bernouli trails until the r number of success 

function neg = NegBin3(r, p)

	count = 0;
	iter = 0;
	while count <r
		u= rand(1);
		if u>p
			count = count +1;
		end
		iter = iter +1;
	end
end
