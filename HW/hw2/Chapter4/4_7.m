# 7. A pair of fair dice are to be continually rolled until all the possible outcomes
# 2, 3, . . . , 12 have occurred at least once. Develop a simulation study to estimate
# the expected number of dice rolls that are needed.

function roll = play()
	count =0 ;
	hit = zeros(1,12);  	
	iter = 0;
	while count <11			# 1 is not a possible result
		u1= floor(6*rand(1))+1;
		u2= floor(6*rand(1))+1;
		sum = u1+u2;
		if hit(sum)== 0
			hit(sum)=1;
			count = count +1; 
		end
		iter = iter+1 ;
	end
	roll = iter;
end


	
nSim = 1000



result=zeros(1,nSim)
for iter= 1:nSim
	result(iter)=play();
end

disp([mean(result) 2*std(result)/sqrt(nSim)]);




