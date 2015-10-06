
function crush = Repair(n, s)

	#printf("%d machine %d spare\n", n, s);
	crush = 0; 		# 0 no crush , otherwise time when crush happen
		
	tf = zeros(n, 1) ;

	for iter = 1:n
		tf(iter) = -log(rand(1));		# F(x) = 1- exp(-x)
	end

	
	tr = Inf;
	r =0;

	while r<= s+1
		
		tf = sort (tf);
		t1 = tf(1);

		printf("===r %d ==========\n", r);
		disp(tf)
		disp(tr)


		if(t1<tr)
			
			r = r+ 1;
			if(r == s+1 )		 # crush	
				
				crush = t1;  
				return ;
			else	
				
				tf(1) = tf(1) -log(rand(1));    # update the new fail time for this machine 	
			end
		
			if(r==1)
				
				tr = t1-log(rand(1))/2;         # fill r1 		
			end
			
		else
			

			r= r- 1 ;
			
			if r ==0 
				tr= inf;
			else
				tr =  tr -log(rand(1))/2;
				
			end
			
		end
		
	end

end		

 crush = Repair(4, 3)	


nSim = 1000

crush = 0;
	
for iter = 1: nSim
	
	crush = crush + Repair(4, 3);	
end

crush = crush /nSim			


# answer  
# nSim =  1000
# crush =  1.5492



