# 4.4
# A deck of 100 cards—numbered 1, 2, . . . , 100—is shuffled and then turned
# over one card at a time. Say that a “hit” occurs whenever card i is the ith card
# to be turned over, i = 1, . . . , 100. Write a simulation program to estimate the
# expectation and variance of the total number of hits. Run the program. Find
# the exact answers and compare them with your estimates.


#####################################
function cards = permutation(x)
	n= length(x);
	for (iter= 0:n-2)
		k=n-iter;
		u= rand(1);
		j= floor(k*u)+1;
		tmp= x(j);
		x(j)=x(k);
		x(k)=tmp;
	end
	cards=x
end

A=1:100;


function hit = play(A)
	cards= permutation(A);
	n= length(cards);	
	for iter= 1:n
		if iter== cards(iter)
			hit= 1;
			return ;
		end
	end
	hit=0;
end



nSim= 1000;

result=zeros(1,nSim)
for iter= 1:nSim
	result(iter)=play(A);
end

disp([mean(result) 2*std(result)/sqrt(nSim)]);





	
