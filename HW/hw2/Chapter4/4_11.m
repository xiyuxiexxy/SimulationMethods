#11. Give an efficient method for generating a random subset of size r from the set
# {1, . . . , n} conditional on the event that the subset contains at least one of the
# elements of {1, . . . , k} when r and k much smaller than n.


# choose 1 random number of 1..k, swap with n
# then run permutation on n-1,..., n-r+1


function set = subset(x, r, k)
	n= length(x);
	j = floor(k* rand(1))+1;

	tmp= x(j);
	x(j)=x(n);
	x(n)=tmp;

	for iter = 1: r-1
		
		ind = n-iter;
		j= floor(ind*rand(1))+1;
	
		tmp= x(j);
		x(j)=x(ind);
		x(ind)=tmp;
	
	end

	set = x(n-r+1:n);

end

x = 1:10;

set = subset(x, 6, 3)





